//
//  SendChallengeRequestViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SendChallengeContainerViewController.h"
#import "SendChallengeViewController.h"

@interface SendChallengeContainerViewController ()

@end

@implementation SendChallengeContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMenuContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpMenuContent
{
    SendChallengeViewController * tableViewController =  [SendChallengeViewController new];
    self.tableViewController = tableViewController;
    [self addChildViewController:tableViewController];
    [self.tableView addSubview:tableViewController.view];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    tableViewController.view.frame = CGRectMake(0,0, screenRect.size.width, screenRect.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendRequestButton:(UIButton *)sender
{
    NSLog(@"Send request Action Button");
}
@end
