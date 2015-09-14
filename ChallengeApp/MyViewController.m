//
//  MyViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MyViewController.h"
#import "CreateNewChallengeViewController.h"
#import "customRootController.h"
#import "ContactsViewController.h"

@interface MyViewController ()
{
    FbSingleton *fb;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Networking code
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    
    fb = [FbSingleton sharedInstance];
    fb.delegate = self;
    
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.loginButton setDelegate:self];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    //REACHABILITY
    NSString *url = @"http://www.facebook.com";
    NSURL *hostaddress = [[NSURL URLWithString:url] host];
    Reachability* r=[Reachability reachabilityWithHostName:hostaddress];
    NetworkStatus internetStatus=[r currentReachabilityStatus];
    if(internetStatus == NotReachable) {
        //inform user of unavailable network
        
        NSLog(@"No Connection");
        NSString *msg = @"Your Device has NO connection, this aplication needs connection to work";
        [self popAlert:@"Alert" msg:msg];
        self.loginButton.enabled = NO;
    }else{
        self.loginButton.enabled = YES;
   
    }
    
}

#pragma mark - loginButton didCompleteWithResult
- (void) loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult: (FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
        //  self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        self.loginButton.hidden = YES;
        
        if (error)
        {
            // There is an error here.
            NSLog(@"ERROR:%@",error);
            [self popAlert:@"Error" msg:[NSString stringWithFormat:@"%@",error]];
        }
        else
            if(result.token)   // This means if There is current access token.
            {
                [fb startDownloadingUserInfo];
                [fb startDownloadingUserFriends];
            }
}

#pragma mark - loginButtonDidLogOut
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"facebook logout button test");
}


#pragma mark - didFinishDownloadingUserInfo
- (void) FBclass:(FbSingleton *)FBclass didFinishDownloadingUserInfo:(NSDictionary *)result
{
    NSLog(@"didFinishDownloadingUserInfo:%@",result);
    
    // if an error ocurred
    if([[result objectForKey:@"successful"] isEqualToString:@"No"]){
        [self popAlert:@"Error" msg:[result objectForKey:@"error"]];
    }
    else{
        [self.challengeDao getExistUser:[result objectForKey:@"id"]];
    }
    
}

#pragma mark - didFinishDownloadingUserFriends
- (void) FBclass:(FbSingleton *)FBclass didFinishDownloadingUserFriends:(NSDictionary *)result
{
    NSLog(@"didFinishDownloadingUserFriends:%@",result);
    
    // if an error ocurred
    if([[result objectForKey:@"successful"] isEqualToString:@"No"]){
        [self popAlert:@"Error" msg:[result objectForKey:@"error"]];
    }
}

#pragma mark - didFinishGetExistUserWithResult from Dao
- (void) didFinishGetExistUserWithResult:(NSArray *) resultArray
{
    NSLog(@"didFinishGetExistUserWithResult resultArray:%@",resultArray);
    
    // After API Response change to TabController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *tabBarController = (UITabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    //    if user already exist, send him to dashboard
    //    if([[resultArray valueForKey:@"successful"] isEqualToString:@"YES"])
    tabBarController.selectedIndex = 0;
    
    //[self performSegueWithIdentifier:@"segueToTabBar" sender:self.btnLogin];
    [self presentViewController:tabBarController animated:NO completion:nil];
    
}


#pragma mark - popAlert helper Method

- (void)popAlert:(NSString*)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    [alert show];
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

//example of how to share a link
- (IBAction)shareLink:(FBSDKShareButton *)sender {
    [fb shareLinkWithURL:@"https://www.youtube.com/watch?v=KxJLYM9XOT4" Title:@"tilte" Description:@"desc" ImageUrl:@"http://www.dummymag.com//media/img/dummy-logo.png"];
}
@end
