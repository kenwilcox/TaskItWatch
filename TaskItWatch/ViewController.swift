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
  var wormHole: MMWormhole!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.setupFetchedResultsController()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.wormHole = MMWormhole(applicationGroupIdentifier: GlobalConstants.groupIdentifier, optionalDirectory: "wormhole")
    
    self.wormHole.listenForMessageWithIdentifier(GlobalConstants.taskChangeOnWatch, listener: { (objectPassed) -> Void in
      println(objectPassed)
      var fetchError: NSError?
      self.fetchedResultsController.performFetch(&fetchError)
      self.tableView.reloadData()
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toDetailTaskSegue" {
      let detailVC = segue.destinationViewController as! DetailViewController
      detailVC.task = sender as! Task
      detailVC.delegate = self
    }
  }
  
  @IBAction func addTaskBarButtonItemPressed(sender: UIBarButtonItem) {
    self.performSegueWithIdentifier("toAddTaskSegue", sender: nil)
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource
{
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultsController.sections!.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
    return sectionInfo.numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    let task = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Task
    
    cell.textLabel!.text = task.titleName
    
    if task.isCompleted == true {
      cell.backgroundColor = TaskHelper.getDoneColor()
    } else {
      cell.backgroundColor = TaskHelper.getNotDoneColor()
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate
{
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let task = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Task
    self.performSegueWithIdentifier("toDetailTaskSegue", sender: task)
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    if editingStyle == UITableViewCellEditingStyle.Delete {
      let task = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Task
      TaskHelper.sharedInstance.deleteTask(task)
    }
    
  }
}

// MARK: - FetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate
{
  func setupFetchedResultsController() {
    let fetchRequest = NSFetchRequest()
    let context = CoreDataManager.sharedInstance.managedObjectContext!
    
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
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    self.tableView.reloadData()
  }
}

// MARK: - TaskDetailViewControllerDelegate
extension ViewController: DetailViewControllerDelegate {
  func taskDetailEdited(task: Task) {
    println("taskDetailEdited")
    wormHole.passMessageObject(["completed": task.isCompleted], identifier: GlobalConstants.taskChangeOnPhone)
  }
}