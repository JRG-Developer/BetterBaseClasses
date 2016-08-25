//
//  SetContentViewContainerViewController.swift
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/24/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

import UIKit

class SetContentViewContainerViewController: BaseContainerViewController {

  // MARK: - Actions
  
  @IBAction func replaceBottomViewPressed(sender: AnyObject) {
  
    let contentView = UIView()
    contentView.backgroundColor = UIColor.blueColor()
    setBottomContentView(contentView)
  }
  
  @IBAction func replaceTopViewPressed(sender: AnyObject) {
    let contentView = UIView()
    contentView.backgroundColor = UIColor.blueColor()
    setTopContentView(contentView)
  }
  
  @IBAction func toggleTopViewPressed(sender: AnyObject) {
    
    guard topContainerView!.subviews.isEmpty else {
      setTopContentView(nil, animated: true, completion: nil)
      return
    }
    let contentView = UIView()
    contentView.backgroundColor = UIColor.greenColor()
    setTopContentView(contentView)
  }
  
  @IBAction func toggleBottomViewPressed(sender: AnyObject) {
    
    guard bottomContainerView!.subviews.isEmpty else {
      setBottomContentView(nil)
      return
    }
    let contentView = UIView()
    contentView.backgroundColor = UIColor.redColor()
    setBottomContentView(contentView)
  }
  
  @IBAction func toggleBothPressed(sender: AnyObject) {
    toggleTopViewPressed(sender)
    toggleBottomViewPressed(sender)
  }
}
