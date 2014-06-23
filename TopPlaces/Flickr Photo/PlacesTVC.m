//
//  TopPhotoOfPlacesViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/4/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "PlacesTVC.h"
#import "TopPlacesFlickrFetcher.h"
#import "ImageViewController.h"
#import "RecentPhotos.h"

@interface PlacesTVC ()
@end

@implementation PlacesTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"image";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo = self.photos[indexPath.row];
    
    cell.textLabel.text = [TopPlacesFlickrFetcher titleOfPhoto:photo];
    cell.detailTextLabel.text = [TopPlacesFlickrFetcher subtitleOfPhoto:photo];

    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    if ([detail isKindOfClass:[ImageViewController class]]) {
        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
    }
}

// segue to the imageViewController
- (void)prepareImageViewController:(ImageViewController *)tvc
                    toDisplayPhoto:(NSDictionary *)photo
{
    tvc.imageData = photo;
    tvc.title = [TopPlacesFlickrFetcher titleOfPhoto:photo];
    // when the user clicked on a photo, add it to the recentphotos array
    [RecentPhotos addPhoto:photo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    if ([segue.identifier isEqualToString:@"picture"]) {
        if([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
            [self prepareImageViewController:segue.destinationViewController
                          toDisplayPhoto:self.photos[indexPath.row]];
        }
        
    }
}

@end
