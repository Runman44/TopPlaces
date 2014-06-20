//
//  MostRecentTableViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/9/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "MostRecentTVC.h"
#import "RecentPhotos.h"

@interface MostRecentTVC ()

@end

@implementation MostRecentTVC

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [RecentPhotos allPhotos];
    [self.tableView reloadData];
}

- (IBAction)clearPhotos:(UIBarButtonItem *)sender {
    [RecentPhotos clearPhotos];
    self.photos = [RecentPhotos allPhotos];
    [self.tableView reloadData];
    
    UIAlertView *alertFavo = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Most recent photos are cleared" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil, nil];
    [alertFavo show];
}
@end
