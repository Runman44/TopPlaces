//
//  RecentPhotos.h
//  TopPlaces
//
//  Created by Dennis Anderson on 5/9/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

+ (NSArray *) allPhotos;
+ (void) addPhoto:(NSDictionary *)photo;

@end
