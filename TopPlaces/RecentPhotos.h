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
+ (NSArray *) allFavoritePhotos;
+ (void) addPhoto:(NSDictionary *)photo;
+ (void) addPhotoToFavorite:(NSDictionary *)photo;
+ (void) clearPhotos;


@end
