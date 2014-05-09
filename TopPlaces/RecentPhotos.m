//
//  RecentPhotos.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/9/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "RecentPhotos.h"

@interface RecentPhotos ()
@property (nonatomic, strong) NSArray *recentPhotos;
@end

@implementation RecentPhotos

+ (NSArray *) allPhotos {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:@"keyToLookupPhotos"];
    return photos;
}

+ (void) addPhoto:(NSDictionary *)photo{
    
}
@end
