//
//  iTunesInstance.h
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunesObject.h"

@interface iTunesInstance : NSObject

@property(nonatomic, strong) NSDictionary       *selectedEntity;
@property(nonatomic, strong) NSMutableArray     *listOfResults;
@property(nonatomic)         NSInteger          selectedResultIndex;

+ (iTunesInstance*)getInstanceOfiTunesSearch;
+ (void)saveSearchInfoInInstance:(id)json;

@end
