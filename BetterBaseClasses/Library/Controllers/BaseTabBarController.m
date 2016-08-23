//
//  BaseTabBarController.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/23/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BaseTabBarController.h"
#import "UIViewController+BetterBaseClasses.h"

@implementation BaseTabBarController

#pragma mark - Object Lifecycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) {
    return nil;
  }
  
  [self commonInit];
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (!self) {
    return nil;
  }
  [self commonInit];
  return self;
}

#pragma mark - View Lifecycle

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  
  UIViewController *viewController = self.selectedViewController;
  return viewController != nil ? [viewController preferredInterfaceOrientationForPresentation] :
                                 [super preferredInterfaceOrientationForPresentation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  UIViewController *viewController = self.selectedViewController;
  return viewController != nil ? [viewController preferredStatusBarStyle] : [super preferredStatusBarStyle];
}

- (BOOL)shouldAutorotate {
  UIViewController *viewController = self.selectedViewController;
  return viewController != nil ? [viewController shouldAutorotate] : [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  
  UIViewController *viewController = self.selectedViewController;
  return viewController != nil ? [viewController supportedInterfaceOrientations] : [super supportedInterfaceOrientations];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self configureTabBar:self.tabBar];
}

- (void)configureTabBar:(UITabBar *)tabBar {
  // This method is meant to be overriden by subclasses.
}

@end
