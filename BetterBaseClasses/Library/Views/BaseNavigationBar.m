//
//  BaseNavigationBar.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 11/20/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

#import "BaseNavigationBar.h"
#import "UIView+BetterBaseClasses.h"

@implementation BaseNavigationBar
  
#pragma mark - Object Lifecycle
  
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) {
    return nil;
  }
  [self commonInit];
  return self;
}
  
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }
  [self commonInit];
  return self;
}
  
- (void)commonInit {
  [super commonInit];
  [self configureNavigationBar:self];
}
  
- (void)configureNavigationBar:(UINavigationBar *)navigationBar {
  // meant to be overriden by subclasses
}
  
@end
