//
//  MyViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MyViewController.h"
#import "CreateNewChallengeViewController.h"

@interface MyViewController ()
{

}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    Doesn't init IBOutlets
//    NSString * vcName = @"createNew";
//    NSString * sbName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
//    CreateNewChallengeViewController *detailViewController = [storyboard instantiateViewControllerWithIdentifier:vcName];
//    [self.navigationController pushViewController:detailViewController animated:YES];
    
//    Doesn't init IBOutlets
//    [self performSegueWithIdentifier:@"GotoCreateNewChallengeViewController" sender:self];
    
//    Doesn't init IBOutlets and it doesn't fire awakeFromNib
//         CreateNewChallengeViewController *detailViewController = [[CreateNewChallengeViewController alloc] initWithNibName:@"CreateNewChallengeViewController" bundle:nil];
//        [self.navigationController pushViewController:detailViewController animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
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

@end
