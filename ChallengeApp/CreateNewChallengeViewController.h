//
//  CreateNewChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/6/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbSingleton.h"

extern NSString * customCharityOrganizationOptionString;
@interface CreateNewChallengeViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTitle;
@property (weak, nonatomic) IBOutlet UITextView *inputDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnDonate;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCharityOrganization;
@property (weak, nonatomic) IBOutlet UITextField *inputPaypalID;
@property (weak, nonatomic) IBOutlet UITextField *inputAmount;
@property (weak, nonatomic) IBOutlet UIImageView *inputMediaPreview;
@property (strong, nonatomic) NSString *idLoginUser;
- (IBAction)donateButtonClick:(id)sender;

@end
