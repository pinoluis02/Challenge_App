//
//  NewChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

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

- (IBAction)addMediaButton:(UIButton *)sender;
- (IBAction)makeDonationSwith:(UISwitch *)sender;
- (IBAction)submitChallengeButton:(UIButton *)sender;



- (IBAction)ChooseFromGallery:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ChooseFromGallery;

@property (strong,nonatomic) IBOutlet UILabel *progressLabel;
@property(strong,nonatomic)IBOutlet  UIProgressView *progressIndicator;

@end


