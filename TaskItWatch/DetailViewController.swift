//
//  DetailViewController.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 4/7/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreDataShare

class DetailViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var bodyTextView: UITextView!
  @IBOutlet weak var doneButton: UIButton!
  
  var task: Task!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupViewWithTask()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelBarButtonItemTapped(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func saveBarButtonItemTapped(sender: UIBarButtonItem) {
    task.titleName = self.titleTextView.text
    task.descriptionName = self.bodyTextView.text
    CoreDataManager.sharedInstance.saveContext()
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  @IBAction func doneButtonPressed(sender: UIButton) {
    TaskHelper.sharedInstance.switchCompletion(self.task)
    updateDoneButton()
  }
  
  func setupViewWithTask() {
    self.titleTextView.text = task.titleName
    self.bodyTextView.text = task.descriptionName
    updateDoneButton()
  }
  
  func updateDoneButton() {
    if task.isCompleted == true {
      doneButton.backgroundColor = UIColor(red: 0.80, green: 0.93, blue: 0.84, alpha: 1.0)
      doneButton.setTitle("X", forState: UIControlState.Normal)
    } else {
      doneButton.backgroundColor = UIColor(red: 0.93, green: 0.80, blue: 0.80, alpha: 1.0)
      doneButton.setTitle("✓", forState: UIControlState.Normal)
    }
  }
}
