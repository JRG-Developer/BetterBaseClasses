//
//  BaseViewTests.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 2/26/15.
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
#import "BaseView.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface BaseViewTests : XCTestCase
@end

@implementation BaseViewTests {

  BaseView *sut;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  
  [super setUp];
  sut = [BaseView alloc];
  
  partialMock = OCMPartialMock(sut);
  OCMExpect([partialMock commonInit]);
}

- (void)tearDown {
  
  [partialMock stopMocking];
  [super tearDown];
}

#pragma mark - Object Lifecycle - Tests

- (void)test___init___calls_commonInit {
  
  // given
  sut = [sut init];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithFrame___calls_commonInit {
  
  // when
  sut = [sut initWithFrame:CGRectZero];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithCoder___calls_commonInit {
  
  // given
  NSCoder *coder = nil;
  
  // when
  sut = [sut initWithCoder:coder];
  
  // then
  OCMVerifyAll(partialMock);
}

@end
