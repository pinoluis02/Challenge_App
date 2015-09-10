//
//  NewChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewChallengeViewController : UIViewController

{
    UIImagePickerController *videoPicker;
    UIImagePickerController *imagePicker;
    UIImage *image;
    NSString *testing;
    NSURL *vidPath;
    IBOutlet UIImageView *imageView;
}

-(IBAction)takePhoto;

-(IBAction)chooseExisting;

- (IBAction)addMediaButton:(UIButton *)sender;
- (IBAction)makeDonationSwith:(UISwitch *)sender;
- (IBAction)submitChallengeButton:(UIButton *)sender;


@end


