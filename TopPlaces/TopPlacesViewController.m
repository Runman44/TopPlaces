//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 4/30/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "TopPlacesFlickrFetcher.h"

@interface TopPlacesViewController ()

@end

@implementation TopPlacesViewController

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSDictionary *test = [TopPlacesFlickrFetcher uniqueCountries:self.photos];
    NSArray *test2 = [TopPlacesFlickrFetcher sortCountries:test];
    NSLog(@"%d", [test2 count]);
    return [test2 count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *test = [TopPlacesFlickrFetcher uniqueCountries:self.photos];
    NSArray *test2 = [TopPlacesFlickrFetcher sortCountries:test];
    return [test [test2 [section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *test = [TopPlacesFlickrFetcher uniqueCountries:self.photos];
    NSArray *test2 = [TopPlacesFlickrFetcher sortCountries:test];
    NSDictionary *place = test[test2[indexPath.section]][indexPath.row];
    cell.textLabel.text = [TopPlacesFlickrFetcher titleOfPlace:place];
    cell.detailTextLabel.text = [TopPlacesFlickrFetcher subtitleOfPlace:place];
    

    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *test = [TopPlacesFlickrFetcher uniqueCountries:self.photos];
    NSArray *test2 = [TopPlacesFlickrFetcher sortCountries:test];
    return test2[section];
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
