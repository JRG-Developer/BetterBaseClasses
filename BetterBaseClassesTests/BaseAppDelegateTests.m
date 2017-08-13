//
//  BaseAppDelegateTests.m
//  BetterBaseClasses
//
//  Created by Joshua Greene on 4/16/15.
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
#import "BaseAppDelegate.h"

// Collaborators
#import "AppDelegateNotificationKeys.h"

// Test Support
#import "BaseTestCase.h"

#define EXP_SHORTHAND YES
#import <Expecta/Expecta.h>

#import <OCMock/OCMock.h>

@interface BaseAppDelegateTests : BaseTestCase
@end

@implementation BaseAppDelegateTests {

  BaseAppDelegate *sut;
}

#pragma mark - Test Lifecycle

- (void)setUp {
  [super setUp];
  
  sut = [[BaseAppDelegate alloc] init];
}

- (void)tearDown {

  [notificationCenter stopMocking];
  [super tearDown];
}

#pragma mark - Notifications - Tests

- (void)test___application_didRegisterUserNotificationSettings___postsNotification {
  
  // given
  UIApplication *application = nil;
  UIUserNotificationSettings *notificationSetting = [UIUserNotificationSettings
                                                     settingsForTypes:UIUserNotificationTypeAlert
                                                     categories:nil];

  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter postNotificationName:ApplicationDidRegisterForUserNotificationSettingsNotification
                                              object:notificationSetting]);
  
  // when
  [sut application:application didRegisterUserNotificationSettings:notificationSetting];
  
  // then
  OCMVerifyAll(notificationCenter);
}

- (void)test___application_didRegisterForRemoteNotificationsWithDeviceToken___postsNotification {
  
  // given
  UIApplication *application = nil;
  NSData *data = [NSData data];
  
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter postNotificationName:ApplicationDidRegisterForRemoteNotificationsNotification
                                              object:data]);
  
  // when
  [sut application:application didRegisterForRemoteNotificationsWithDeviceToken:data];
  
  // then
  OCMVerifyAll(notificationCenter);
}

- (void)test___application_didReceiveLocalNotification___postsNotification {
  
  // given
  UIApplication *application = nil;
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  
  [self givenMockNotificationCenter];
  OCMExpect([notificationCenter postNotificationName:ApplicationDidReceiveLocalNotification
                                              object:notification]);
  
  // when
  [sut application:application didReceiveLocalNotification:notification];
  
  // then
  OCMVerifyAll(notificationCenter);
}

@end
