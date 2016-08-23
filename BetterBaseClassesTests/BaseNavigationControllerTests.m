//
//  BaseTabBarController.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/23/16.
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

// Test Class
#import "BaseNavigationController.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface BaseNavigationControllerTests : XCTestCase
@end

@implementation BaseNavigationControllerTests {
  BaseNavigationController *sut;
  
  id viewController;
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  [super setUp];
  sut = [[BaseNavigationController alloc] init];
}

- (void)tearDown {
  
  [partialMock stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenExpectCommonInitToBeCalled {
  sut = [BaseNavigationController alloc];
  
  [self givenPartialMock];
  OCMExpect([partialMock commonInit]);
}

- (void)givenMockVisibleViewController {
  viewController = OCMClassMock([UIViewController class]);
  
  [self givenPartialMock];
  OCMStub([partialMock visibleViewController]).andReturn(viewController);
}

- (void)givenPartialMock {
  [partialMock stopMocking];  // in case it's already set
  partialMock = OCMPartialMock(sut);
}

#pragma mark - Object Lifecycle - Tests

- (void)test___init___calls_commonInit {
  
  // given
  [self givenExpectCommonInitToBeCalled];
  
  // when
  sut = [sut init];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithCoder___calls_commonInit {
  
  // given
  [self givenExpectCommonInitToBeCalled];
  
  NSCoder *coder = nil;
  
  // when
  sut = [sut initWithCoder:coder];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithNibName_bundle___calls_commonInit {
  
  // given
  [self givenExpectCommonInitToBeCalled];
  
  // when
  sut = [sut initWithNibName:nil bundle:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithRootViewController___calls_commonInit {
  
  // given
  [self givenExpectCommonInitToBeCalled];
  
  // when
  sut = [sut initWithRootViewController:viewController];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___initWithNavigationBarClass_toolbarClass {
  
  // given
  [self givenExpectCommonInitToBeCalled];
  
  // when
  sut = [sut initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]];
  
  // then
  OCMVerifyAll(partialMock);
}

#pragma mark - View Lifecycle - Tests

- (void)test___preferredInterfaceOrientationForPresentation___givenVisibleViewController_returns_viewController_preferredInterfaceOrientationForPresentation {
  
  // given
  UIInterfaceOrientation expected = UIInterfaceOrientationLandscapeLeft;
  [self givenMockVisibleViewController];
  OCMStub([viewController preferredInterfaceOrientationForPresentation]).andReturn(expected);
  
  // when
  UIInterfaceOrientation actual = [sut preferredInterfaceOrientationForPresentation];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___preferredStatusBarStyle___givenVisibleViewController_returns_viewController_preferredStatusBarStyle {
  
  // given
  UIStatusBarStyle expected = UIStatusBarStyleLightContent;
  [self givenMockVisibleViewController];
  OCMStub([viewController preferredStatusBarStyle]).andReturn(expected);
  
  // when
  UIStatusBarStyle actual = [sut preferredStatusBarStyle];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___shouldAutorotate___givenVisibleViewController_returns_viewController_shouldAutorotate {
  
  // given
  BOOL expected = false;
  [self givenMockVisibleViewController];
  OCMStub([viewController shouldAutorotate]).andReturn(expected);
  
  // when
  BOOL actual = [sut shouldAutorotate];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___supportedInterfaceOrientations___givenVisibleViewController_returns_viewController_supportedInterfaceOrientations {
  
  // given
  UIInterfaceOrientationMask expected = UIInterfaceOrientationMaskLandscapeRight;
  [self givenMockVisibleViewController];
  OCMStub([viewController supportedInterfaceOrientations]).andReturn(expected);
  
  // when
  UIInterfaceOrientationMask actual = [sut supportedInterfaceOrientations];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___viewDidLoad___calls_configureTabBar {
  
  // given
  UINavigationBar *navigationBar = sut.navigationBar;
  [self givenPartialMock];
  OCMExpect([partialMock configureNavigationBar:navigationBar]);
  
  // when
  [sut viewDidLoad];
  
  // then
  OCMVerify(partialMock);
}

@end
