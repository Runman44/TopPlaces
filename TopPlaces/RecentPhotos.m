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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // inside the prefs the object is a NSArray. Thats why mutablecopy is applied so
    // insertObject will work
    NSMutableArray *photos = [[prefs objectForKey:@"keyToLookupPhotos"] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    [photos insertObject:photo atIndex:0];
    if ([photos count] > 20){
        [photos removeLastObject];
    }
    [prefs setObject:photos forKey:@"keyToLookupPhotos"];
    [prefs synchronize];
}
@end
