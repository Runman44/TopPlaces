//
//  TopPhotoViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/4/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "RecentPlacesTVC.h"
#import "FlickrFetcher.h"

@interface RecentPlacesTVC ()

@end

@implementation RecentPlacesTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self fetchPhotos];
}

// fetch photos from Flickr from a certain place and set them in self.photos
- (IBAction) fetchPhotos
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t fetchPhoto = dispatch_queue_create("photos in place", NULL);
    dispatch_async(fetchPhoto, ^(void){
        NSURL *url = [FlickrFetcher URLforPhotosInPlace:[self.place valueForKeyPath:FLICKR_PLACE_ID] maxResults:50];
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });
    
}

@end
