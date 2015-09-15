//
//  UploadEvidenceViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "Dropbox.h"
#import "OAuthLoginViewController.h"
#import <UIKit/UIKit.h>

@interface UploadEvidenceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleChallengeLabel;
@property (strong, nonatomic) IBOutlet UITextField *addDescriptionText;
@property (strong, nonatomic) IBOutlet UITextField *addHashtadText;

@property (strong, nonatomic) IBOutlet UILabel *warningLabel;

@property (strong, nonatomic) IBOutlet UIButton *sendEvidenceButton;
@property (strong, nonatomic) IBOutlet UIButton *addMediaButton;
@property (strong, nonatomic) NSString *urlResource;
@property (strong, nonatomic) NSString *typeResource;

//@property (strong, nonatomic) NSString * descriptionText;
//@property (strong, nonatomic) NSString * aditionalHashtags;

- (IBAction)sendEvidenceButton:(UIButton *)sender;
- (IBAction)addMediaButton:(UIButton *)sender;

@end
