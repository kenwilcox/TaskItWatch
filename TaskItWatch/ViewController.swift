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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("toAddTaskSegue", sender: nil)
  }
}

