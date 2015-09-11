//
//  NewChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NewChallengeViewController.h"

@interface NewChallengeViewController ()

@end

@implementation NewChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addMediaButton:(UIButton *)sender
{
    NSLog(@"This is the button to add Media to the File Server");
}

- (IBAction)makeDonationSwith:(UISwitch *)sender
{
    if ([sender isOn])
    {
        [self performSegueWithIdentifier:@"ShowDontationSegue" sender:self];
    }
    else
    {
        NSLog(@"Donataion is Off");
    }
}

- (IBAction)submitChallengeButton:(UIButton *)sender
{
    NSLog(@"Submit button action pressed");
}



@end
