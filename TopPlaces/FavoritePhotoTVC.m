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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [RecentPhotos allFavoritePhotos];
    [self.tableView reloadData];
}


@end
