//
//  BaseToolbar.h
//  BetterBaseClasses
//
//  Created by Joshua Greene on 11/21/16.
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

#import "UIView+BetterBaseClasses.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  @brief  `BaseToolbar` is an abstract, base class meant to be subclassed instead of `UIToolbar`.
 *
 *  @dicussion  This class is designed to be used with the `UIView+BetterBaseClasses` category, which adds convenience class instantiation methods and calls `commonInit` from the `UIToolbar` designated initializers.
 */
@interface BaseToolbar : UIToolbar

#pragma mark - Configuration

/**
 *  @brief  Use this method to configure/theme the toolbar.
 *
 *  @discussion  This method is called within `commonInit` and meant to be overriden by subclasses.
 *
 *  @param toolbar The toolbar
 */
+ (void)configureToolbar:(UIToolbar *)toolbar NS_SWIFT_NAME(configure(_:));
  
@end

NS_ASSUME_NONNULL_END
