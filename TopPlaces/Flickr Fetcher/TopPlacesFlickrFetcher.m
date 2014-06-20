//
//  TopPlacesFlickrFetcher.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/2/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "TopPlacesFlickrFetcher.h"

@implementation TopPlacesFlickrFetcher


+ (NSString *)countryOfPlace:(NSDictionary *)place{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] lastObject];
}

+ (NSString *)titleOfPlace:(NSDictionary *)place{
    return [[[place valueForKeyPath:FLICKR_PLACE_NAME]
             componentsSeparatedByString:@", "] firstObject];
}

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
+ (NSString *)titleOfPhoto:(NSDictionary *)photo
{
    NSString *title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
    if ([title length]) return title;
    
    title = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title length]) return title;
    
    return FLICKR_UNKNOWN_PHOTO_TITLE;
}

+ (NSString *)subtitleOfPhoto:(NSDictionary *)photo
{
    NSString *title = [self titleOfPhoto:photo];
    if ([title isEqualToString:FLICKR_UNKNOWN_PHOTO_TITLE]) return @"";
    
    NSString *subtitle = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if ([title isEqualToString:subtitle]) return @"";
    
    return subtitle;
}

// sorteert de places op basis van de place name.
+ (NSArray *)sortPlaces:(NSArray *)places{

    return [places sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *name1 = [obj1 valueForKeyPath:FLICKR_PLACE_NAME];
        NSString *name2 = [obj2 valueForKeyPath:FLICKR_PLACE_NAME];
        return [name1 localizedCompare:name2];
    }];
}

// Er is een dictionary met countries als keys. En voor elke place bekijkt het de country en zet hij de place in een array die bij de desbetreffende key hoort. 
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

// pakt alle keys en sorteerd deze.
+ (NSArray *)sortCountries:(NSDictionary *)placesByCountry{
    NSArray *countries = [placesByCountry allKeys];
    NSArray *sortedArray = [countries sortedArrayUsingSelector:
                   @selector(localizedCaseInsensitiveCompare:)];
    return sortedArray;
}


@end
