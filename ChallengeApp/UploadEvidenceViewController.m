//
//  UploadEvidenceViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UploadEvidenceViewController.h"

@interface UploadEvidenceViewController ()

@end

@implementation UploadEvidenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //This variale will get the Title of these challenge from the DB
    NSString * titleChallenge = @"Title for the challenge";
    
    self.titleChallengeLabel.text =titleChallenge;

    
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

- (IBAction)sendEvidenceButton:(UIButton *)sender
{
    NSLog(@"Send the evidence media video/photo to the file server");
    if ( ([self.addDescriptionText.text isEqualToString:@""]) || ([self.addHashtadText.text isEqualToString:@""]))
    {
        self.warningLabel.text = @"There are some fields missing";
    }
    else
    {
        NSLog(@"add Description -> %@", self.addDescriptionText.text);
        NSLog(@"add Hashtad     -> %@", self.addDescriptionText.text);
        
        NSString * descriptionText = self.addDescriptionText.text;
        NSString * aditionalHashtags =  self.addDescriptionText.text;
        
        NSLog(@"%@", descriptionText);
        NSLog(@"%@", aditionalHashtags);
        
        self.warningLabel.text = @"";
        
        // Funtion to send the variables for Details and Hashtags to the next method
    }
}

- (IBAction)addMediaButton:(UIButton *)sender
{
    NSLog(@"Open the Photo gallery to search for the Video/Photo from your phone");
    
    
}

@end
