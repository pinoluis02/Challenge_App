//
//  MyViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MyViewController.h"
#import "CreateNewChallengeViewController.h"
#import "GlobalContextPseudoTabController.h"
#import "ContactsViewController.h"

@interface MyViewController ()
{
    CreateNewChallengeViewController *createNewChallengeViewController;
    GlobalContextPseudoTabController *globalContextPseudoTabController;
    ContactsViewController *contactsViewController;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    [self.loginButton setDelegate:self];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
}


- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult: (FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
    if (error)
    {
        // There is an error here.
    }
    else
        if(result.token)   // This means if There is current access token.
        {
            [self fetchUserInfo];
        }
    
}

-(void)fetchUserInfo {
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             
             if ([result objectForKey:@"name"]) {
                 NSLog(@"Name : %@",[result objectForKey:@"name"]);
             }
             if ([result objectForKey:@"id"]) {
                 NSString *idFbUser = [result objectForKey:@"id"];
                 NSLog(@"User id : %@",[result objectForKey:@"id"]);
                 
                 //Call API to check if exist user.......
                 
                 
                 // After API Response change to TabController
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 UITabBarController *tabBarController = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                 tabBarController.selectedIndex = 0;
                 
                 
                 NSMutableArray *listOfViewControllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
                 
                 globalContextPseudoTabController = (GlobalContextPseudoTabController*)[listOfViewControllers objectAtIndex:0];
                 globalContextPseudoTabController.idLoginUser = idFbUser;
                
                 contactsViewController = (ContactsViewController*) [listOfViewControllers objectAtIndex:1];
                 contactsViewController.idLoginUser = idFbUser;
                 
                 globalContextPseudoTabController = (GlobalContextPseudoTabController*)[listOfViewControllers objectAtIndex:2];
                 globalContextPseudoTabController.idLoginUser = idFbUser;
                 
                 UINavigationController *navigationController = (UINavigationController*)[listOfViewControllers objectAtIndex:3];
                 createNewChallengeViewController = (CreateNewChallengeViewController*)navigationController.topViewController;
                 createNewChallengeViewController.idLoginUser = idFbUser;
                 
                 [tabBarController setViewControllers:listOfViewControllers animated:YES];
                 
                //[self performSegueWithIdentifier:@"segueToTabBar" sender:self.btnLogin];
                 [self presentViewController:tabBarController animated:NO completion:nil];
             }
         }
     }];
}


- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"facebook logout button test");
    
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"segueToTabBar"])
//    {
//        [segue destinationViewController];
//    }
//}

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
