//
//  MakeDonationViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * customCharityOrganizationOptionString;
@interface MakeDonationViewController : UIViewController<UIPickerViewDataSource, UITextFieldDelegate, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerCharityOrganization;
@property(strong,nonatomic) IBOutlet  UITextField *inputAmount;
@property(strong,nonatomic) IBOutlet  UITextField *inputPaypalId;
@property(strong,nonatomic) IBOutlet  UIButton *btnAccept;
@property(strong,nonatomic) NSString *organizationName;
-(IBAction) btnAcceptClicked:(id)sender;
@end
