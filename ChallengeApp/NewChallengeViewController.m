//
//  NewChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NewChallengeViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface NewChallengeViewController ()

@end

@implementation NewChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)makeDonationSwith:(UISwitch *)sender
{
    if ([sender isOn])
    {
        NSLog(@"Make Donatation is On");
        [self performSegueWithIdentifier:@"ShowDontationSegue" sender:self];
    }
    else
    {
        NSLog(@"Make Donation if Off");
    }
}


- (IBAction)addMediaButton:(UIButton *)sender
{
    NSLog(@"Add media Button");
    [self video];
}

- (IBAction)createChallengeButton:(UIButton *)sender
{
    NSLog(@"Creation of the New Challenge");
}


-(void)video
{
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    [self presentModalViewController:imagePicker animated:YES];
}


-(void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo)
    {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        // NSLog(@"%@",moviePath);
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
    [self dismissModalViewControllerAnimated:YES];
    
    NSLog(@"This is an line for commnents in github");
}


@end
