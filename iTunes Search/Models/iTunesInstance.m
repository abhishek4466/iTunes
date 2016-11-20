//
//  iTunesInstance.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import "iTunesInstance.h"

@implementation iTunesInstance

static iTunesInstance *instance =nil;
+(iTunesInstance *)getInstanceOfiTunesSearch
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [iTunesInstance new];

        }
    }
    return instance;
}

+ (void)saveSearchInfoInInstance:(id)array {
    [self clearInstance];
    [self getInstanceOfiTunesSearch];
    for (int i = 0; i < [array count]; i++) {
        [self addAllResultsInInstance:[array objectAtIndex:i]];
    }
}


+ (void)addAllResultsInInstance:(NSDictionary*)lfDict {
    iTunesObject *obj = [[iTunesObject alloc] init];
    for (NSString *key in lfDict)
    {
        if ([self containsKey:key inObject:obj]) {
            id value = lfDict[key];
            if (value != [NSNull null] && value != nil)
            {
                value = [NSString stringWithFormat:@"%@",value];
                [obj setValue:value forKey:key];
            }
        }
    }
    
    [instance.listOfResults addObject:obj];
}

+ (BOOL)containsKey:(NSString *)key inObject:(id)obj {
    BOOL retVal = 0;
    NSArray *allKeys = [iTunesObject allPropertyNames];
    retVal = [allKeys containsObject:key];
    return retVal;
}

+ (void)clearInstance {
    
}

@end
