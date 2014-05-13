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

+ (NSArray *) allPhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:RECENT_PHOTOS_PREF_KEY];
    return photos;
}

+ (NSArray *) allFavoritePhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *photos = [prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY];
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

+ (void) addPhotoToFavorite:(NSDictionary *)photo{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *photos = [[prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    
    [photos insertObject:photo atIndex:0];
    [prefs setObject:photos forKey:FAVORITE_PHOTOS_PREF_KEY];
    [prefs synchronize];
}



+ (void) clearPhotos
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil forKey:RECENT_PHOTOS_PREF_KEY];
}


+ (void) clearFavoritePhoto: (NSDictionary *) photo
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *photos = [[prefs objectForKey:FAVORITE_PHOTOS_PREF_KEY] mutableCopy];
    if (!photos) {
        photos = [NSMutableArray array];
    }
    
    NSUInteger key = [photos indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[photo valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[obj valueForKeyPath:FLICKR_PHOTO_ID]];
    }];
    if (key != NSNotFound) [photos removeObjectAtIndex:key];
    
    [prefs setObject:photos forKey:FAVORITE_PHOTOS_PREF_KEY];
    [prefs synchronize];


}






@end
