//
//  DynamicFontTableContainerViewController.h
//  BetterBaseClasses
//
//  Created by Joshua Greene on 3/4/15.
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

#import "BaseViewController.h"

/**
 *  @brief  `DynamicFontTableContainerViewController` is a subclass of `BaseViewController` that provides support for dynamic font types.
 *
 *  @discussion  This is an abstract, base controller meant to be subclassed instead of `UIViewController`. In addition to the benefits gained by using `BaseViewController` (see said class header for more details), this class provides support for dynamic font types via its `refreshViews` method. You should override this method in your custom subclass in order to reset fonts, etc based on the user's preferred font size.
 *
 *  The difference between `DynamicFontTableContainerViewController` and `DynamicFontViewController` is this controller is expected to have a `tableView` has a subview. This is signifiant due to the way responding to font change notifications works- it's dispatched to the main queue to give other views (e.g. table view cells) a chance to update their subviews first before the table view is reloaded.
 */
@interface DynamicFontTableContainerViewController : BaseViewController

#pragma mark - Outlets

/**
 *  @brief  The table view
 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;

#pragma mark - Dynamic Font Type

/**
 *  @brief  Override this method to refresh views (e.g. set fonts on labels, text views, etc).
 *
 *  @discussion This message is called on the main thread.
 *
 *  Prior to this method, `[self.tableView reloadData]` is called.
 */
- (void)refreshViews;

@end

@interface DynamicFontTableContainerViewController (Protected)

/**
 *  @brief  This method is called in response to receiving `UIContentSizeCategoryDidChangeNotification`.
 *
 *  @discussion In general, you should *not* need to override this method. Instead, you should override `refreshViews`.
 *
 *  @param notification The `UIContentSizeCategoryDidChangeNotification` notification
 */
- (void)contentSizeCategoryDidChange:(NSNotificationCenter *)notification;

@end
