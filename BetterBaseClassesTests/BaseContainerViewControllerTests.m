//
//  BaseContainerViewControllerTests.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 8/25/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

// Test Class
#import "BaseContainerViewController.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface BaseContainerViewController (private)
@property (assign, nonatomic) CGFloat bottomContainerViewHeightConstraintConstant;
@property (assign, nonatomic) CGFloat topContainerViewHeightConstraintConstant;
@end

@interface BaseContainerViewControllerTests : XCTestCase
@end

@implementation BaseContainerViewControllerTests {
  
  BaseContainerViewController *sut;
  
  CGFloat constraintConstant;
  CGFloat originalAnimationDuration;
  
  id constraint;
  
  id existingContentView;
  id existingViewController;
  
  id newContentView;
  id newViewController;
  
  id partialMock;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  [super setUp];
  
  originalAnimationDuration = [BaseContainerViewController animationDuration];
  [BaseContainerViewController setAnimationDuration:0.01];
  
  sut = [[BaseContainerViewController alloc] init];
  
  constraintConstant = 42.0f;
  [self givenMockConstraintWithConstant:constraintConstant];
  sut.topContainerViewHeightConstraint = constraint;
  sut.bottomContainerViewHeightConstraint = constraint;
}

- (void)tearDown {
  
  [BaseContainerViewController setAnimationDuration:originalAnimationDuration];
  
  [constraint stopMocking];
  
  [existingContentView stopMocking];
  [existingViewController stopMocking];
  
  [newContentView stopMocking];
  [newViewController stopMocking];
  
  [partialMock stopMocking];
  sut = nil;
  
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockConstraintWithConstant:(CGFloat)constant {
  constraint = OCMClassMock([NSLayoutConstraint class]);
  OCMStub([constraint constant]).andReturn(constant);
}

- (void)givenPartialMock {
  partialMock = OCMPartialMock(sut);
}

- (void)givenMockExistingViewController {
  
  [self givenMockExistingContentView];
  existingViewController = OCMClassMock([UIViewController class]);
  OCMStub([existingViewController view]).andReturn(existingContentView);
}

- (void)givenMockExistingContentView {
  existingContentView = OCMClassMock([UIView class]);
}


- (void)givenMockNewViewController {
  
  [self givenMockNewContentView];
  newViewController = OCMClassMock([UIViewController class]);
  OCMStub([newViewController view]).andReturn(newContentView);
}

- (void)givenMockNewContentView {
  newContentView = OCMClassMock([UIView class]);
}


#pragma mark - Configuration - Tests

- (void)test___setAnimationDuration__setsAnimationDuration {
  
  // given
  CGFloat expected = 42.0;
  
  // when
  [BaseContainerViewController setAnimationDuration:expected];
  CGFloat actual = [BaseContainerViewController animationDuration];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - Custom Accessors - Tests
#pragma mark -- Height Constraints

- (void)test___setBottomViewHeightConstraint___sets_bottomContainerViewHeightConstraintConstant {
  expect(sut.bottomContainerViewHeightConstraintConstant).to.equal(constraintConstant);
}

- (void)test___setTopContainerViewHeightConstraint___sets_topContainerViewHeightConstraintConstant {
  expect(sut.topContainerViewHeightConstraintConstant).to.equal(constraintConstant);
}

#pragma mark -- Bottom View Controller

- (void)test___setBottomViewController___calls_setBottomViewController_animated_completion {
  
  // given
  [self givenPartialMock];
  [self givenMockNewViewController];
  
  OCMExpect([partialMock setBottomViewController:newViewController animated:YES completion:nil]);
  
  // when
  [sut setBottomViewController:newViewController];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setBottomViewController_animated_completion___calls_bottomViewController_willMoveToParentViewController_nil {
  
  // given
  [self givenMockExistingViewController];
  sut.bottomViewController = existingViewController;
  
  OCMExpect([existingViewController willMoveToParentViewController:nil]);
  
  // when
  [sut setBottomViewController:nil animated:NO completion:nil];
  
  // then
  OCMVerifyAll(existingViewController);
}

- (void)test___setBottomViewController_animated_completion___calls_sut_addChildViewController_newViewController {
  
  // given
  [self givenMockNewViewController];
  [self givenPartialMock];
  
  OCMExpect([partialMock addChildViewController:newViewController]);
  
  // when
  [sut setBottomViewController:newViewController animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setBottomViewController_animated_completion___calls_sut_setBottomContentView_animated_completion {
  
  // given
  [self givenMockNewViewController];
  [self givenPartialMock];
  
  OCMExpect([partialMock setBottomContentView:newContentView animated:NO completion:OCMOCK_ANY]);
  
  // when
  [sut setBottomViewController:newViewController animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setBottomViewController_animated_completion___sets_bottomViewController {
  
  // given
  [self givenMockNewViewController];
  
  // when
  [sut setBottomViewController:newViewController animated:NO completion:nil];
  
  // then
  XCTAssertTrue(sut.bottomViewController == newViewController);   // pointer equality
}

- (void)test___setBottomViewController_animated_completion___calls_existingBottomViewController_removeFromParentViewController {
  
  // given
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
  
  [self givenMockExistingViewController];
  sut.bottomViewController = existingViewController;
  OCMExpect([existingViewController removeFromParentViewController]);
  
  [self givenMockNewViewController];
  
  // when
  [sut setBottomViewController:newViewController animated:NO completion:^{
    [expectation fulfill];
  }];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test___setBottomViewController_animated_completion___calls_newViewController_didMoveToParentViewController {
  
  // given
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
  
  [self givenMockExistingViewController];
  sut.bottomViewController = existingViewController;
  
  [self givenMockNewViewController];
  OCMExpect([newViewController didMoveToParentViewController:sut]);
  
  // when
  [sut setBottomViewController:newViewController animated:NO completion:^{
    [expectation fulfill];
  }];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

#pragma mark -- Top View Controller

- (void)test___setTopViewController___calls_setTopViewController_animated_completion {
  
  // given
  [self givenPartialMock];
  [self givenMockNewViewController];
  
  OCMExpect([partialMock setTopViewController:newViewController animated:YES completion:nil]);
  
  // when
  [sut setTopViewController:newViewController];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setTopViewController_animated_completion___calls_topViewController_willMoveToParentViewController_nil {
  
  // given
  [self givenMockExistingViewController];
  sut.topViewController = existingViewController;
  
  OCMExpect([existingViewController willMoveToParentViewController:nil]);
  
  // when
  [sut setTopViewController:nil animated:NO completion:nil];
  
  // then
  OCMVerifyAll(existingViewController);
}

- (void)test___setTopViewController_animated_completion___calls_sut_addChildViewController_newViewController {
  
  // given
  [self givenMockNewViewController];
  [self givenPartialMock];
  
  OCMExpect([partialMock addChildViewController:newViewController]);
  
  // when
  [sut setTopViewController:newViewController animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setTopViewController_animated_completion___calls_sut_setTopContentView_animated_completion {
  
  // given
  [self givenMockNewViewController];
  [self givenPartialMock];
  
  OCMExpect([partialMock setTopContentView:newContentView animated:NO completion:OCMOCK_ANY]);
  
  // when
  [sut setTopViewController:newViewController animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setTopViewController_animated_completion___sets_topViewController {
  
  // given
  [self givenMockNewViewController];
  
  // when
  [sut setTopViewController:newViewController animated:NO completion:nil];
  
  // then
  XCTAssertTrue(sut.topViewController == newViewController);  // pointer equality
}

- (void)test___setTopViewController_animated_completion___calls_existingTopViewController_removeFromParentViewController {
  
  // given
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
  
  [self givenMockExistingViewController];
  sut.bottomViewController = existingViewController;
  OCMExpect([existingViewController removeFromParentViewController]);
  
  [self givenMockNewViewController];
  
  // when
  [sut setTopViewController:newViewController animated:NO completion:^{
    [expectation fulfill];
  }];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test___setTopViewController_animated_completion___calls_newViewController_didMoveToParentViewController {
  
  // given
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
  
  [self givenMockExistingViewController];
  sut.bottomViewController = existingViewController;
  
  [self givenMockNewViewController];
  OCMExpect([newViewController didMoveToParentViewController:sut]);
  
  // when
  [sut setTopViewController:newViewController animated:NO completion:^{
    [expectation fulfill];
  }];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

#pragma mark - View Lifecycle - Tests

- (void)test___viewDidLoad___givenBottomContainerViewDoesntHaveSubviews_setsBottomContainerViewHeightConstraint_constant_toZero {
  
  // given
  UIView *containerView = [[UIView alloc] init];
  sut.bottomContainerView = containerView;
  
  OCMExpect([constraint setConstant:0]);
  
  // when
  [sut viewDidLoad];
  
  // then
  OCMVerifyAll(constraint);
}

- (void)test___viewDidLoad___givenBottomContainerViewHasSubviews_doesntSetBottomContainerViewHeightConstraint_constant {
  
  // given
  [[[constraint reject] ignoringNonObjectArgs] setConstant:0];
  
  UIView *containerView = [[UIView alloc] init];
  [containerView addSubview:[UIView new]];
  sut.bottomContainerView = containerView;
  
  // when
  [sut viewDidLoad];
  
  // then
  // No errors? Pass!
}

- (void)test___viewDidLoad___givenTopContainerViewDoesntHaveSubviews_setsTopContainerViewHeightConstraint_constant_toZero {
  
  // given
  UIView *containerView = [[UIView alloc] init];
  sut.topContainerView = containerView;
  
  OCMExpect([constraint setConstant:0]);
  
  // when
  [sut viewDidLoad];
  
  // then
  OCMVerifyAll(constraint);
}

- (void)test___viewDidLoad___givenTopContainerViewHasSubviews_doesntSetTopContainerViewHeightConstraint_constant {
  
  // given
  [[[constraint reject] ignoringNonObjectArgs] setConstant:0];
  
  UIView *containerView = [[UIView alloc] init];
  [containerView addSubview:[UIView new]];
  sut.topContainerView = containerView;
  
  // when
  [sut viewDidLoad];
  
  // then
  // No errors? Pass!
}

#pragma mark - Container Methods - Tests

#warning Write these...

@end
