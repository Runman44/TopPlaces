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
#define FAVORITE_PHOTOS_PREF_KEY @"Favorite_Photos_Key"
#define RECENT_MAX_PHOTOS 20

// returns every photo stored in the NSUserDefaults on key RECENT_PHOTOS_PREF_KEY
+ (NSArray *) allPhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:RECENT_PHOTOS_PREF_KEY];
    return photos;
}

// returns every photo stored in the NSUserDefaults on key FAVORITE_PHOTOS_PREF_KEY
+ (NSArray *) allFavoritePhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY];
    return photos;
}

// adds a photo in the NSUserDefault on key RECENT_PHOTOS_PREF_KEY
+ (void) addPhoto:(NSDictionary *)photo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // inside the prefs the object is a NSArray. Thats why mutablecopy is applied so
    // insertObject will work
    NSMutableArray *photos = [[prefs objectForKey:RECENT_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    
    // if the photo ID is already in the NSUserDefaults, delete the old one
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    
    // check if the photo count isn't over the RECENT_MAX_PHOTOS
    [photos insertObject:photo atIndex:0];
    while ([photos count] > RECENT_MAX_PHOTOS){
        [photos removeLastObject];
    }
    // add the photo to the NSUserDefault
    [prefs setObject:photos forKey:RECENT_PHOTOS_PREF_KEY];
    [prefs synchronize];
}

// adds a photo to the Favorite NSUserDefault on key FAVORITE_PHOTOS_PREF_KEY
+ (void) addPhotoToFavorite:(NSDictionary *)photo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // inside the prefs the object is a NSArray. Thats why mutablecopy is applied so
    // insertObject will work
    NSMutableArray *photos = [[prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    
    // if the photo ID is already in the NSUserDefaults, delete the old one
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    // add the photo to the NSUserDefault
    [photos insertObject:photo atIndex:0];
    [prefs setObject:photos forKey:FAVORITE_PHOTOS_PREF_KEY];
    [prefs synchronize];
}

// set the NSUserDefault on key RECENT_PHOTOS_PREF_KEY to nil
+ (void) clearPhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil forKey:RECENT_PHOTOS_PREF_KEY];
}

// deletes a certain photo from the favorite list
+ (void) clearFavoritePhoto: (NSDictionary *) photo
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // inside the prefs the object is a NSArray. Thats why mutablecopy is applied so
    // insertObject will work
    NSMutableArray *photos = [[prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    
    // if the photo ID is already in the NSUserDefaults, delete the old one
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    // add all other photos again
    [prefs setObject:photos forKey:FAVORITE_PHOTOS_PREF_KEY];
    [prefs synchronize];
}

@end
