//
//  BaseToolbarTests.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 11/21/16.
//    Copyright © 2016 Joshua Greene. All rights reserved.
//

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
