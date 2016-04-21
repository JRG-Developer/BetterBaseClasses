//
//  BaseTestCase.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 4/21/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

#import "BaseTestCase.h"

#import <OCMock/OCMock.h>

@implementation BaseTestCase

#pragma mark - Test Lifecycle

- (void)tearDown {
  
  [notificationCenter stopMocking];
  [thread stopMocking];
  [super tearDown];
}

#pragma mark - Given

- (void)givenMockNotificationCenter {
  notificationCenter = OCMPartialMock([NSNotificationCenter defaultCenter]);
}

- (void)givenMockThreadWillReturnIsMainThread:(BOOL)isMainThread {
  
  thread = OCMClassMock([NSThread class]);
  OCMStub(ClassMethod([thread isMainThread])).andReturn(isMainThread);
}

@end
