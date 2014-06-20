//
//  TopPlacesFlickrFetcher.h
//  TopPlaces
//
//  Created by Dennis Anderson on 5/2/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "FlickrFetcher.h"

@interface TopPlacesFlickrFetcher : FlickrFetcher

+ (NSString *)countryOfPlace:(NSDictionary *)place;
+ (NSString *)titleOfPlace:(NSDictionary *)place;
+ (NSString *)subtitleOfPlace:(NSDictionary *)place;
+ (NSArray *)sortPlaces:(NSArray *)places;
+ (NSDictionary *)placesByCountry:(NSArray *)places;
+ (NSArray *)sortCountries:(NSDictionary *)countries;
+ (NSString *)titleOfPhoto:(NSDictionary *)photo;
+ (NSString *)subtitleOfPhoto:(NSDictionary *)photo;


@end
