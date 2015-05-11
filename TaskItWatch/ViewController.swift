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
  var fetchedResultsController: NSFetchedResultsController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("toAddTaskSegue", sender: nil)
  }

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource
{
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate
{
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
  }
}

// MARK: - FetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate
{
  func setupFetchedResultsController () {
    var fetchRequest = NSFetchRequest()
    var context = CoreDataManager.sharedInstance.managedObjectContext!
    
    let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: context)
    fetchRequest.entity = entity
    
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    
    self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    
    self.fetchedResultsController.delegate = self
    
    var error: NSError? = nil
    if !self.fetchedResultsController!.performFetch(&error) {
      println("An error Occured \(error)")
    }
  }
}
