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
@property (nonatomic, strong) NSDictionary * currentPhoto;
@end

@implementation PlacesTVC

- (IBAction)addToFavorite:(UIBarButtonItem *)sender {
    [RecentPhotos addPhotoToFavorite:self.currentPhoto];
}

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

- (void)prepareImageViewController:(ImageViewController *)tvc
                    toDisplayPhoto:(NSDictionary *)photo
{
    tvc.imageData = photo;
    tvc.title = [TopPlacesFlickrFetcher titleOfPhoto:photo];
    [RecentPhotos addPhoto:photo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    self.currentPhoto = self.photos[indexPath.row];
    if ([segue.identifier isEqualToString:@"picture"]) {
        if([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
            [self prepareImageViewController:segue.destinationViewController
                          toDisplayPhoto:self.currentPhoto];
        }
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
