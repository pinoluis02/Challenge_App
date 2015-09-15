//
//  UploadEvidenceViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UploadEvidenceViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Dropbox.h"
#import "ChallengeDao.h"

@interface UploadEvidenceViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionTaskDelegate, ChallengeDelegate>

@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIView *uploadView;
@property (nonatomic, strong) NSArray *photoThumbnails;
@property (nonatomic, strong) NSURLSession *session;
@property ChallengeDao * challengeDao;

@end

@implementation UploadEvidenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //This variale will get the Title of these challenge from the DB
    NSString * titleChallenge = @"Title for the challenge";
    
    self.titleChallengeLabel.text =titleChallenge;

    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    
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
//    self.urlResource;
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
        [self.challengeDao postChallengeEvidence:@1 userId:@1 mediaUrl:self.urlResource mediaType:self.typeResource];
        // Funtion to send the variables for Details and Hashtags to the next method
    }
}
# pragma mark - OAUTH 1.0a STEP 1
-(void)getOAuthRequestToken
{
    // OAUTH Step 1. Get request token.
    [Dropbox requestTokenWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                
                NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                /*
                 oauth_token The request token that was just authorized. The request token secret isn't sent back.
                 If the user chooses not to authorize the application,
                 they will get redirected to the oauth_callback URL with the additional URL query parameter not_approved=true.
                 */
                NSDictionary *oauthDict = [Dropbox dictionaryFromOAuthResponseString:responseStr];
                // save the REQUEST token and secret to use for normal api calls
                [[NSUserDefaults standardUserDefaults] setObject:oauthDict[oauthTokenKey] forKey:requestToken];
                [[NSUserDefaults standardUserDefaults] setObject:oauthDict[oauthTokenKeySecret] forKey:requestTokenSecret];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                NSString *authorizationURLWithParams = [NSString stringWithFormat:@"https://www.dropbox.com/1/oauth/authorize?oauth_token=%@&oauth_callback=byteclub://userauthorization",oauthDict[oauthTokenKey]];
                
                //                NSString *authorizationURLWithParams = [NSString stringWithFormat:@"https://www.dropbox.com/1/oauth2/authorize?oauth_token=pOhdpi2sdRUAAAAAAABP0aMCdKzztrbRxKhIqTCH3PwXhYmKHQwvf-C2gEcwBUJi&oauth_callback=byteclub://userauthorization"];
                
                // escape codes
                NSString *escapedURL = [authorizationURLWithParams stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
//                [_tokenAlert dismissWithClickedButtonIndex:0 animated:NO];
                
                // opens to user auth page in safari
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escapedURL]];
                
            } else {
                // HANDLE BAD RESPONSE //
                NSLog(@"unexpected response getting token %@",[NSHTTPURLResponse localizedStringForStatusCode:httpResp.statusCode]);
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
    }];
}
-(void) didFinishPostChallengeEvidenceWithResult:(NSArray *)resultArray {
    NSLog(@"didFinishPostChallengeEvidenceWithResult: %lu", [resultArray count]);
}
/*- (void)exchangeRequestTokenForAccessToken
{
    // OAUTH Step 3 - exchange request token for user access token
    [Dropbox exchangeTokenForUserAccessTokenURLWithCompletionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *accessTokenDict = [Dropbox dictionaryFromOAuthResponseString:response];
                
                [[NSUserDefaults standardUserDefaults] setObject:accessTokenDict[oauthTokenKey] forKey:accessToken];
                [[NSUserDefaults standardUserDefaults] setObject:accessTokenDict[oauthTokenKeySecret] forKey:accessTokenSecret];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // now load main part of application
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *segueId = @"TabBar";
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UITabBarController *initViewController = [storyboard instantiateViewControllerWithIdentifier:segueId];
                    
//                    UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
                                        UINavigationController *nav = (UINavigationController *) self;
                    nav.navigationBar.hidden = YES;
                    [nav pushViewController:initViewController animated:NO];
                });
                
            } else {
                // HANDLE BAD RESPONSE //
                NSLog(@"exchange request for access token unexpected response %@",
                      [NSHTTPURLResponse localizedStringForStatusCode:httpResp.statusCode]);
            }
        } else {
            // ALWAYS HANDLE ERRORS :-] //
        }
    }];
}*/

- (IBAction)addMediaButton:(UIButton *)sender
{
//    [self getOAuthRequestToken];
//    [self exchangeRequestTokenForAccessToken];
    NSLog(@"Open the Photo gallery to search for the Video/Photo from your phone");
    // Override point for customization after application launch.
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:accessToken];
    NSString *controllerId;
    if (token) {
        controllerId = @"TabBar";
        if([UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker= [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
            [self presentViewController:picker animated:YES completion:nil];
        }

    }else {
        controllerId = @"Login";
    }

    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 1
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
        // 2
        [config setHTTPAdditionalHeaders:@{@"Authorization": [Dropbox apiAuthorizationHeader]}];
        
        // 3
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UIImagePickerControllerDelegate methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString:@"public.image"]) {
        self.typeResource = @"image";
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        [self dismissViewControllerAnimated:YES completion:nil];
        [self uploadMedia:imageData typeMedia:@"image"];
    }else if([[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString:@"public.movie"]) {
        self.typeResource = @"video";
        NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *strUrl = [NSString stringWithFormat:@"%@",urlvideo];
        strUrl = [strUrl substringFromIndex:7];
        NSData *fileData = [NSData dataWithContentsOfFile:strUrl];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self uploadMedia:fileData typeMedia:@"video"];
    }
    
}

- (void)uploadMedia:(NSData *) fileData typeMedia:(NSString *) type
{
    // 1
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPMaximumConnectionsPerHost = 1;
    [config setHTTPAdditionalHeaders:@{@"Authorization": [Dropbox apiAuthorizationHeader]}];
    
    // 2
    NSURLSession *upLoadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    // for now just create a random file name, dropbox will handle it if we overwrite a file and create a new name..
    NSURL *url = nil;
    if ([type isEqualToString:@"image"]) {
        url = [Dropbox createPhotoUploadURL];
    } else if ([type isEqualToString:@"video"]) {
        url = [Dropbox createVideoUploadURL];
//        NSLog(@"url: %@", url);
    }
    self.urlResource = [NSString stringWithFormat:@"%@", url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"PUT"];
    
    // 3
    self.uploadTask = [upLoadSession uploadTaskWithRequest:request fromData:fileData];
    
    // 4
    self.uploadView.hidden = NO;
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // 5
    [_uploadTask resume];
}

#pragma mark - NSURLSessionTaskDelegate methods
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progress setProgress:
         (double)totalBytesSent /
         (double)totalBytesExpectedToSend animated:YES];
    });
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    // 1
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        _uploadView.hidden = YES;
        [_progress setProgress:0.5];
    });
    
    if (!error) {
        // 2
        // Alert confirmation succesful
//        [self dismissViewControllerAnimated:YES completion:nil];

    } else {
        
        
        // Alert confirmation unsuccesful
    }
}

@end
