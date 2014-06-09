//
//  ViewController.h
//  24games
//
//  Created by Jinchong on 5/21/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "startPageVC.h"
//is this the right way to define a global constant?
static const NSInteger total_time = 100;
@interface ViewController : UIViewController

//there is three state for input state (the state of the operand and operator being pressed)
//init is the initial state, no operand is pressed
//firstArgPressed pressed is the state that one operand is being pressed, but the operator has not been pressed.
//operatorPressed is the state that the operator has been pressed, and it waits the second operand to be pressed.
typedef enum state_t{
    state_init = 0,
    state_firstArgPressed,
    state_operatorPressed
} state_t;

typedef enum mode{
    mode_notset = 0,
    mode_time,
    mode_practice
} mode;

//input_state records the input state of the game. (three possible states)
@property state_t input_state;

//The Button of the first argument being pressed
@property UIButton *button_firstarg, *button_oper;

//mod is either timed or practice
@property mode game_mode;

//firstArg is the value of the first operand
//firstButtonId is the index of the first Button
//there are 3 states (0-2)
//v1-v4 is the value shown on the four buttons of operand.
//combineTimes is the number of times doing the arithmetics (0 - 3), when it is three, judge whether the final answer gives 24
//time_remain_val is the time remaining for the time mode game, not applicable for practice mode
//curr_point_val is the point already earned by the gamer
@property (nonatomic) NSInteger first_arg, combine_times, v1, v2, v3, v4, time_remain_val, curr_point_val;

@property (nonatomic, strong) IBOutlet UILabel *label_title;
//b1 - b4  is the four UIButtons, plu - div
@property (nonatomic, strong) IBOutlet UIButton *button_operand1, *button_operand2, *button_operand3, *button_operand4, *button_operator_plu, *button_operator_min, *button_operator_multi, *button_operator_div, *button_reset, *button_showans, *button_nextplay, *back_home;

//the answer of the 24 games
@property (nonatomic, strong) NSArray *game_answer;


@property(nonatomic, strong)IBOutlet UILabel *label_result, *label_timeremain, *label_points;

//time_counter is the timer for the game
@property(nonatomic, strong) NSTimer *time_counter;

//used to store the startPage that segues the game page, so that it can provide feedbacks of the points by the game
@property startPageVC *my_calling_controller;

-(IBAction)clickNumber:(id)sender;
-(IBAction)clickOperator:(id)sender;
-(IBAction)reset;
-(IBAction)showAnswer;
-(IBAction)nextPlay;
-(NSInteger)calculate:(NSInteger) second;
-(void) setPrevButton;
-(void) setPrevButton2;
-(void) start;
-(void)findAnswerHelper: (NSMutableArray*) remainOperand currAnswer: (NSMutableArray*) tempAnswer answers:(NSMutableArray*) answerSet;
-(void)timer;
-(IBAction)homeMethod;
@end
