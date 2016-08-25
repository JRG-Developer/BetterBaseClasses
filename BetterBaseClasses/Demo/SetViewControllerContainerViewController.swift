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
  
  @IBAction func toggleTopViewControllerPressed(sender: AnyObject) {
  
    guard topViewController == nil else {
      setTopViewController(nil, animated: true, completion: nil)
      return
    }
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.greenColor()
    setTopViewController(viewController, animated: true, completion: nil)
  }
  
  @IBAction func replaceTopViewControllerPressed(sender: AnyObject) {
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.blueColor()
    setTopViewController(viewController, animated: true, completion: nil)
  }
  
  @IBAction func toggleBottomViewControllerPressed(sender: AnyObject) {
    
    guard bottomViewController == nil else {
      setBottomViewController(nil, animated: true, completion: nil)
      return
    }
    
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.redColor()
    setBottomViewController(viewController, animated: true, completion: nil)
  }
  
  @IBAction func replaceBottomViewControllerPressed(sender: AnyObject) {
    let viewController = UIViewController()
    viewController.view.backgroundColor = UIColor.blueColor()
    setBottomViewController(viewController, animated: true, completion: nil)
  }
  
  @IBAction func toggleBothViewControllersPresed(sender: AnyObject) {
    
    toggleTopViewControllerPressed(sender)
    toggleBottomViewControllerPressed(sender)
  }
}
