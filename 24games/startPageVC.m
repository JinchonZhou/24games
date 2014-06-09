//
//  startPageVC.m
//  24games
//
//  Created by Jinchong on 5/23/14.
//  Copyright (c) 2014 Jinchong. All rights reserved.
//

#import "startPageVC.h"
#import "ViewController.h"

@interface startPageVC ()
@end
@implementation startPageVC
@synthesize point_val, point_display_label, start_view, result_view, start_new_game, welcome_label, practice_mode_button, time_mode_button, back_home_button;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *dest = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"time"]  || [[segue identifier] isEqualToString:@"anotherTime"]) {
        dest.game_mode = mode_time;
        dest.my_calling_controller = self;
    }else{
        dest.game_mode = mode_practice;
        dest.my_calling_controller = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.start_new_game.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [welcome_label setFont:[UIFont fontWithName:@"Zapfino" size:10.5]];
    [practice_mode_button.titleLabel setFont:[UIFont fontWithName:@"Optima" size:14]];
    [time_mode_button.titleLabel setFont:[UIFont fontWithName:@"Optima" size:14]];
    [start_new_game.titleLabel setFont:[UIFont fontWithName:@"Optima" size:14]];
    [back_home_button.titleLabel setFont:[UIFont fontWithName:@"Optima" size:14]];
    [point_display_label setFont:[UIFont fontWithName:@"Zapfino" size:14]];
    [self setToStart];
}

-(void) setToStart{
    result_view.hidden = YES;
    start_view.hidden = NO;
}

-(void) setToResult{
    result_view.hidden = NO;
    start_view.hidden = YES;
    if (point_val > 1)
        [self.point_display_label setText:[NSString stringWithFormat:@"You get %li points.", (long) point_val]];
    else
        [self.point_display_label setText:[NSString stringWithFormat:@"You get %li point.", (long) point_val]];
        
}

-(IBAction) backHome:(id)sender
{
    [self setToStart];
}
@end