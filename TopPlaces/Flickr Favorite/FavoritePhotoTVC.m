//
//  FavoritePhotoTVC.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/12/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "FavoritePhotoTVC.h"
#import "RecentPhotos.h"

@interface FavoritePhotoTVC ()

@end

@implementation FavoritePhotoTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [RecentPhotos allFavoritePhotos];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [RecentPhotos clearFavoritePhoto:self.photos[indexPath.row]];
        
        // gives the user an alert box
        UIAlertView *alertFavo = [[UIAlertView alloc] initWithTitle:@"Success" message:@"photo deleted from favorites" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil, nil];
        [alertFavo show];
        // after the delete, you must call the recentphotos method again to reset the values.
        self.photos = [RecentPhotos allFavoritePhotos];
        [self.tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



@end
