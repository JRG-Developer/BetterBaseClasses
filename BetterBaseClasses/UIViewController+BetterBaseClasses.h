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

#pragma mark - Preferred Instance

/**
 *  @brief  Use this method to get the "preferred" instance.
 *
 *  @discussion  This method either returns `instanceFromStoryboard` or `instanceFromNib` depending on the value of `preferStoryboards`.
 *
 *  Subclasses may optionally override this method to always return `instanceFromNib` or `instanceFromStoryboard` instead, if desired.
 *
 *  @return The "preferred" instance
 */
+ (instancetype)preferredInstance;

/**
 *  @brief  Use this method to set whether `preferredInstance` should return `instanceFromStoryboard`, if `YES`, or `instanceFromNib`, if `NO`.
 *
 *  @discussion  This value defaults to `NO`.
 *
 *  @warning  This value affects *all* view controllers. You should set it to `YES` if your target uses storyboards more often than nibs.
 *
 *  @param preferStoryboards  Whether or not storyboards are preferred instead of nibs
 */
+ (void)setPreferStoryboards:(BOOL)preferStoryboards;

/**
 *  @brief  Use this method to get whether storyboards are "preferred".
 *
 *  @discussion  This affects the behavior of `preferredInstance`.
 *
 *  @return `YES` to prefer storyboards or `NO` to prefer nibs
 */
+ (BOOL)preferStoryboards;

#pragma mark - Object Lifecycle

/**
 *  @brief  Use this method to perform common initialization, regardless of the designiated initializer used to create the view controller.
 *
 *  @discussion  This class leaves it up to subclasses to actually call this method from all designated intializers. If you subclass `BaseViewController`, `BaseTableViewController`, or any subclasses thereof, this has alredy been done for you with the default initializers.
 *
 *  @note If you introduce a new designated initializer in your subclass of said classes, you should make sure to call `commonInit` with it.
 */
- (void)commonInit __attribute((objc_requires_super));

@end
