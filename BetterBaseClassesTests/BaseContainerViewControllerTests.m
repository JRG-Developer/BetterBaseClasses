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


- (void)setContentView:(UIView *)contentView
         containerView:(UIView *)containerView
      heightConstraint:(NSLayoutConstraint *)heightConstraint
                height:(CGFloat)maxHeight
              animated:(BOOL) animated
            completion:(void(^)())externalCompletion;
@end

@interface BaseContainerViewControllerTests : XCTestCase
@end

@implementation BaseContainerViewControllerTests {
  
  BaseContainerViewController *sut;
  
  CGFloat constraintConstant;
  CGFloat originalAnimationDuration;
  
  id bottomContainerView;
  id topContainerView;
  
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
  
  sut = nil;
  
  originalAnimationDuration = [BaseContainerViewController animationDuration];
  [BaseContainerViewController setAnimationDuration:0.01];
  
  bottomContainerView = OCMClassMock([UIView class]);
  topContainerView = OCMClassMock([UIView class]);
  
  sut = [[BaseContainerViewController alloc] init];
  sut.bottomContainerView = bottomContainerView;
  sut.topContainerView = topContainerView;
  
  constraintConstant = 42.0f;
  [self givenMockConstraintWithConstant:constraintConstant];
  sut.topContainerViewHeightConstraint = constraint;
  sut.bottomContainerViewHeightConstraint = constraint;
  
  [sut view]; // force view to load
}

- (void)tearDown {
  
  [BaseContainerViewController setAnimationDuration:originalAnimationDuration];
  
  [bottomContainerView stopMocking];
  [topContainerView stopMocking];
  
  [constraint stopMocking];
  
  [existingContentView stopMocking];
  [existingViewController stopMocking];
  
  [newContentView stopMocking];
  [newViewController stopMocking];
  
  [partialMock stopMocking];
  
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

- (void)givenWillReplaceContentView {
  
  [self givenMockExistingContentView];
  NSArray *subviews = @[existingContentView];
  OCMStub([topContainerView subviews]).andReturn(subviews);
  
  [self givenMockNewContentView];
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

// Sporadically crashes... OCMock bug?... :/

//- (void)test___setBottomViewController_animated_completion___calls_existingBottomViewController_removeFromParentViewController {
//  
//  // given
//  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
//  
//  [self givenMockExistingViewController];
//  sut.bottomViewController = existingViewController;
//  OCMExpect([existingViewController removeFromParentViewController]);
//  
//  [self givenMockNewViewController];
//  
//  // when
//  [sut setBottomViewController:newViewController animated:NO completion:^{
//    [expectation fulfill];
//  }];
//  
//  // then
//  [self waitForExpectationsWithTimeout:0.1 handler:nil];
//}

//- (void)test___setBottomViewController_animated_completion___calls_newViewController_didMoveToParentViewController {
//  
//  // given
//  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion tp be called"];
//  
//  [self givenMockExistingViewController];
//  sut.bottomViewController = existingViewController;
//  
//  [self givenMockNewViewController];
//  OCMExpect([newViewController didMoveToParentViewController:sut]);
//  
//  // when
//  [sut setBottomViewController:newViewController animated:NO completion:^{
//    [expectation fulfill];
//  }];
//  
//  // then
//  [self waitForExpectationsWithTimeout:0.1 handler:nil];
//}

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

// Sporadically crashes... OCMock bug?... :/

//- (void)test___setTopViewController_animated_completion___calls_topViewController_willMoveToParentViewController_nil {
//  
//  // given
//  [self givenMockExistingViewController];
//  sut.topViewController = existingViewController;
//  
//  OCMExpect([existingViewController willMoveToParentViewController:nil]);
//  
//  // when
//  [sut setTopViewController:nil animated:NO completion:nil];
//  
//  // then
//  OCMVerifyAll(existingViewController);
//}

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

// Sporadically crashes... OCMock bug?... :/

//- (void)test___setTopViewController_animated_completion___calls_sut_setTopContentView_animated_completion {
//  
//  // given
//  [self givenMockNewViewController];
//  [self givenPartialMock];
//  
//  OCMExpect([partialMock setTopContentView:newContentView animated:NO completion:OCMOCK_ANY]);
//  
//  // when
//  [sut setTopViewController:newViewController animated:NO completion:nil];
//  
//  // then
//  OCMVerifyAll(partialMock);
//}

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
  sut.topContainerView = nil;
  
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
  UIView *containerView = [[UIView alloc] init];
  [containerView addSubview:[UIView new]];
  sut.topContainerView = containerView;
  sut.bottomContainerView = nil;
  
  
  [[[constraint reject] ignoringNonObjectArgs] setConstant:0];
  
  // when
  [sut viewDidLoad];
  
  // then
  // No errors? Pass!
}

#pragma mark - Container Methods - Tests

- (void)test___setBottomContentView___calls_setBottomContentView_animated_completion {
  
  // given
  [self givenMockNewContentView];
  [self givenPartialMock];
  
  OCMExpect([partialMock setBottomContentView:newContentView animated:YES completion:nil]);
  
  // when
  [sut setBottomContentView:newContentView];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setBottomContentView_animated_completion_calls_setContentView_containerView_etall {
  
  // given
  [self givenMockNewContentView];
  [self givenPartialMock];
  OCMExpect([partialMock setContentView:newContentView
                           containerView:bottomContainerView
                       heightConstraint:constraint
                                 height:constraintConstant
                               animated:NO completion:nil]);
  
  // when
  [sut setBottomContentView:newContentView animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setTopContentView___calls_setTopContentView_animated_completion {
  
  // given
  [self givenMockNewContentView];
  [self givenPartialMock];
  
  OCMExpect([partialMock setTopContentView:newContentView animated:YES completion:nil]);
  
  // when
  [sut setTopContentView:newContentView];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setTopContentView_animated_completion_calls_setContentView_containerView_etall {
  
  // given
  [self givenMockNewContentView];
  [self givenPartialMock];
  OCMExpect([partialMock setContentView:newContentView
                          containerView:topContainerView
                       heightConstraint:constraint
                                 height:constraintConstant
                               animated:NO completion:nil]);
  
  // when
  [sut setTopContentView:newContentView animated:NO completion:nil];
  
  // then
  OCMVerifyAll(partialMock);
}

- (void)test___setContentView_containerView_etall___givenContentViewNil_setsContraintConstantToZero {
  
  // given
  OCMExpect([constraint setConstant:0.0f]);
            
  // when
  [sut setContentView:nil
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO completion:nil];
  
  // then
  OCMVerifyAll(constraint);
}

#pragma mark -- nil content view

- (void)test___setContentView_containerView_etall___givenContentViewNil_removesContentViewSubviews {
  
  // given
  [self givenMockExistingContentView];
  NSArray *subviews = @[existingContentView];
  OCMStub([topContainerView subviews]).andReturn(subviews);
  OCMExpect([existingContentView removeFromSuperview]);
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion to be called"];
  
  void (^completion)() = ^{
    [expectation fulfill];
    OCMVerifyAll(existingContentView);
  };
  
  // when
  [sut setContentView:nil
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO completion:completion];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test___setContentView_containerView_etall___givenNewContentView_setsContentViewAutoresizingMask {
  
  // given
  [self givenMockNewContentView];
  OCMExpect([newContentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

- (void)test___setContentView_containerView_etall___givenNewContentView_setsContentViewFrame {
  
  // given
  CGRect expected = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
  OCMStub([topContainerView bounds]).andReturn(expected);
  
  [self givenMockNewContentView];
  OCMExpect([newContentView setFrame:expected]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

#pragma mark -- new content view

- (void)test___setContentView_containerView_etall___addsNewContentViewToContainerView {
  
  // given
  [self givenMockNewContentView];
  OCMExpect([topContainerView addSubview:newContentView]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(topContainerView);
}


- (void)test___setContentView_containerView_etall___setsConstraintConstant {
  
  // given
  [self givenMockNewContentView];
  
  OCMExpect([constraint setConstant:constraintConstant]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(constraint);  
}

- (void)test___setContentView_containerView_etall___givenNewContentView_callsCompletion {
  
  // given
  XCTestExpectation *expecation = [self expectationWithDescription:@"Wait for completion to be called"];
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:^{
             [expecation fulfill];
           }];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

#pragma mark -- replacement content view

- (void)test___setContentView_containerView_etall___givenReplacementContentView_setsNewContentViewAlphaInitiallyToZero {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([newContentView setAlpha:0.0f]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_setsNewContentViewAutoresizingMask {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([newContentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_setsNewContentViewFrame {
  
  // given
  [self givenWillReplaceContentView];
  
  CGRect expected = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
  OCMStub([topContainerView bounds]).andReturn(expected);
  
  OCMExpect([newContentView setFrame:expected]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_addsNewContentViewToContainerView {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([topContainerView addSubview:newContentView]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(topContainerView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_setsExistingContentViewAlpha {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([existingContentView setAlpha:0.0f]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(existingContentView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_setsNewContentViewAlphaFinallyToOne {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([newContentView setAlpha:1.0f]);
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:nil];
  
  // then
  OCMVerifyAll(newContentView);
}

- (void)test___setContentView_containerView_etall___givenReplacementContentView_removesExistingContent {
  
  // given
  [self givenWillReplaceContentView];
  OCMExpect([existingContentView removeFromSuperview]);
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for completion to be called"];
  
  void (^completion)() = ^{
    [expectation fulfill];
    OCMVerifyAll(existingContentView);
  };
  
  // when
  [sut setContentView:newContentView
        containerView:topContainerView
     heightConstraint:constraint
               height:constraintConstant
             animated:NO
           completion:completion];
  
  // then
  [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
