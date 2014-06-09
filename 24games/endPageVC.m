//
//  endPageVC.m
//  24games
//
//  Created by Jinchong on 5/27/14.
//  Copyright (c) 2014 Jinchong. All rights reserved.
//

#import "endPageVC.h"

@interface endPageVC ()

@end

@implementation endPageVC
@synthesize pointShow, mypoint;

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
    [self.mypoint setText:[NSString stringWithFormat:@"You get %li points.", (long) pointShow]];
    
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
