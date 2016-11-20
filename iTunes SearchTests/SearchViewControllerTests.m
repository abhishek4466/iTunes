//
//  SearchViewControllerTests.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/18/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchViewController.h"

@interface SearchViewControllerTests : XCTestCase

@property (nonatomic) SearchViewController *searchViewTest;

@end

@implementation SearchViewControllerTests

- (void)setUp {
    [super setUp];
    
    self.searchViewTest = [[SearchViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark- API Request Test-------------

- (void)testGetListOfResultsForCategory {
    
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

@end
