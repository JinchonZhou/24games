//
//  ViewController.m
//  24games
//
//  Created by Jinchong on 5/21/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "startPageVC.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
@end
@implementation ViewController

@synthesize input_state;
@synthesize button_firstarg, button_oper;
@synthesize game_mode;
@synthesize first_arg, combine_times, v1, v2, v3, v4, time_remain_val, curr_point_val;
@synthesize label_title;
@synthesize button_operand1, button_operand2, button_operand3, button_operand4, button_operator_plu, button_operator_min, button_operator_multi, button_operator_div, button_reset, button_showans, button_nextplay;

@synthesize game_answer;

@synthesize label_result, label_timeremain, label_points, back_home;

@synthesize time_counter;
@synthesize my_calling_controller;

//method called when click the home button, it goes back to the home
//and pass the point earned to the home page.
-(void)homeMethod{
    __block ViewController *object = self;
    [self dismissViewControllerAnimated:NO completion:^{
        [object.my_calling_controller setToStart];
    }];
}

//
-(void) timer{
    time_remain_val--;
    if (time_remain_val <= 0){
        [time_counter invalidate];
        time_counter = nil;
        self.my_calling_controller.point_val = curr_point_val;
        [self dismissViewControllerAnimated:NO completion:^{
            [self.my_calling_controller setToResult];
        }];
    }
    [self.label_timeremain setText: [NSString stringWithFormat:@"Time remaining: %i seconds", time_remain_val]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.time_remain_val = total_time;
    if (self.game_mode == mode_time){
        //time mode
        time_counter = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(timer)
                                              userInfo:nil
                                               repeats:YES];
        [self.label_timeremain setText: [NSString stringWithFormat:@"Time remaining: %li seconds", (long)time_remain_val]];
        self.button_showans.hidden = YES;
        self.button_nextplay.hidden = YES;
    }else{
        [self.label_timeremain setText: [NSString stringWithFormat:@"Time remaining: UNLIMITED"]];
    }
    [label_title setFont:[UIFont fontWithName:@"Georgia-BoldItalic" size:13]];
    [button_operand1.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:13]];
    [button_operand2.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:13]];
    [button_operand3.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:13]];
    [button_operand4.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:13]];
    [button_operator_plu.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:15.5]];
    [button_operator_min.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:15.5]];
    [button_operator_multi.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:15.5]];
    [button_operator_div.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:15]];
    [button_reset.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [button_showans.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [button_nextplay.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [label_result setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [label_timeremain setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [label_points setFont:[UIFont fontWithName:@"Georgia-Bold" size:13.5]];
    [back_home.titleLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:12]];
    [button_showans setBackgroundColor: [UIColor blueColor]];
    [[button_operand1 layer] setBorderWidth:1.0f];
    [[button_operand1 layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operand2 layer] setBorderWidth:1.0f];
    [[button_operand2 layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operand3 layer] setBorderWidth:1.0f];
    [[button_operand3 layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operand4 layer] setBorderWidth:1.0f];
    [[button_operand4 layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[button_operator_plu layer] setBorderWidth:1.0f];
    [[button_operator_plu  layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operator_min layer] setBorderWidth:1.0f];
    [[button_operator_min layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operator_multi layer] setBorderWidth:1.0f];
    [[button_operator_multi layer] setBorderColor:[UIColor blackColor].CGColor];
    [[button_operator_div layer] setBorderWidth:1.0f];
    [[button_operator_div layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [self start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDidEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];

}

- (void)handleDidEnterBackground:(NSNotification *)notification
{
    if (time_counter)
        [time_counter invalidate];
    
//    [[NSNotificationCenter defaultCenter] po]
}

- (void)handleDidEnterForeground:(NSNotification *)notification
{
    time_counter = [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(timer)
                                       userInfo:nil
                                       repeats:YES];
  
}
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIApplicationWillEnterForegroundNotification object:nil];
}

-(void) reset{
    self.input_state = state_init;
    self.first_arg = 0;
    self.button_firstarg = 0;
    self.combine_times = 0;
    self.label_result.hidden = YES;
    [self.button_operand1 setBackgroundColor: [UIColor greenColor]];
    [self.button_operand2 setBackgroundColor: [UIColor greenColor]];
    [self.button_operand3 setBackgroundColor: [UIColor greenColor]];
    [self.button_operand4 setBackgroundColor: [UIColor greenColor]];
    [self.button_operator_plu setBackgroundColor: [UIColor greenColor]];
    [self.button_operator_min setBackgroundColor: [UIColor greenColor]];
    [self.button_operator_multi setBackgroundColor: [UIColor greenColor]];
    [self.button_operator_div setBackgroundColor: [UIColor greenColor]];
    [self.button_operand1 setTitle:[NSString stringWithFormat: @"%li", (long) self.v1] forState: UIControlStateNormal];
    [self.button_operand2 setTitle:[NSString stringWithFormat: @"%li", (long) self.v2] forState: UIControlStateNormal];
    [self.button_operand3 setTitle:[NSString stringWithFormat: @"%li", (long) self.v3] forState: UIControlStateNormal];
    [self.button_operand4 setTitle:[NSString stringWithFormat: @"%li", (long) self.v4] forState: UIControlStateNormal];
}

-(void) start{
    [self reset];

    BOOL isSuccess = NO;
    while (!isSuccess){
        self.v1 = arc4random() % 10 + 1;
        self.v2 = arc4random() % 10 + 1;
        self.v3 = arc4random() % 10 + 1;
        self.v4 = arc4random() % 10 + 1;
        isSuccess = [self findAnswerV2];
        NSLog(@"success or not: %i", isSuccess);
        if (!isSuccess){
            NSLog(@"%li %li %li %li", (long)self.v1, (long) self.v2, (long) self.v3, (long) self.v4);
        }
    }
    
    [self.button_operand1 setTitle:[NSString stringWithFormat: @"%li", (long) self.v1] forState: UIControlStateNormal];
    [self.button_operand2 setTitle:[NSString stringWithFormat: @"%li", (long) self.v2] forState: UIControlStateNormal];
    [self.button_operand3 setTitle:[NSString stringWithFormat: @"%li", (long) self.v3] forState: UIControlStateNormal];
    [self.button_operand4 setTitle:[NSString stringWithFormat: @"%li", (long) self.v4] forState: UIControlStateNormal];
    [self.button_reset setTitle:@"Reset" forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)findAnswerHelper: (NSMutableArray*) remainOperand currAnswer: (NSMutableArray*) tempAnswer answers:(NSMutableArray*) answerSet{
    
    int cnt =[remainOperand count];
    if (cnt == 1){
        
        if ([[remainOperand lastObject]integerValue] == 24){
            [answerSet addObject: tempAnswer];
        }
        return;
    }
    
    else{
        NSMutableArray *copy1 = [NSMutableArray arrayWithArray: remainOperand];
        NSMutableArray *copy2 = [NSMutableArray arrayWithArray: tempAnswer];
        for (int i = 0; i < cnt - 1; i++){
            for (int j = i + 1; j < cnt; j++){
              
                NSInteger arg1 = [[remainOperand objectAtIndex:i] integerValue];
                [remainOperand removeObjectAtIndex:i];
                NSInteger arg2 = [[remainOperand objectAtIndex:j-1] integerValue];
                [remainOperand removeObjectAtIndex:j-1];
                NSMutableArray *copyRemainOperand = [NSMutableArray arrayWithArray: remainOperand];
                NSMutableArray *copyTempAnswer = [NSMutableArray arrayWithArray: tempAnswer];
                
                //6 branches
                NSInteger combine = arg1 + arg2;
                
                [remainOperand addObject: [NSNumber numberWithInt: combine]];
                NSString *temp = [NSString stringWithFormat:@"%li + %li = %li", (long)arg1, (long)arg2, (long)combine];
                [tempAnswer addObject: temp];
                [self findAnswerHelper:remainOperand currAnswer:tempAnswer answers:answerSet];
        
                //arg1 - arg2
                remainOperand = [NSMutableArray arrayWithArray: copyRemainOperand];
                tempAnswer = [NSMutableArray arrayWithArray: copyTempAnswer];
                if (arg1 >= arg2){
                    combine = arg1 - arg2;
                    temp = [NSString stringWithFormat:@"%li - %li = %li", (long)arg1, (long)arg2, (long)combine];
                }else{
                    combine = arg2 - arg1;
                    temp = [NSString stringWithFormat:@"%li - %li = %li", (long)arg2, (long)arg1, (long)combine];
                }
                
                [remainOperand addObject: [NSNumber numberWithInt: combine]];
                [tempAnswer addObject: temp];
                [self findAnswerHelper:remainOperand currAnswer:tempAnswer answers:answerSet];
                
                //arg1 * arg2
                remainOperand = [NSMutableArray arrayWithArray: copyRemainOperand];
                tempAnswer = [NSMutableArray arrayWithArray: copyTempAnswer];
                combine = arg1 * arg2;
                [remainOperand addObject: [NSNumber numberWithInt: combine]];
                temp = [NSString stringWithFormat:@"%li * %li = %li", (long)arg1, (long)arg2, (long)combine];
                [tempAnswer addObject: temp];
                [self findAnswerHelper:remainOperand currAnswer:tempAnswer answers:answerSet];
                
                //arg1 / arg2
                if (arg2 != 0 && arg1 % arg2 == 0){
                    remainOperand = [NSMutableArray arrayWithArray: copyRemainOperand];
                    tempAnswer = [NSMutableArray arrayWithArray: copyTempAnswer];
                    combine = arg1 / arg2;
                    
                    [remainOperand addObject: [NSNumber numberWithInt: combine]];
                    temp = [NSString stringWithFormat:@"%li / %li = %li", (long)arg1, (long)arg2, (long)combine];
                    [tempAnswer addObject: temp];
                    [self findAnswerHelper:remainOperand currAnswer:tempAnswer answers:answerSet];
                    
                }

                //arg2 / arg1
                if (arg1 != 0 && arg2 % arg1 == 0){
                    remainOperand = [NSMutableArray arrayWithArray: copyRemainOperand];
                    tempAnswer = [NSMutableArray arrayWithArray: copyTempAnswer];
                    combine = arg2 / arg1;
                    
                    [remainOperand addObject: [NSNumber numberWithInt: combine]];
                    temp = [NSString stringWithFormat:@"%li / %li = %li", (long)arg2, (long)arg1, (long)combine];
                    [tempAnswer addObject: temp];
                    [self findAnswerHelper:remainOperand currAnswer:tempAnswer answers:answerSet];
                }
                remainOperand = [NSMutableArray arrayWithArray: copy1];
                tempAnswer = [NSMutableArray arrayWithArray: copy2];
            }
        }
    }
}

-(BOOL) findAnswerV2{
    
    NSMutableArray *fourValue = [[NSMutableArray alloc]initWithObjects: [NSNumber numberWithInt:self.v1], [NSNumber numberWithInt:self.v2], [NSNumber numberWithInt:self.v3], [NSNumber numberWithInt:self.v4], nil];
    NSMutableArray *finalAnswer = [[NSMutableArray alloc] init];
    
    [self findAnswerHelper: fourValue currAnswer:[[NSMutableArray alloc]init]  answers:finalAnswer];
    
    if ([finalAnswer count]){
        self.game_answer = [finalAnswer firstObject];
        return YES;
    }
    else
        return NO;
}

-(void) clickNumber:(id)sender{
    
    if ([[sender titleForState: UIControlStateNormal] isEqualToString:@""])
        return;
    if (self.input_state == state_init){
        self.first_arg = [[sender titleForState:UIControlStateNormal] integerValue];
        [sender setBackgroundColor: [UIColor yellowColor]];
        self.input_state++;
        self.button_firstarg = sender;
    }
    else if (self.input_state == state_firstArgPressed){
        
        [self setPrevButton];
        //if the same button has been clicked
        if (button_firstarg == sender){
            button_firstarg = 0;
            input_state = state_init;
            first_arg = 0;
        }
        else{  //a different button has been clicked
            [sender setBackgroundColor: [UIColor yellowColor]];
            self.button_firstarg = sender;
            self.first_arg = [[sender titleForState:UIControlStateNormal] integerValue];
        }
    }
    else if (self.input_state == state_operatorPressed){
        NSInteger second = [[sender titleForState:UIControlStateNormal]
                            integerValue];
        NSInteger tempAnswer = [self calculate: second];
        //if the same button has been clicked
        if (button_firstarg == sender || tempAnswer == 100000){
            [self setPrevButton];
            [self setPrevOperator];
            button_firstarg = 0;
            input_state = state_init;
            first_arg = 0;
            button_oper = nil;
        }
        
        else{

            [sender setTitle:[NSString stringWithFormat:@"%li", (long)tempAnswer] forState:UIControlStateNormal];
            [self setPrevButton];
            [self setPrevButton2];
            [self setPrevOperator];
            button_firstarg = 0;
            input_state = state_init;
            first_arg = 0;
            button_oper = nil;
            combine_times ++;
            if (combine_times == 3){
                if (game_mode != 1){
                    //practice mode
                    self.label_result.hidden = NO;
                    if (tempAnswer == 24){
                        [self.label_result setText:@"You win! Click next play to continue."];
                        curr_point_val++;
                        [self.label_points setText: [NSString stringWithFormat:@"Points: %i", curr_point_val]];
                    }
                    else{
                        [self.label_result setText:@"This does not give 24! Reset to try again or show answer."];
                    }
                }
                else{
                    
                    if (tempAnswer == 24){
                        [self.label_result setText:@"You get it!"];
                        curr_point_val++;
                        [self.label_points setText: [NSString stringWithFormat:@"Points: %i", curr_point_val]];
                        [self nextPlay];
                    }
                    else{
                        [self.label_result setText:@"This does not give 24! Reset to try again!"];
                        self.label_result.hidden = NO;
                    }
                }
   
            }
        }
    }
}

-(void) clickOperator:(id)sender{
    if (self.input_state == state_firstArgPressed){
        self.button_oper = sender;
        [sender setBackgroundColor: [UIColor yellowColor]];
        self.input_state++;
    }
    else if (self.input_state == state_operatorPressed){
        [self setPrevOperator];
        if (button_oper == sender){
            self.input_state = state_firstArgPressed;
            return;
        }
        [sender setBackgroundColor: [UIColor yellowColor]];
        self.button_oper = sender;
    }
    //NSLog(@"...");
}

-(void)showAnswer{
    self.label_result.hidden = NO;
    [self.label_result setText: [NSString  stringWithFormat:  @"%@\n %@\n %@\n", [self.game_answer objectAtIndex:0], [self.game_answer objectAtIndex:1], [self.game_answer objectAtIndex:2] ]];
}
-(void) nextPlay{
    [self start];
}

-(NSInteger)calculate: (NSInteger) second{
    if (button_oper == button_operator_plu)
        return second + self.first_arg;
    else if (button_oper == button_operator_min)
        return abs(self.first_arg - second);
    else if (button_oper == button_operator_multi)
        return self.first_arg * second;
    else if (button_oper == button_operator_div){
        if (self.first_arg % second)
            return 100000;
        else
            return self.first_arg / second;
    }
    else
        NSLog(@"some error may happen");
    return -1;
}

-(void)setPrevButton{
    [self.button_firstarg setBackgroundColor: [UIColor greenColor]];
}

-(void)setPrevButton2{
    [self.button_firstarg setTitle: @"" forState: UIControlStateNormal];
}

-(void) setPrevOperator{
    [self.button_oper setBackgroundColor: [UIColor greenColor]];
}
@end
