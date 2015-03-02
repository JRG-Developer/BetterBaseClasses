//
//  DynamicFontViewControllerTests.m
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

// Test Class
#import "DynamicFontViewController.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface DynamicFontViewControllerTests : XCTestCase
@end

@implementation DynamicFontViewControllerTests {
  
  DynamicFontViewController *sut;
  
  id notificationCenter;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  
  [super setUp];
  
  sut = [[DynamicFontViewController alloc] init];
}

- (void)tearDown {
  
  [notificationCenter stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockNotificationCenter {
  notificationCenter = OCMPartialMock([NSNotificationCenter defaultCenter]);
}

- (void)givenPartialMock {
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___dealloc___removes_notificationCenterObserver {
  
  // given
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter removeObserver:sut]);
  
  // when
  SEL selector = NSSelectorFromString(@"dealloc");
  
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  [sut performSelector:selector];
#pragma clang diagnostic pop
  
  // then
  OCMVerifyAll(notificationCenter);
}

#pragma mark - View Lifecycle - Tests

- (void)test___viewDidLoad__registerFor_UIContentSizeCategoryDidChangeNotification {
  
  // given
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter addObserver:sut
                                   selector:@selector(contentSizeCategoryDidChange:)
                                       name:UIContentSizeCategoryDidChangeNotification
                                     object:nil]);
  
  // when
  [sut viewDidLoad];
  
  // then
  OCMVerifyAll(notificationCenter);
}

#pragma mark - Dynamic Font Type - Tests

- (void)test___contentSizeCategoryDidChange___calls_refreshViews {

  // given
  [self givenPartialMock];
  OCMExpect([partialMock refreshViews]);
  
  // when
  [sut contentSizeCategoryDidChange:nil];
  
  // then
  OCMVerifyAllWithDelay(partialMock, 0.01);
}

@end
