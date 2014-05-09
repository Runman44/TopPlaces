//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/5/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewController

- (void) setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale=0.5;
    _scrollView.maximumZoomScale=3.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView ? self.imageView.image.size : CGSizeZero;
 
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];

    self.imageView.image = [UIImage imageWithData:imageData];
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.zoomScale = minScale;
}




@end
