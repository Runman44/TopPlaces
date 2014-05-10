//
//  RecentPhotos.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/9/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "RecentPhotos.h"
#import "TopPlacesFlickrFetcher.h"

@interface RecentPhotos ()
@property (nonatomic, strong) NSArray *recentPhotos;
@end

@implementation RecentPhotos

#define RECENT_PHOTOS_PREF_KEY @"Recent_Photos_Key"
#define RECENT_MAX_PHOTOS 20

+ (NSArray *) allPhotos {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:RECENT_PHOTOS_PREF_KEY];
    return photos;
}

+ (void) addPhoto:(NSDictionary *)photo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // inside the prefs the object is a NSArray. Thats why mutablecopy is applied so
    // insertObject will work
    NSMutableArray *photos = [[prefs objectForKey:RECENT_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    // why isnt this loop working?!
    
//    NSUInteger count = [photos count];
//    for (NSUInteger i = 0; i < count; i++) {
//        if([[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[[photos objectAtIndex: i] valueForKeyPath:FLICKR_PHOTO_ID]]){
//            [photos removeObjectAtIndex:i];
//        }
//    }
    
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    

    [photos insertObject:photo atIndex:0];
    while ([photos count] > RECENT_MAX_PHOTOS){
        [photos removeLastObject];
    }
    [prefs setObject:photos forKey:RECENT_PHOTOS_PREF_KEY];
    [prefs synchronize];
}
@end
