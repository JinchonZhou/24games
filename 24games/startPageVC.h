//
//  startPageVC.h
//  24games
//
//  Created by Jinchong on 5/23/14.
//  Copyright (c) 2014 Jinchong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface startPageVC : UIViewController

//
@property(nonatomic) NSInteger point_val;
@property (nonatomic, strong) IBOutlet UILabel *point_display_label, *welcome_label;
@property(nonatomic, strong) IBOutlet UIView *start_view, *result_view;
@property(nonatomic, strong) IBOutlet UIButton *start_new_game,  *practice_mode_button, *time_mode_button, *back_home_button;
-(void) setToStart;
-(void) setToResult;
@end
