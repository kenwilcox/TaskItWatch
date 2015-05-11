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
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    updateTasks()
    updateTable()
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
        var theRow = self.table.rowControllerAtIndex(index) as! TaskRow
        let task = self.tasks[index] as! Task
        theRow.textLabel.setText(task.titleName)
        
        if task.isCompleted == true {
          theRow.completionButton.setBackgroundColor(TaskHelper.sharedInstance.getDoneColor())
        } else {
          theRow.completionButton.setBackgroundColor(TaskHelper.sharedInstance.getNotDoneColor())
        }
      }
      
    }
  }
  
  func updateTasks() {
    self.tasks = TaskHelper.sharedInstance.getTasks()
  }
  
}
