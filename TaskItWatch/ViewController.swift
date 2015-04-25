//
//  ViewController.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 4/6/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreDataShare
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let context = CoreDataManager.sharedInstance.managedObjectContext
    let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: context!)
    let task = Task(entity: entityDescription!, insertIntoManagedObjectContext: context!)
    
    task.descriptionName = "Description"
    task.titleName = "title"
    task.date = NSDate()
    
    CoreDataManager.sharedInstance.saveContext()
    
    var request = NSFetchRequest(entityName: "Task")
    var error: NSError?
    let fetchedResults = CoreDataManager.sharedInstance.managedObjectContext!.executeFetchRequest(request, error: &error)
    println(fetchedResults!.count)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

