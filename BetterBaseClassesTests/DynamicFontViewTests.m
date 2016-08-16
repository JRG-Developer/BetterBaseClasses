//
//  DynamicFontViewTests.m
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
#import "DynamicFontView.h"

// Collaborators

// Test Support
#import "BaseTestCase.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface DynamicFontViewTests : BaseTestCase
@end

@implementation DynamicFontViewTests {

  DynamicFontView *sut;
  
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  
  [super setUp];
  sut = [[DynamicFontView alloc] init];
}

- (void)tearDown {
  
  [partialMock stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenPartialMock {
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___commonInit__registersFor_UIContentSizeCategoryDidChangeNotification {
  
  // given
  sut = [DynamicFontView alloc];
  
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter addObserver:sut selector:@selector(contentSizeCategoryDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil]);
  
  // when
  sut = [sut init];
  
  // then
  OCMVerifyAll(notificationCenter);
}

- (void)test___dealloc___removes_notificationCenterObserver {
  
  // given
  __weak DynamicFontView *object = nil;
  
  // When
  @autoreleasepool {
    id silenceWarning = [[DynamicFontView alloc] init];
    object = silenceWarning;
  }
  
  // then
  expect(object).to.beNil();  // doesn't crash, so must have removed observer ;)
}

#pragma mark - Dynamic Font Type - Tests

- (void)test___contentSizeCategoryDidChange___ifIsMainThread_calls_refreshView {
  
  // given
  NSNotification *notification = [NSNotification notificationWithName:@"" object:nil];
  
  [self givenMockThreadWillReturnIsMainThread:YES];
  [self givenPartialMock];
  OCMExpect([partialMock refreshView]);
  
  // when
  [sut contentSizeCategoryDidChange:notification];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___contentSizeCategoryDidChange___givenIsNotMainThread_calls_performSelectorOnMainThread {
  
  // given
  NSNotification *notification = [NSNotification notificationWithName:@"" object:nil];
  
  [self givenMockThreadWillReturnIsMainThread:NO];
  [self givenPartialMock];
  OCMExpect([partialMock performSelectorOnMainThread:@selector(contentSizeCategoryDidChange:)
                                          withObject:notification
                                       waitUntilDone:NO]);
  
  // when
  [sut contentSizeCategoryDidChange:notification];
  
  // then
  OCMVerifyAll(partialMock);
}

@end
