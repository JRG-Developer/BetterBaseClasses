//
//  SetViewControllerContainerViewController.swift
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/25/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

import UIKit

class SetViewControllerContainerViewController: BaseContainerViewController {
  
  // MARK: - Actions
  
  @IBAction func toggleTopViewControllerPressed(_ sender: AnyObject) {
  
    guard topViewController == nil else {
      setTop(nil, animated: true, completion: nil)
      return
    }
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.green
    setTop(viewController, animated: true, completion: nil)
  }
  
  @IBAction func replaceTopViewControllerPressed(_ sender: AnyObject) {
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.blue
    setTop(viewController, animated: true, completion: nil)
  }
  
  @IBAction func toggleBottomViewControllerPressed(_ sender: AnyObject) {
    
    guard bottomViewController == nil else {
      setBottom(nil, animated: true, completion: nil)
      return
    }
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.red
    setBottom(viewController, animated: true, completion: nil)
  }
  
  @IBAction func replaceBottomViewControllerPressed(_ sender: AnyObject) {
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.blue
    setBottom(viewController, animated: true, completion: nil)
  }
  
  @IBAction func toggleBothViewControllersPresed(_ sender: AnyObject) {
    
    toggleTopViewControllerPressed(sender)
    toggleBottomViewControllerPressed(sender)
  }
}
