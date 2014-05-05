//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/5/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end

@implementation ImageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
     NSData *test = [NSData dataWithContentsOfURL:self.imageURL];
    UIImage *image = [UIImage imageWithData:test];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    [self.view addSubview:imageView];

    [self.scroll setContentSize:image.size];
}


@end
