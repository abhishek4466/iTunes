//
//  iTunesInstanceTest.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/18/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "iTunesInstance.h"

@interface iTunesInstanceTest : XCTestCase

@end

@implementation iTunesInstanceTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (iTunesInstance *)getInstance {
    return [iTunesInstance getInstanceOfiTunesSearch];
}

- (iTunesInstance *)createAnotherInstance {
    return [[iTunesInstance alloc] init];
}

#pragma mark - tests

- (void)testSingletonSharedInstanceCreated {
    
    XCTAssertNotNil([self getInstance]);
    
}

- (void)testSingletonUniqueInstanceCreated {
    
    XCTAssertNotNil([self createAnotherInstance]);
}

- (void)testSingletonReturnsSameSharedInstanceTwice {
    
    iTunesInstance *instance = [self getInstance];
    XCTAssertEqual(instance, [self getInstance]);
    
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance {
    
    iTunesInstance *instance = [self getInstance];
    XCTAssertNotEqual(instance, [self createAnotherInstance]);
}

- (void)testSingletonReturnsSeparateUniqueInstances {
    
    iTunesInstance *instance = [self createAnotherInstance];
    XCTAssertNotEqual(instance, [self createAnotherInstance]);
}

@end
