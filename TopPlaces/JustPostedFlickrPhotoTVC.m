//
//  PlacePhotoViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 4/30/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "JustPostedFlickrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickrPhotoTVC ()

@end

@implementation JustPostedFlickrPhotoTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self fetchPhotos];
}

- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    NSURL *url = [FlickrFetcher URLforTopPlaces];
    dispatch_queue_t fetchPhoto = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchPhoto, ^(void){
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PLACES];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.refreshControl endRefreshing];
            self.photos = photos;
        });
    });
}



@end
