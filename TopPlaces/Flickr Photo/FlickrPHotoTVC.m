//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 4/30/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "FlickrPhotoTVC.h"
#import "TopPlacesFlickrFetcher.h"
#import "PlacesTVC.h"

@interface FlickrPhotoTVC ()
@property (nonatomic, strong) NSArray *sortedPlaces;
@property (nonatomic, strong) NSArray *sortedUniqueCountries;
@property (nonatomic, strong) NSDictionary *placesByCountry;
@end

@implementation FlickrPhotoTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    _sortedPlaces = [TopPlacesFlickrFetcher sortPlaces:self.photos];
    _placesByCountry = [TopPlacesFlickrFetcher placesByCountry:self.sortedPlaces];
    _sortedUniqueCountries = [TopPlacesFlickrFetcher sortCountries:self.placesByCountry];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sortedUniqueCountries count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.placesByCountry [self.sortedUniqueCountries[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *place = self.placesByCountry[self.sortedUniqueCountries[indexPath.section]][indexPath.row];
    cell.textLabel.text = [TopPlacesFlickrFetcher titleOfPlace:place];
    cell.detailTextLabel.text = [TopPlacesFlickrFetcher subtitleOfPlace:place];
    

    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sortedUniqueCountries[section];
}

// segue to the PlacesTVC and sets the place that the user has clicked on
- (void)preparePhotosTVC:(PlacesTVC *)tvc
                forPlace:(NSDictionary *)place
{
    tvc.place = place;
    tvc.title = [TopPlacesFlickrFetcher titleOfPlace:place];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.identifier isEqualToString:@"pictures"]) {
        if([segue.destinationViewController isKindOfClass:[PlacesTVC class]]){
            [self preparePhotosTVC:segue.destinationViewController
                          forPlace:self.placesByCountry[self.sortedUniqueCountries[indexPath.section]][indexPath.row]];
        }

    }
}

@end
