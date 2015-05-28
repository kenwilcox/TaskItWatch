//
//  InterfaceController.swift
//  TaskItWatch WatchKit Extension
//
//  Created by Kenneth Wilcox on 4/8/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import WatchKit
import Foundation
import CoreDataShare

class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var table: WKInterfaceTable!
  var tasks: [AnyObject]!
  var wormHole: MMWormhole!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    updateTasks()
    updateTable()
    
    self.wormHole = MMWormhole(applicationGroupIdentifier: GlobalConstants.groupIdentifier, optionalDirectory: "wormhole")
    
    self.wormHole.listenForMessageWithIdentifier(GlobalConstants.taskChangeOnPhone, listener: { (objectPassed) -> Void in
      println("Interface Controller \(objectPassed)")
      self.updateTasks()
      self.updateTable()
    })
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  func updateTable () {
    if self.tasks.count != 0 {
      
      self.table.setNumberOfRows(self.tasks.count, withRowType: "TaskRowCell")
      
      for var index = 0; index < tasks.count; index++ {
        let theRow = self.table.rowControllerAtIndex(index) as! TaskRow
        let task = self.tasks[index] as! Task
        
        CoreDataManager.sharedInstance.managedObjectContext?.refreshObject(task, mergeChanges: true)
        
        theRow.textLabel.setText(task.titleName)
        theRow.completion = Bool(task.isCompleted)
        theRow.tag = index
        theRow.delegate = self
        
        if task.isCompleted == true {
          theRow.completionButton.setBackgroundColor(TaskHelper.getDoneColor())
        } else {
          theRow.completionButton.setBackgroundColor(TaskHelper.getNotDoneColor())
        }
      }
      
    }
  }
  
  func updateTasks() {
    self.tasks = TaskHelper.sharedInstance.getTasks()
  }
  
}

// MARK: - TaskRowDelegate
extension InterfaceController: TaskRowDelegate {
  func completedButtonWasTapped(tag: Int) {
    var task = self.tasks[tag] as! Task
    TaskHelper.sharedInstance.switchCompletion(task)
    
    wormHole.passMessageObject(["completed": task.isCompleted], identifier: GlobalConstants.taskChangeOnWatch)
  }
}