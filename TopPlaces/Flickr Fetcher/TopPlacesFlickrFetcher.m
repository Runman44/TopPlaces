//
//  TopPlacesFlickrFetcher.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/2/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "TopPlacesFlickrFetcher.h"

@implementation TopPlacesFlickrFetcher

// substrings the country name of the place dictionary
+ (NSString *)countryOfPlace:(NSDictionary *)place{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] lastObject];
}

// substrings the title name of the place dictionary
+ (NSString *)titleOfPlace:(NSDictionary *)place{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] firstObject];
}

// substrings the sibtitle name of the place dictionary
+ (NSString *)subtitleOfPlace:(NSDictionary *)place{
    
    NSString *photoContent = [place valueForKeyPath:FLICKR_PLACE_NAME];
    NSArray* foo = [photoContent componentsSeparatedByString: @","];
    if ([foo count] == 3) {
        NSString* region = [foo objectAtIndex: 1];
        return region;
    };
    return @"-";
    
}

#define FLICKR_UNKNOWN_PHOTO_TITLE @"Unknown"
// gets the title of a photo
+ (NSString *)titleOfPhoto:(NSDictionary *)photo
{
    NSString *title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
    if ([title length]) return title;
    
    title = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title length]) return title;
    
    return FLICKR_UNKNOWN_PHOTO_TITLE;
}

// gets the subtitle of a photo
+ (NSString *)subtitleOfPhoto:(NSDictionary *)photo
{
    NSString *title = [self titleOfPhoto:photo];
    if ([title isEqualToString:FLICKR_UNKNOWN_PHOTO_TITLE]) return @"";
    
    NSString *subtitle = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title isEqualToString:subtitle]) return @"";
    
    return subtitle;
}

// sorts the places on place name
+ (NSArray *)sortPlaces:(NSArray *)places{

    return [places sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 valueForKeyPath:FLICKR_PLACE_NAME];
        NSString *name2 = [obj2 valueForKeyPath:FLICKR_PLACE_NAME];
        return [name1 localizedCompare:name2];
    }];
}


// there is a dictionary with countries as keys. For every place it looks the country and sets it in the right place by the right key.
+ (NSDictionary *)placesByCountry:(NSDictionary *)places{
    {
        NSMutableDictionary *placesByCountry = [NSMutableDictionary dictionary];
        for (NSDictionary *place in places) {
            NSString *country = [self countryOfPlace:place];
            NSMutableArray *placesOfCountry = placesByCountry[country];
            if (!placesOfCountry) {
                placesOfCountry = [NSMutableArray array];
                placesByCountry[country] = placesOfCountry;
            }
            [placesOfCountry addObject:place];
        }
        return placesByCountry;
    }
}

// get all keys and sorts it
+ (NSArray *)sortCountries:(NSDictionary *)placesByCountry{
    NSArray *countries = [placesByCountry allKeys];
    NSArray *sortedArray = [countries sortedArrayUsingSelector:
                   @selector(localizedCaseInsensitiveCompare:)];
    return sortedArray;
}


@end
