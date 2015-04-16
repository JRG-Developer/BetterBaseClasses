//
//  BaseTableViewController.h
//  BetterBaseClasses
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

/**
 *  @brief  `BaseTableViewController` is an abstract, base class meant to be subclassed instead of `UIViewController`.
 *
 *  @discussion  Most view controllers will only have *ONE* nib or storyboard scene associated with them. This class, combined with the `UIViewController+BetterBaseClasses` category, lets you specify the `identifier`, `bundle`, and `storyboardName` as part of the class- where it makes more sense for it to be in most cases- and perform common setup code in `commonInit`.
 
 *  This also makes creating and consuming a CocoaPod *much* easier.
 
 *  In example, instead of having to call `initWithNibName: bundle:`, which requires that the consuming app have knowledge of the nib name and the bundle, you can simply call `instanceFromNib`.
 */
@interface BaseTableViewController : UITableViewController

@end
