//
//  TaskRow.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 5/10/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import WatchKit
import CoreDataShare

protocol TaskRowDelegate {
  func completedButtonWasTapped(tag: Int)
}

class TaskRow: NSObject {
  
  var completion: Bool!
  var tag:Int!
  var delegate:TaskRowDelegate?
  
  @IBOutlet weak var completionButton: WKInterfaceButton!
  @IBOutlet weak var textLabel: WKInterfaceLabel!
  
  @IBAction func completionButtonTapped() {
    
    if self.completion == true {
      self.completion = false
      self.completionButton.setBackgroundColor(TaskHelper.sharedInstance.getNotDoneColor())
    } else {
      self.completion = true
      self.completionButton.setBackgroundColor(TaskHelper.sharedInstance.getDoneColor())
    }
    
    self.delegate?.completedButtonWasTapped(self.tag)
  }
}
