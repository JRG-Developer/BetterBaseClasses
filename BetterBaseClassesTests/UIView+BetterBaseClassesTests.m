//
//  UIView+BetterBaseClassesTests.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 2/25/15.
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
#import "UIView+BetterBaseClasses.h"

// Collaborators

// Test Support
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface UIView_BetterBaseClassesTests : XCTestCase
@end

@implementation UIView_BetterBaseClassesTests {

  id mockBundle;
  id mockSutClass;
  id mockNibClass;
}

#pragma mark - Test Lifecycle

- (void)tearDown {
  
  [mockBundle stopMocking];
  [mockSutClass stopMocking];
  [mockNibClass stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockBundle {
  mockBundle = OCMClassMock([NSBundle class]);
}

- (void)givenMockNibClass {
  mockNibClass = OCMClassMock([UINib class]);
}

- (void)givenMockSutClass {
  mockSutClass = OCMClassMock([UIView class]);
}

#pragma mark - Identifiers - Tests

- (void)test___bundle___returns_bundleForClass {
  
  // given
  NSBundle *expected = [NSBundle bundleForClass:[self class]];
  [self givenMockBundle];
  OCMExpect([mockBundle bundleForClass:OCMOCK_ANY]).andReturn(expected);
  
  // when
  NSBundle *actual = [UIView bundle];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___setBundle___afterSettingBundle_bundle_returnsSetBundle {
    
    // given
    [self givenMockBundle];
    NSBundle *expected = mockBundle;
    
    // when
    [UIView setBundle:mockBundle];
    NSBundle *actual = [UIView bundle];
    
    // then
    XCTAssertEqual(actual, expected);
    
    // clean up
    [UIView setBundle:nil];
}

- (void)test___identifier___ifClassNameDoesntHavePathExtension_returnsClassName {
  
  // given
  NSString *expected = @"UIView";
  
  // when
  NSString *actual = [UIView nibName];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___identifier___ifClassNameHasPathExtension_returnsClassPathExtension {
  
  // TO-DO:  Figure out an easy way to test this...
}

#pragma mark - Instantiation - Tests

- (void)test___instanceFromNib___instantiatesViewFromNib {
  
  // given
  UIView *expected = [UIView new];
  NSArray *objects = @[expected];
  
  [self givenMockSutClass];
  [self givenMockNibClass];
  OCMStub([mockSutClass nib]).andReturn(mockNibClass);
  OCMStub([mockNibClass instantiateWithOwner:nil options:nil]).andReturn(objects);
  
  // when
  UIView *actual = [UIView instanceFromNib];
  
  // then
  expect(actual).to.equal(expected);
}

- (void)test___nib___returnsNibWithNibNameAndBundle {
  
  // given
  NSString *nibName = [UIView nibName];
  NSBundle *bundle = [UIView bundle];
  
  UINib *expected = [UINib new];
  
  [self givenMockNibClass];
  OCMStub([mockNibClass nibWithNibName:nibName bundle:bundle]).andReturn(expected);
  
  // when
  UINib *actual = [UIView nib];
  
  // then
  expect(actual).to.equal(expected);
}

@end
