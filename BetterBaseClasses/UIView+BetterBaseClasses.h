//
//  UIView+BetterBaseClasses.h
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

#import <UIKit/UIKit.h>

/**
 *  @brief  `UIView+BetterBaseClasses` adds class convenience methods to instantiate a view defined by `bundle` and `nibName` values.
 *
 *  @discussion  You should use this category in combination with subclassing either `BaseView` or `BaseTableViewCell`.
 */
@interface UIView (BetterBaseClasses)

#pragma mark - Identifiers

/**
 *  @brief  This method returns the bundle associated with the view.
 *
 *  @discussion  This method returns the bundle for the class by default.
 *
 *  @return The share conference info bundle
 */
+ (NSBundle *)bundle;

/**
 *  @brief  This method returns the nib name associated with the view.
 *
 *  @discussion  This method returns the name of the view by default.
 *
 *  @return The nib name
 */
+ (NSString *)nibName;

#pragma mark - Instantiation

/**
 *  @brief  Use this method to get a view instantiated from the nib called `nibName` in the given `bundle`.
 *
 *  @return A new instance of this view
 */
+ (instancetype)instanceFromNib;

/**
 *  @brief  Use this method to get the nib associated with the view.
 *
 *  @discussion  This method returns the nib with the `nibName` in the `bundle` by default.
 *
 *  @return The nib associated with the view
 */
+ (UINib *)nib;

#pragma mark - Object Lifecycle

/**
 *  @brief  Use this method to perform common initialization, regardless of the designiated initializer used to create the view.
 *
 *  @discussion  This class leaves it up to subclasses to actually call this method from all designated intializers. If you subclass `BaseView`, `BaseTableViewCell`, or any subclasses thereof, this has alredy been done for you with the default initializers.
 *
 *  @note If you introduce a new designated initializer in your subclass of said classes, you should make sure to call `commonInit` with it.
 */
- (void)commonInit __attribute((objc_requires_super));

@end
