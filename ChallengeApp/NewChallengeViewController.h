//
//  NewChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * descriptionPlaceholderText;
@interface NewChallengeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *videoPicker;
    UIImagePickerController *imagePicker;
    UIImage *image;
    NSString *testing;
    NSURL *vidPath;
    IBOutlet UIImageView *imageView;
    
    UIView * aProgressView ;
}

@property (strong, nonatomic) NSString * titleChallege;
@property (strong, nonatomic) NSString * DescriptionChallenge;
@property (strong, nonatomic) NSString * urlVideoDropbox;

@property (strong, nonatomic) IBOutlet UIButton *ChooseFromGallery;
@property(strong,nonatomic)IBOutlet  UIProgressView *progressIndicator;
@property(strong,nonatomic)IBOutlet  UILabel *donationSummary;
@property(strong,nonatomic)IBOutlet  UITextView *challengeDescription;
@property(strong,nonatomic)IBOutlet  UITextField *challengeTitle;
@property(strong,nonatomic)IBOutlet  UISwitch *switchView;
- (IBAction)addMediaButton:(UIButton *)sender;
- (IBAction)makeDonationSwitch:(UISwitch *)sender;
- (IBAction)submitChallengeButton:(UIButton *)sender;
- (IBAction)ChooseFromGallery:(id)sender;


@end


