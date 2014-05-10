//
//  ImageViewController.m
//  TopPlaces
//
//  Created by Dennis Anderson on 5/5/14.
//  Copyright (c) 2014 MrAnderson. All rights reserved.
//

#import "ImageViewController.h"
#import "TopPlacesFlickrFetcher.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
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
    [self fetch];

}

-(void)fetch{
    [self.spinner startAnimating];
    dispatch_queue_t fetchPhoto = dispatch_queue_create("picture of photo", NULL);
    dispatch_async(fetchPhoto, ^(void){
        NSURL *imageURL = [TopPlacesFlickrFetcher URLforPhoto:self.imageData format:FlickrPhotoFormatLarge];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //self.scrollView.zoomScale = 1.0;
            self.imageView.image = [UIImage imageWithData:imageData];
            
            self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
            [self setZoomScale];
            [self.spinner stopAnimating];
        });
    });
}

- (void) setZoomScale
{
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.zoomScale = minScale;


}
#warning de scaling werkt nog niet lekker ! 
#warning zoom in werkt ook nog niet lekkkuur !!

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
    barButtonItem.title = aViewController.title;
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}




@end
