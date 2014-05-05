//
//  TopPhotoViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/4/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "TopPhotoViewController.h"
#import "FlickrFetcher.h"

@interface TopPhotoViewController ()

@end

@implementation TopPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self fetchPhotos];
}

- (void) fetchPhotos
{
    NSURL *url = [FlickrFetcher URLforPhotosInPlace:[self.place valueForKeyPath:FLICKR_PLACE_ID] maxResults:50];
    dispatch_queue_t fetchPhoto = dispatch_queue_create("photos in place", NULL);
    dispatch_async(fetchPhoto, ^(void){
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.photos = photos;
        });
    });
    
}

@end
