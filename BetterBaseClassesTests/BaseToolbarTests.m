//
//  BaseToolbarTests.m
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

// System Under Test
#import "BaseToolbar.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface BaseToolbarTests : XCTestCase
@end

@implementation BaseToolbarTests {
  
  BaseToolbar *sut;
  
  id partialMock;
}
  
#pragma mark - Test Lifecycle
  
- (void)setUp {
  [super setUp];
  sut = [BaseToolbar alloc];
}
  
- (void)tearDown {
  [partialMock stopMocking];
  [super tearDown];
}
  
#pragma mark - Given
  
- (void)givenPartialMock {
  partialMock = OCMPartialMock(sut);
}
  
- (void)givenExpectWillCallCommonInit {
  [self givenPartialMock];
  OCMExpect([partialMock commonInit]);
}
  
#pragma mark - Object Lifecycle - Tests
  
- (void)test___init__calls_commonInit {
  
  // given
  [self givenExpectWillCallCommonInit];
  
  // when
  sut = [sut init];
  
  // then
  OCMVerifyAll(partialMock);
}
  
- (void)test___initWithFrame___calls_commonInit {
  
  // given
  [self givenExpectWillCallCommonInit];
  
  // when
  sut = [sut initWithFrame:CGRectZero];
  
  // then
  OCMVerifyAll(partialMock);
}
  
- (void)test___initWithCoder___calls_commonInit {
  
  // given
  NSCoder *coder = nil;
  [self givenExpectWillCallCommonInit];
  
  // when
  sut = [sut initWithCoder:coder];
  
  // then
  OCMVerifyAll(partialMock);
}
  
- (void)test___commonInit___calls_configureNavigationBar {
  
  // given
  sut = [sut init];
  OCMExpect([partialMock configureToolbar:sut]);
  
  // when
  [sut commonInit];
  
  // then
  OCMVerifyAll(partialMock);
}
  
  @end
