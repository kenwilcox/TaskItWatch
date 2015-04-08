//
//  DetailViewController.swift
//  TaskItWatch
//
//  Created by Kenneth Wilcox on 4/7/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var titleTextView: UITextView!
  @IBOutlet weak var bodyTextView: UITextView!
  @IBOutlet weak var doneButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelBarButtonItemTapped(sender: UIBarButtonItem) {
    
  }
  
  @IBAction func saveBarButtonItemTapped(sender: UIBarButtonItem) {
    
  }
  
  @IBAction func doneButtonPressed(sender: UIButton) {
    
  }
  
}
