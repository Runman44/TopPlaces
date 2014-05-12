//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/5/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "ImageViewController.h"
#import "TopPlacesFlickrFetcher.h"
#import "RecentPhotos.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

- (void) setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale=0.2;
    _scrollView.maximumZoomScale=3.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView ? self.imageView.image.size : CGSizeZero;
}

- (void) setImageData:(NSDictionary *)imageData{
    _imageData = imageData;
    [self fetch];
}

- (void)setImage:(UIImage *)image
{
    self.scrollView.zoomScale = 1.0;
    self.imageView.image = image;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self setZoomScale];
    [self.spinner stopAnimating];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}

#pragma imageViewController Zooming

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void) setZoomScale
{
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.zoomScale = minScale;
}

-(void)fetch{
    [self.spinner startAnimating];
    dispatch_queue_t fetchPhoto = dispatch_queue_create("picture of photo", NULL);
    dispatch_async(fetchPhoto, ^(void){
        NSURL *imageURL = [TopPlacesFlickrFetcher URLforPhoto:self.imageData format:FlickrPhotoFormatLarge];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.image = [UIImage imageWithData:imageData];;
        });
    });
}



#warning de scaling werkt nog niet lekker ! 
#warning zoom in werkt ook nog niet lekkkuur !

#pragma SplitViewController - Delegate

- (void) awakeFromNib
{
    self.splitViewController.delegate = self;
}

- (BOOL) splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    //barButtonItem.title = aViewController.title;
    barButtonItem.image = [UIImage imageNamed:@"HamburgerIcon.png"];
      barButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}

@end
