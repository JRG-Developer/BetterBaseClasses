//
//  UIViewController+BetterBaseClassesTests.m
//  BetterBaseControllers
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

// Test Class
#import "UIViewController+BetterBaseClasses.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UIViewController_BetterBaseClassesTests : XCTestCase
@end

@implementation UIViewController_BetterBaseClassesTests {
 
  NSBundle *bundle;
  NSString *identifier;
  NSString *storyboardName;
  
  id mockBundle;
  id mockStoryboard;
  id mockSutClass;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  
  [super setUp];

  bundle = [UIViewController bundle];
  identifier = [UIViewController identifier];
  storyboardName = [UIViewController storyboardName];
}

- (void)tearDown {
  
  [mockBundle stopMocking];
  [mockStoryboard stopMocking];
  [mockSutClass stopMocking];
  
  [UIViewController setPreferStoryboards:NO];
  
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockBundle {
  mockBundle = OCMClassMock([NSBundle class]);
}

- (void)givenMockStoryboard {
  mockStoryboard = OCMClassMock([UIStoryboard class]);
}

- (void)givenMockSutClass {
  mockSutClass = OCMClassMock([UIViewController class]);
}

#pragma mark - Identifiers - Tests

- (void)test___bundle___returns_bundleForClass {
  
  // given
  NSBundle *expected = [NSBundle bundleForClass:[self class]];
  [self givenMockBundle];
  OCMExpect([mockBundle bundleForClass:[UIViewController class]]).andReturn(expected);
  
  // when
  NSBundle *actual = [UIViewController bundle];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___setBundle___afterSettingBundle_bundle_returnsSetBundle {
    
    // given
    [self givenMockBundle];
    NSBundle *expected = mockBundle;
    
    // when
    [UIViewController setBundle:mockBundle];
    NSBundle *actual = [UIViewController bundle];
    
    // then
    XCTAssertEqual(actual, expected);
    
    // clean up
    [UIViewController setBundle:nil];
}

- (void)test___identifier___ifClassNameDoesntHavePathExtension_returnsClassName {
  
  // given
  NSString *expected = @"UIViewController";
  
  // when
  NSString *actual = [UIViewController identifier];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___identifier___ifClassNameHasPathExtension_returnsClassPathExtension {
  
  // TO-DO:  Figure out an easy way to test this...
}

- (void)test___storyboard___returnsStoryboardUsingStoryboardNameAndBundle {
  
  // given
  [self givenMockStoryboard];
  OCMStub(ClassMethod([mockStoryboard storyboardWithName:storyboardName bundle:bundle])).andReturn(mockStoryboard);
  
  // when
  UIStoryboard *actual = [UIViewController storyboard];
  
  // then
  expect(actual).to.equal(mockStoryboard);
}

- (void)test___storyboardName___returns_infoDict_UIMainStoryboardFile {
  
  // given
  NSString *expected = [UIViewController storyboardName];
  
  // when
  NSString *actual = [UIViewController storyboardName];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - Instantiation - Tests

- (void)test___instanceFromNib___calls_initWithNibName_bundle {
  
  // given
  NSString *nibName = [UIViewController identifier];
  UIViewController *expected = [UIViewController new];
  
  [self givenMockSutClass];
  OCMStub([mockSutClass alloc]).andReturn(mockSutClass);
  OCMStub([mockSutClass initWithNibName:nibName bundle:bundle]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController instanceFromNib];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___instanceFromStoryboard___instantiatesViewControllerFromStoryboard {
  
  // given
  UIViewController *expected = [UIViewController new];
  
  [self givenMockStoryboard];
  OCMStub([mockStoryboard storyboardWithName:storyboardName bundle:bundle]).andReturn(mockStoryboard);
  OCMStub([mockStoryboard instantiateViewControllerWithIdentifier:identifier]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController instanceFromStoryboard];
  
  // then
  expect(actual).to.equal(expected);
}

#pragma mark - Preferred Instance - Tests

- (void)test___setPreferStoryboards___YES_setsPreferStoryboardsToYES {
  
  // given
  BOOL expected = YES;
  
  // when
  [UIViewController setPreferStoryboards:expected];
  
  // then
  expect([UIViewController preferStoryboards]).to.beTruthy();
}

- (void)test___preferredInstance___ifDoesntPrefersStoryboards_returns_instanceFromNib {

  // given
  [UIViewController setPreferStoryboards:NO];
  
  UIViewController *expected = [UIViewController new];
  [self givenMockSutClass];
  
  OCMStub([mockSutClass instanceFromNib]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController preferredInstance];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___preferredInstance___ifPrefersStoryboards_returns_instanceFromStoryboard {
  
  // given
  [UIViewController setPreferStoryboards:YES];
  
  UIViewController *expected = [UIViewController new];
  [self givenMockSutClass];
  
  OCMStub([mockSutClass instanceFromStoryboard]).andReturn(expected);
  
  // when
  UIViewController *actual = [UIViewController preferredInstance];
  
  // then
  expect(actual).to.equal(expected);
}

@end
