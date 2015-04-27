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
  }
  
  public func switchCompletion(task: Task) {
  }
  
  public func deleteTask (task: Task) {
  }
  
  public func getTasks() -> [AnyObject] {
    return [] as [AnyObject]
  }
}
