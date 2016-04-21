//
//  BaseTestCase.h
//  BetterBaseClasses
//
//  Created by Joshua Greene on 4/21/16.
//  Copyright © 2016 Joshua Greene. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BaseTestCase : XCTestCase {
  
  id notificationCenter;
  id thread;
}

- (void)givenMockNotificationCenter;

- (void)givenMockThreadWillReturnIsMainThread:(BOOL)isMainThread;

@end
