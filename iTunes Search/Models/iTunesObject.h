//
//  iTunesObject.h
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesObject : NSObject

@property (strong, nonatomic) NSString *trackName;
@property (strong, nonatomic) NSString *artworkUrl60;
@property (strong, nonatomic) NSString *artworkUrl30;
@property (strong, nonatomic) NSString *trackPrice;
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *longDescription;
@property (strong, nonatomic) NSString *artistName;

+ (NSArray *)allPropertyNames;

@end
