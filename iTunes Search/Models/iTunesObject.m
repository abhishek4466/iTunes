//
//  iTunesObject.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import "iTunesObject.h"
#import <objc/runtime.h>

@implementation iTunesObject


-(id)init {
    if (self = [super init]) {
        
        //Assigning the default values
        self.trackName = @"Track name is not available";
        self.trackPrice = @"No Price Available";
        self.shortDescription = @"No Short Description";
        self.longDescription = @"No Long Description";
        self.artistName = @"";
    }
    return self;
}

+ (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *rv = [NSMutableArray array];
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    free(properties);
    return rv;
}

@end
