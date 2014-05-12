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

#warning favorite tab?! + hamburger icon

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [RecentPhotos allPhotos];
    [self.tableView reloadData];
}

- (IBAction)clearPhotos:(UIBarButtonItem *)sender {
    [RecentPhotos clearPhotos];
    self.photos = [RecentPhotos allPhotos];
    [self.tableView reloadData];
}
@end
