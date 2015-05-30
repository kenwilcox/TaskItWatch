//
//  AddTaskViewController.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 4/8/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreDataShare

@objc protocol AddTaskViewControllerDelegate {
  optional func taskAdded(taskName: String)
}

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var bodyTextView: UITextView!
  var delegate: AddTaskViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelBarButtonItemPressed(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func saveBarButtonItemPressed(sender: UIBarButtonItem) {
    TaskHelper.sharedInstance.insertNewObject(self.titleTextView.text, description: self.bodyTextView.text, date: NSDate())
    delegate?.taskAdded!(self.titleTextView.text)
    self.navigationController?.popViewControllerAnimated(true)
  }
}
