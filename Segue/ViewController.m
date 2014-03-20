//
//  ViewController.m
//  Segue
//
//  Created by Bahry Yasin on 12/03/2014.
//  Copyright (c) 2014 FalconsSoft. All rights reserved.
//

#import "ViewController.h"
#import "Second_VC.h"
#import "CABasicAnimation+Block.h"
#import "AFNetworking/AFHTTPRequestOperation.h"
#import "AFNetworking/AFHTTPRequestOperation.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *viewContainer, *viewLeft, *viewRight, *viewCenter, *viewTop, *viewBottom, *viewGestures, *containerView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextView *txt1, *txt2;
@property (nonatomic, weak) IBOutlet UIView *viewCold, *viewHover, *viewHot;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation ViewController
{
    BOOL bChange, bIsTop;
    BOOL bCenter, bLeft, bRight;
    
    UIView *top, *bottom;
}

@synthesize viewCold, viewHot, viewHover;

-(void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    bCenter = YES;
    bIsTop = YES;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.contentSize.height);
    
    UISwipeGestureRecognizer *gestureLeftToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftToRight)];
    gestureLeftToRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [_viewGestures addGestureRecognizer:gestureLeftToRight];
    [_viewGestures addGestureRecognizer:gestureLeftToRight];
    
    UISwipeGestureRecognizer *gestureRightToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightToLeft)];
    gestureRightToLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [_viewGestures addGestureRecognizer:gestureRightToLeft];
    [_viewGestures addGestureRecognizer:gestureRightToLeft];
    
    bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 463, 243)];
    bottom.backgroundColor = [UIColor redColor];
    
    top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 463, 243)];
    top.backgroundColor = [UIColor greenColor];
    
    [_viewContainer insertSubview:top belowSubview:_viewGestures];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(createDownloadTask) withObject:nil afterDelay:1];
}

-(void)createDownloadTask
{
    NSLog(@"Hello");
    UIColor *color = [UIColor colorWithRed:0.814 green:1.000 blue:0.526 alpha:1.000];
    NSUInteger iCounter = 0;
    NSString *s = @"بسم الله الرحمن الرحيم";
    NSArray *arURLs = @[@"http://p1.pichost.me/i/45/1686211.jpg",
                        @"http://p1.pichost.me/i/45/1684453.jpg",
                        @"http://p1.pichost.me/i/45/1685303.jpg",
                        @"http://images2.alphacoders.com/475/475841.jpg",
                        @"http://www.wired.com/images_blogs/rawfile/2013/11/offset_WaterHouseMarineImages_62652-2-660x440.jpg",
                        @"http://zonehdwallpapers.com/wp-content/uploads/2013/02/Blue-Background-Images-HD-Wallpaper.jpg",
                        @"http://static3.businessinsider.com/image/52a0bbfd6bb3f7961363819e/the-most-amazing-satellite-images-of-the-year.jpg"];
    
    CGFloat iCount = arURLs.count;
    __block CGFloat iCurrent = 0, fProgress = 0;
    
    [_indicator startAnimating];
    
    for(NSUInteger x = 0; x < iCount; x++)
    {
        NSLog(@"url %@", arURLs[x]);
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:arURLs[x]]];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            iCurrent++;
            fProgress = iCurrent / iCount;
            _progressView.progress = fProgress;
            //NSLog(@"Response: %@ %f %f", responseObject, iCount, iCurrent);
            _imageView.image = responseObject;
            //1716002
            
            if(iCurrent == iCount)
                [_indicator stopAnimating];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"Image error: %@", error);
        }];
        
        [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpected)
         {
             //_progressView.progress = totalBytesRead / totalBytesExpected;
             //NSLog(@"bytesRead : %d totalBytesRead %lld totalBytesExpected %lld", bytesRead,  totalBytesRead, totalBytesExpected);
         }];
        
        [requestOperation start];
    }
    
//    AFHTTPClient *requestHandler = [[AFHTTPClient alloc] init];
//    [requestHandler enqueueBatchOfHTTPRequestOperations:operations progressBlock:^(NSUInteger numberOfCompletedOperations, NSUInteger totalNumberOfOperations) {
//        
//    } completionBlock:^(NSArray *operations) {
//    }];
}

-(void)animateTheImage
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @700;
    animation.fromValue = @(_imageView.layer.position.x);
    animation.duration = 0.5f;
    animation.autoreverses = YES;
    animation.repeatCount = 2;
    
    //[_imageView.layer addAnimation:animation forKey:@"goleft"];
    /*
    CABasicAnimation *anotherAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anotherAnimation.fromValue = @(self.imageView.layer.position.x);
    anotherAnimation.toValue = @600;
    anotherAnimation.duration = 2;
    [self.imageView.layer addAnimation:anotherAnimation forKey:@"1"];
     */
}

-(IBAction)NEXTCONTROLLER
{
    Second_VC *second = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"VC_Second"];
    CGRect frame = second.view.frame;
    frame.origin = CGPointMake(-frame.size.width, 0);
    second.view.frame = frame;
    frame.origin = CGPointMake(0, 0);
    
    //[self presentViewController:second animated:NO completion:nil];
    [self addChildViewController:second];
    [self.view addSubview:second.view];
    [second willMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.4f animations:^(void)
    {
        second.view.frame = frame;
    }];
    
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.7f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade; //kCATransitionMoveIn,kCATransitionReveal, kCATransitionFade, kCATransitionPush,
//    //transition.subtype = kCATransitionFromTop; //kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromLeft, kCATransitionFromBottom
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    [[self navigationController] popViewControllerAnimated:NO];
}

-(IBAction)geToLeft
{
    [self animateTheImage];
    bLeft = YES;
    bCenter = bRight = NO;
    [self changeStyle];
}

-(IBAction)geToRight
{
    [self animateTheImage];
    bRight = YES;
    bCenter = bLeft = NO;
    
    [self changeStyle];
}

-(void)swipeRightToLeft
{
    bLeft = NO;
    
    [self changeStyle];
}

-(void)swipeLeftToRight
{
    bLeft = YES;
    
    [self changeStyle];
}

-(IBAction)changeStyle
{
    /*
    bChange = !bChange;
    [UIView animateWithDuration:0.3f animations:^(void)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }];
*/
    UIViewAnimationOptions option = UIViewAnimationOptionTransitionCurlDown;
    if(bLeft)
        option = UIViewAnimationOptionTransitionCurlUp;
    
    if(bIsTop && ![bottom superview])
        [_viewContainer addSubview:bottom];
    else if(![bottom superview])
        [_viewContainer addSubview:top];
    
    if(bIsTop)
    {
        [UIView transitionFromView:top toView:bottom duration:1 options:option completion:^(BOOL done)
         {
             [_viewContainer bringSubviewToFront:bottom];
             [_viewContainer bringSubviewToFront:_viewGestures];
             [top removeFromSuperview];
         }];
    }
    else
    {
        [UIView transitionFromView:bottom toView:top duration:1 options:option completion:^(BOOL done)
         {
             [_viewContainer bringSubviewToFront:top];
             [_viewContainer bringSubviewToFront:_viewGestures];
             [bottom removeFromSuperview];
         }];
    }
    
    bIsTop = !bIsTop;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return bChange ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show"])
    {
        
        Second_VC *second = (Second_VC*)segue.destinationViewController;
        second.sText = @"Hello";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
