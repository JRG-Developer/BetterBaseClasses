//
//  UIViewController+BetterBaseClasses.h
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

#import <UIKit/UIKit.h>

/**
 *  @brief  `UIViewController+BetterBaseClasses` adds class convenience methods to instantiate a view controller defined by `bundle`, `identifier`, and `storyboardName` values.
 *
 *  @discussion  You should use this category in combination with subclassing either `BaseTableViewController` or `BaseViewController`.
 */
@interface UIViewController (BetterBaseClasses)

#pragma mark - Identifiers

/**
 *  @brief  Override this method to specify the bundle that `instanceFromNib` and `instanceFromStoryboard` should load from.
 *
 *  @discussion This method returns the bundle containing the class by default.
 *
 *  @return The nib bundle to load from
 */
+ (NSBundle *)bundle;

/**
 *  @brief  Override this method to specify the nib name that `instanceFromNib`, or the storyboard identifier that `instanceFromStoryboard`, should load.
 *
 *  @discussion This method returns the last path component of the class name by default.
 *
 *  @return The nib name/storboard identifier to load
 */
+ (NSString *)identifier;

/**
 *  @brief  Use this method to specify the storyboard name that `initFromStoryboard` should load.
 *
 *  @discussion This method returns "Main" by default.
 *
 *  @return The storyboard name to load
 */
+ (NSString *)storyboardName;

#pragma mark - Instantiation

/**
 *  @brief  Use this method to instantiate a new view controller from its nib.
 *
 *  @discussion  This is a convenience constructor that creates a new view controller using the `bundle` and `identifier` return values.
 *
 *  @return A new instance of this controller
 */
+ (instancetype)instanceFromNib;

/**
 *  @brief  Use this method to instantiate a new view controller from its storyboard.
 *
 *  @discussion  This is a convenience constructor that creates a new view controller using the `bundle`, `identifier`, and `storyboardName` return values.
 *
 *  @warning  This method will throw a runtime exception if the storyboard or scene can't be loaded.
 *
 *  @return A new instance of this controller
 */
+ (instancetype)instanceFromStoryboard;

@end
