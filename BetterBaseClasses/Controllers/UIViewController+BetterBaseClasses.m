//
//  UIViewController+BetterBaseClasses.m
//  BetterBaseControllers
//
//  Created by Joshua Greene on 2/22/15.
//  Copyright (c) 2015 Joshua Greene. All rights reserved.
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

#import "UIViewController+BetterBaseClasses.h"

static BOOL BBC_preferStoryboards = NO;

@implementation UIViewController (BetterBaseClasses)

#pragma mark - Identifiers

+ (NSBundle *)bundle {
  return [NSBundle bundleForClass:[self class]];
}

+ (NSString *)identifier {
  
  NSString *identifier = NSStringFromClass([self class]);
  return identifier.pathExtension.length > 0 ? identifier.pathExtension : identifier;
}

+ (NSString *)storyboardName {  
  return @"Main";
}

#pragma mark - Instantiation

+ (instancetype)instanceFromNib {

  NSBundle *bundle = [[self class] bundle];
  NSString *nibName = [[self class] identifier];
  return [[self alloc] initWithNibName:nibName bundle:bundle];
}

+ (instancetype)instanceFromStoryboard {
  
  NSBundle *bundle = [[self class] bundle];
  NSString *identifier = [[self class] identifier];
  NSString *storyboardName = [[self class] storyboardName];
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
  return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark - Preferred Instance

+ (instancetype)preferredInstance {
  return [self preferStoryboards] ? [self instanceFromStoryboard] : [self instanceFromNib];
}

+ (void)setPreferStoryboards:(BOOL)preferStoryboards {
  BBC_preferStoryboards = preferStoryboards;
}


+ (BOOL)preferStoryboards {
  return BBC_preferStoryboards;
}

#pragma mark - Object Lifecycle

- (void)commonInit {
  // This method is meant to be overriden by subclasses.
}

@end
