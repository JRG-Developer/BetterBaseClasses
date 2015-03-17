//
//  UIView+BetterBaseClasses.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 2/25/15.
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

#import "UIView+BetterBaseClasses.h"

@implementation UIView (BetterBaseClasses)

#pragma mark - Identifiers

+ (NSString *)nibName {
  
  NSString *identifier = NSStringFromClass([self class]);
  return identifier.pathExtension.length > 0 ? identifier.pathExtension : identifier;
}

+ (NSBundle *)bundle {
  return [NSBundle bundleForClass:[self class]];
}

#pragma mark - Instantiation

+ (instancetype)instanceFromNib {
  
  UINib *nib = [self nib];
  return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

+ (UINib *)nib {
  
  NSString *nibName = [self nibName];
  NSBundle *bundle = [self bundle];
  return [UINib nibWithNibName:nibName bundle:bundle];
}

#pragma mark - Object Lifecycle

- (void)commonInit {
  // This method is meant to be overriden by subclasses.
}

@end
