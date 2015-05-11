//
//  TaskHelper.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 4/27/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreData

public class TaskHelper: NSObject {
  
  private override init() {

  }
  
  public class var sharedInstance : TaskHelper {
    struct Static {
      static var onceToken : dispatch_once_t = 0
      static var instance : TaskHelper? = nil
    }
    dispatch_once(&Static.onceToken) {
      Static.instance = TaskHelper()
    }
    return Static.instance!
  }
  
  public func insertNewObject(title: String, description: String, date: NSDate) {
    let context = CoreDataManager.sharedInstance.managedObjectContext
    let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: context!)
    let task = Task(entity: entityDescription!, insertIntoManagedObjectContext: context!)
    
    task.descriptionName = description
    task.titleName = title
    task.date = date
    
    CoreDataManager.sharedInstance.saveContext()
  }
  
  public func switchCompletion(task: Task) {
    task.isCompleted = !Bool(task.isCompleted)
    CoreDataManager.sharedInstance.saveContext()
  }
  
  public func deleteTask (task: Task) {
    CoreDataManager.sharedInstance.managedObjectContext?.deleteObject(task)
    CoreDataManager.sharedInstance.saveContext()
  }
  
  public func getTasks() -> [AnyObject] {
    var request = NSFetchRequest()
    request.entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext!)
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    
    var error:NSError? = nil
    var results = CoreDataManager.sharedInstance.managedObjectContext?.executeFetchRequest(request, error: &error)
    
    // TODO: actually handle the error
    println(error?.description)
    
    return results!
  }
}
