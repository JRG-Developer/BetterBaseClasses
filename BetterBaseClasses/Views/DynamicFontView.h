//
//  DynamicFontView.h
//  BetterBaseClasses
//
//  Created by Joshua Greene on 3/2/15.
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

#import "BaseView.h"

/**
 *  @brief  `DynamicFontView` is a subclass of `BaseView` that provides support for dynamic font types.
 *
 *  @discussion  This is an abstract, base class meant to be subclassed instead of `UIView`. In addition to the benefits gained by using `BaseView` (see said class header for more details), this class provides support for dynamic font types via its `refreshView` method. You should override this method in your custom subclass in order to reset fonts, etc based on the user's preferred font size.
 */
@interface DynamicFontView : BaseView

/**
 *  @brief  Override this method to refresh views (e.g. set fonts on labels, text views, etc).
 *
 *  @discussion  This message is called on the main thread.
 */
- (void)refreshView;

@end

@interface DynamicFontView (Protected)

/**
 *  @brief  This method is called in response to receiving `UIContentSizeCategoryDidChangeNotification`.
 *
 *  @discussion In general, you should *not* need to override this method. Instead, you should override `refreshViews`.
 *
 *  @param notification The `UIContentSizeCategoryDidChangeNotification` notification
 */
- (void)contentSizeCategoryDidChange:(NSNotificationCenter *)notification;

@end