//
//  MostRecentTableViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/9/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "MostRecentTableViewController.h"
#import "TopPlacesFlickrFetcher.h" 
#import "RecentPhotos.h"
#import "ImageViewController.h"

@interface MostRecentTableViewController ()

@end

@implementation MostRecentTableViewController



- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [RecentPhotos allPhotos];
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
    static NSString *CellIdentifier = @"Cell Recent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *photo = self.photos[indexPath.row];
    // Configure the cell...
    
    cell.textLabel.text = [TopPlacesFlickrFetcher titleOfPhoto:photo];
    cell.detailTextLabel.text = [TopPlacesFlickrFetcher subtitleOfPhoto:photo];
    return cell;
}

- (void)prepareImageViewController:(ImageViewController *)tvc
                    toDisplayPhoto:(NSDictionary *)photo
{
    tvc.imageData = photo;
    tvc.title = [TopPlacesFlickrFetcher titleOfPhoto:photo];
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
