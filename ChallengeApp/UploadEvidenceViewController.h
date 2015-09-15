//
//  UploadEvidenceViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeDao.h"

@interface UploadEvidenceViewController : UIViewController <ChallengeDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleChallengeLabel;
@property (strong, nonatomic) IBOutlet UITextField *addDescriptionText;
@property (strong, nonatomic) IBOutlet UITextField *addHashtadText;
@property (strong, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendEvidenceButton;
@property (strong, nonatomic) IBOutlet UIButton *addMediaButton;
@property ChallengeDao * challengeDao;
@property NSString * createNewChallengeView_donationAmount;
@property NSString * createNewChallengeView_donationPaypalId;
@property NSString * createNewChallengeView_title;
@property NSString * createNewChallengeView_description;
@property NSString * createNewChallengeView_resourceType;
@property NSString * createNewChallengeView_resourceUrl;
@property NSString * createNewChallengeView_thumbnailUrl;
@property NSString * createNewChallengeView_donationOrganization;

@property BOOL userComesFromCreateNewChallengeView;

@property Challenge * selectedItem;
//@property (strong, nonatomic) NSString * descriptionText;
//@property (strong, nonatomic) NSString * aditionalHashtags;

- (IBAction)sendEvidenceButton:(UIButton *)sender;
- (IBAction)addMediaButton:(UIButton *)sender;

@end
