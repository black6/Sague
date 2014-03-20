//
//  Second_VC.m
//  Segue
//
//  Created by Bahry Yasin on 12/03/2014.
//  Copyright (c) 2014 FalconsSoft. All rights reserved.
//

#import "Second_VC.h"

@interface Second_VC ()
@property (nonatomic, weak) IBOutlet UILabel *lblText;
@end

@implementation Second_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lblText.text = _sText;
}

-(IBAction)back
{
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(-frame.size.width, 0);
    
    [UIView animateWithDuration:0.4f animations:^(void)
     {
         self.view.frame = frame;
     } completion:^(BOOL finish)
     {
         [self.view removeFromSuperview];
         [self willMoveToParentViewController:nil];
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
