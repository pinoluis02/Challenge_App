//
//  ChallengesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengesRootController.h"
#import "Challenge.h"

@interface ChallengesRootController ()

@end

@implementation ChallengesRootController


-(NSString *)nibName{
    return @"CustomRootController";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)coordinateItemSelection:(Challenge *)item
           selectedByLongPress:(BOOL)longPress;
{
    
    if(longPress){
        NSDictionary * dict;
        //unrelated, invited, accepted (incomplete), rejected, completed.
        if([item.userStatus isEqualToString:@"unrelated"]){
            dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"unrelatedChallengeCommands" ofType:@"plist"]];
        }
        else if([item.userStatus isEqualToString:@"notified"]){
            dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notificationPendingChallengeCommands" ofType:@"plist"]];
        }
        else if([item.userStatus isEqualToString:@"accepted"]){
            dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"incompleteChallengeCommands" ofType:@"plist"]];
        }
        else if([item.userStatus isEqualToString:@"rejected"]){
            //        For this version rejected items behave the same as unrelated items.
            dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"unrelatedChallengeCommands" ofType:@"plist"]];
        }
        else if([item.userStatus isEqualToString:@"completed"]){
            dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"completedChallengeCommands" ofType:@"plist"]];
        }
        else{
            NSAssert(false, @"you made a mistake programmer");
        }
        
        NSArray * items =  [dict valueForKey:@"Items"];
        self.commandMenuController.itemsInTable = items;
    }
    else{
        CustomRootController * newSpan = [CustomRootController new];
        newSpan.userId = 99;
        [self.navigationController pushViewController:newSpan animated:true];
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
