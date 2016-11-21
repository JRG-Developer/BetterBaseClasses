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
  
  @IBAction func hideShowBottomViewPressed(_ sender: AnyObject) {
    
    let hidden = bottomContainerViewHeightConstraint!.constant != 0
    setBottomContainerViewHidden(hidden, animated: true, completion: nil)
  }
  
  @IBAction func hideShowTopViewPressed(_ sender: AnyObject) {
    let hidden = topContainerViewHeightConstraint!.constant != 0
    setTopContainerViewHidden(hidden, animated: true, completion: nil)
  }
  
  @IBAction func replaceBottomViewPressed(_ sender: AnyObject) {
  
    let contentView = UIView()
    contentView.backgroundColor = UIColor.blue
    setBottomContentView(contentView)
  }
  
  @IBAction func replaceTopViewPressed(_ sender: AnyObject) {
    let contentView = UIView()
    contentView.backgroundColor = UIColor.blue
    setTopContentView(contentView)
  }
  
  @IBAction func toggleTopViewPressed(_ sender: AnyObject) {
    
    guard topContainerView!.subviews.isEmpty else {
      setTopContentView(nil, animated: true, completion: nil)
      return
    }
    let contentView = UIView()
    contentView.backgroundColor = UIColor.green
    setTopContentView(contentView)
  }
  
  @IBAction func toggleBottomViewPressed(_ sender: AnyObject) {
    
    guard bottomContainerView!.subviews.isEmpty else {
      setBottomContentView(nil)
      return
    }
    let contentView = UIView()
    contentView.backgroundColor = UIColor.red
    setBottomContentView(contentView)
  }
  
  @IBAction func toggleBothPressed(_ sender: AnyObject) {
    toggleTopViewPressed(sender)
    toggleBottomViewPressed(sender)
  }
}
