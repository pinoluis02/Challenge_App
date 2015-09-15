//
//  NewChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NewChallengeViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>

#import <CoreMedia/CoreMedia.h>
#import "MakeDonationViewController.h"

#import "NetworkManager.h"

#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "UploadEvidenceViewController.h"


#import "UploadEvidenceViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Dropbox.h"

enum {
    kSendBufferSize = 32768
};

NSString * descriptionPlaceholderText = @"[Insert description here ..]";
@interface NewChallengeViewController () <NSStreamDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionTaskDelegate, ChallengeDelegate>
{
    MPMoviePlayerController *_player;
//    IBOutlet  UIImageView *image;
    NSString * createNewChallengeView_donationAmount;
    NSString * createNewChallengeView_donationPaypalId;
    NSString * createNewChallengeView_donationOrganization;
    NSString * createNewChallengeView_resourceType;
    NSString * createNewChallengeView_resourceUrl;
    NSString * createNewChallengeView_thumbnailUrl;
    
    BOOL donationViewVisible;
    NSString * mediaUrl;
    NSString * mediaType;

}

@property (strong, nonatomic) MPMoviePlayerController *player;
@property ChallengeDao * challengeDao;
// things for IB

@property (strong, nonatomic) NSString * titleChallenge;
@property (strong, nonatomic) NSString * descriptionChallenge;
//@property (strong, nonatomic) NSString * urlVideoDropbox;

@property (nonatomic, strong, readwrite) IBOutlet UITextField * urlText;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString * userNameText;
@property (nonatomic, strong) NSString * passwordText;


// Properties that don't need to be seen by the outside world.

@property (nonatomic, assign, readonly ) BOOL              isSending;

@property (nonatomic, strong, readwrite) NSOutputStream *  networkStream;
@property (nonatomic, strong, readwrite) NSInputStream *   fileStream;

@property (nonatomic, assign, readonly ) uint8_t *         buffer;

@property (weak, nonatomic) IBOutlet UIView *movieView; // this should point to a view where the movie will play
@property (nonatomic, strong) NSURLSessionUploadTask *uploadTask;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIView *uploadView;
@property (nonatomic, strong) NSArray *photoThumbnails;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NewChallengeViewController
{
    uint8_t _buffer[kSendBufferSize];
}

- (void)viewWillAppear:(BOOL)animated {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        [super viewWillAppear:animated];
    
//    unwind happens before this event, if the donationViewVisible is set, the user used navigationController to go back.
    if(donationViewVisible){
        self.switchView.on = NO;
        donationViewVisible = false;
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self mediaPlayerCode];
    [self setTextViewBorder];
    self.donationSummary.hidden = YES;
    self.challengeDescription.text = descriptionPlaceholderText;
 
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    
}

-(void)mediaPlayerCode{
    //    NSURL *url = [NSURL URLWithString:@"http://ebookfrenzy.com/ios_book/movie/movie.mov"];
    //    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=lp-EO5I60KA"];
    
    //    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    //    _player.view.frame = CGRectMake(30, 464, 150, 150);
    //    [self.view addSubview:_player.view];
    //    _player.shouldAutoplay = NO;
    //    [_player prepareToPlay];
    
    
   
   
//    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=lp-EO5I60KA"];

}


- (void)setTextViewBorder
{
    UITextView * textField = self.challengeDescription;
    textField.layer.borderWidth = 1.0f;
    UIColor * borderColor = [[UIColor alloc] initWithWhite:.1 alpha:.125];
    textField.layer.borderColor = [borderColor CGColor];
    textField.layer.cornerRadius = 5;
    textField.clipsToBounds = YES;
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

- (IBAction)addMediaButton:(UIButton *)sender
{
    NSLog(@"This is the button to add Media to the File Server");
}

- (IBAction)makeDonationSwitch:(UISwitch *)sender
{
    if ([sender isOn])
    {
        [self performSegueWithIdentifier:@"ShowDonationSegue" sender:self];
    }
    else{
//        was on
        self.donationSummary.text = @"";
        createNewChallengeView_donationPaypalId = @"";
        createNewChallengeView_donationAmount = @"";
    }
}

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue
                  sender:(id)sender {
     if([segue.identifier isEqualToString:@"gotoUploadEvidence"]){
         UploadEvidenceViewController * uploadEvidence = segue.destinationViewController;
         uploadEvidence.createNewChallengeView_donationAmount = createNewChallengeView_donationAmount;
         uploadEvidence.createNewChallengeView_donationPaypalId = createNewChallengeView_donationPaypalId;
         uploadEvidence.createNewChallengeView_title = self.challengeTitle.text;
         uploadEvidence.createNewChallengeView_description = self.challengeDescription.text;
         uploadEvidence.createNewChallengeView_resourceType = createNewChallengeView_resourceType;
         uploadEvidence.createNewChallengeView_resourceUrl = createNewChallengeView_resourceUrl;
         uploadEvidence.createNewChallengeView_thumbnailUrl = createNewChallengeView_thumbnailUrl;
         uploadEvidence.createNewChallengeView_donationOrganization = createNewChallengeView_donationOrganization;
         uploadEvidence.userComesFromCreateNewChallengeView = YES;
     }
     else{
         donationViewVisible = true;
     }
 }


-(IBAction)unwind:(UIStoryboardSegue *)seg{
    NSLog(@"unwind");
    MakeDonationViewController * donationController =  seg.sourceViewController;
    createNewChallengeView_donationAmount = donationController.inputAmount.text;
    createNewChallengeView_donationPaypalId = donationController.inputPaypalId.text;
    createNewChallengeView_donationOrganization = donationController.organizationName;
    self.donationSummary.hidden = NO;
    self.donationSummary.text = [[NSString alloc]initWithFormat: @"Donating: $%ld to %@", (long)[createNewChallengeView_donationAmount integerValue], createNewChallengeView_donationPaypalId];
    donationViewVisible = false;
    
}

- (IBAction)submitChallengeButton:(UIButton *)sender
{
    NSString * description = @"";
    if(![self.challengeDescription.text isEqualToString:descriptionPlaceholderText]){
       description = self.challengeDescription.text;
    }
    if(!self.challengeTitle.text){
        return;
    }
    
    NSString * segueIdentifier = @"gotoUploadEvidence";
    [self performSegueWithIdentifier:segueIdentifier sender:self];
    Challenge * challenge = [Challenge new];

    challenge.title = self.challengeTitle.text;
    challenge.descriptionItem = self.challengeDescription.text;
    challenge.urlResource = mediaUrl;
    [self.challengeDao postChallenge:challenge];
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

/*-(void) didFinishPostChallengeEvidenceWithResult:(NSArray *)resultArray {
    NSLog(@"didFinishPostChallengeEvidenceWithResult: %lu", [resultArray count]);
}*/

- (IBAction)ChooseFromGallery:(id)sender
{
/*    NSLog(@"Open the Choose From Gallery");
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        
        [self presentViewController:picker animated:YES completion:nil];
    }*/
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
    NSLog(@"Choose From Gallery Ended");
}

/*- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSLog(@"This is the image PickerController");
    
    NSLog(@"Info ->%@", info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"progressIndicatorView");
//    [self progressIndicatorView];
    self.ChooseFromGallery.hidden = YES;
    
    NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSLog(@"urlvideo is ->%@",urlvideo);
    
    NSError *error = nil;
    NSDictionary * properties = [[NSFileManager defaultManager] attributesOfItemAtPath:urlvideo.path error:&error];
    NSNumber * size = [properties objectForKey: NSFileSize];
    NSLog(@"size: %@", size);
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:urlvideo];
    CMTime duration = playerItem.duration;
    float seconds = CMTimeGetSeconds(duration);
    NSLog(@"duration: %.2f", seconds);
    
    NSLog(@"urlVideo Path ->%@", [urlvideo path]);
    
    NSString *urlString=[urlvideo path];
    NSLog(@"urlString for file ->%@", urlString);
    
    NSString *urlpath = [NSString stringWithFormat:@"ftp://mcs:Welcome2MCS@192.168.1.10/Public/TestFolder/"];
    
//    NSString *urlpath = [NSString stringWithFormat:@"ftp://MCSCHALLENGE:Welcome2MCS@ftp.drivehq.com/My%20Documents/"];
    
    NSLog(@"urlpath server ->%@", urlpath);
    
    NSURL *url = [NSURL URLWithString:[urlpath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"url file server ->%@", url);
    
    NSLog(@"URL Video -> %@", urlvideo);
    
    [self startSend:urlString];
//    [self startSend:urlvideo];
}*/

#pragma mark - UIImagePickerControllerDelegate methods
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString:@"public.image"]) {
        mediaType = @"image";
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
        [self dismissViewControllerAnimated:YES completion:nil];
        [self uploadMedia:imageData typeMedia:@"image"];
    }else if([[info objectForKey:@"UIImagePickerControllerMediaType"] isEqualToString:@"public.movie"]) {
        mediaType = @"video";
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
    mediaUrl = [NSString stringWithFormat:@"%@", url];
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

/*- (void)startSend:(NSString *)filePath
{
    NSLog(@"filePath for file ->%@", filePath);
    
    BOOL                    success;
    NSURL *                 url;
    
    NSLog(@"____filePath ->%@", filePath);
    
    assert(filePath != nil);
    assert([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
    assert( [filePath.pathExtension isEqual:@"MOV"]
         || [filePath.pathExtension isEqual:@"JPG"]
         || [filePath.pathExtension isEqual:@"PNG"]
        );
    
    assert(self.networkStream == nil);      // don't tap send twice in a row!
    assert(self.fileStream == nil);         // ditto
    
    // First get and check the URL.
    
    NSString * urlText = [NSString stringWithFormat:@"ftp://192.168.1.10/Public/TestFolder/"];
    
//    NSString * urlText = [NSString stringWithFormat:@"ftp://mcs:Welcome2MCS@192.168.1.10/Public/TestFolder/"];
    
//    NSString * urlText = @"ftp://ftp.drivehq.com/My%20Documents/";
    
    NSLog(@"urlText ->%@", urlText);
    
    url = [[NetworkManager sharedInstance] smartURLForString:urlText];
    NSLog(@"url ->%@", url);
    success = (url != nil);
    
    if (success)
    {
        NSLog(@"Success");
        // Add the last part of the file name to the end of the URL to form the final
        // URL that we're going to put to.
        
        NSLog(@"filePath lastPathComponent ->%@", [filePath lastPathComponent]);
        
        url = CFBridgingRelease( CFURLCreateCopyAppendingPathComponent(NULL, (__bridge CFURLRef) url, (__bridge CFStringRef) [filePath lastPathComponent], false) );
        
        NSLog(@"url CFBridgingRelease ->%@", url);
        NSLog(@"filePatch ->%@", filePath);
        
        success = (url != nil);
    }
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success)
    {
        NSLog(@"Invalid URL");
    }
    else
    {
        NSLog(@"Valir URL, kick off the connection");
    }
    
    // Open a stream for the file we're going to send.  We do not open this stream;
    // NSURLConnection will do it for us.
    
    
    [self.fileStream open];
    
    // Open a CFFTPStream for the URL.
    NSLog(@"Open CFFTP url ->%@", url);
    self.networkStream = CFBridgingRelease( CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url));
    
    assert(self.networkStream != nil);
    
    self.userNameText = [NSString stringWithFormat:@"mcs"];
    self.passwordText = [NSString stringWithFormat:@"Welcome2MCS"];
    
    //Online service
//    self.userNameText = [NSString stringWithFormat:@"MCSCHALLENGE"];
//    self.passwordText = [NSString stringWithFormat:@"Welcome2MCS"];
    
    if ([self.userNameText length] != 0)
    {
        success = [self.networkStream setProperty:self.userNameText forKey:(id)kCFStreamPropertyFTPUserName];
        assert(success);
        success = [self.networkStream setProperty:self.passwordText forKey:(id)kCFStreamPropertyFTPPassword];
        assert(success);
    }
    
    self.networkStream.delegate = self;
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];
    
    // Tell the UI we're sending.
    
    NSLog(@"[self sendDidStart];");
    [self sendDidStart];
}

- (void)sendDidStart
{
    NSLog(@"Sending");
//    self.cancelButton.enabled = YES;
    [self.activityIndicator startAnimating];
    [[NetworkManager sharedInstance] didStartNetworkOperation];
    
    NSLog(@"sendDidStar ended");
    
    [self viewDidLoad];
}*/

/*-(void)progressIndicatorView
{
    //self.Record_button.hidden =YES;
    CGRect UploadProgressFrame = CGRectMake(60, 150, 200,100);
    aProgressView = [[UIView alloc] initWithFrame:UploadProgressFrame];
    [aProgressView setBackgroundColor:[UIColor whiteColor]];
    [aProgressView.layer setCornerRadius:10.0f];
    [aProgressView.layer setBorderWidth:1.0f];
    [aProgressView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    UILabel *progressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 150, 30)];
    progressTitleLabel.backgroundColor = [UIColor whiteColor];
    [progressTitleLabel setFont:[UIFont fontWithName:@"Arial" size:15]];
    progressTitleLabel.text = @"Uploading Video";
    progressTitleLabel.textColor = [UIColor blackColor];
    
    _progressIndicator = [[UIProgressView alloc] init];
    _progressIndicator.frame = CGRectMake(30,65,140,20);
    [aProgressView addSubview:progressTitleLabel];
    [aProgressView addSubview:_progressIndicator];
    [self.view addSubview:aProgressView];
}*/

- (uint8_t *)buffer
{
    return self->_buffer;
}

- (BOOL)isSending
{
    return (self.networkStream != nil);
}

-(void) didFinishPostChallengeRequestWithResult:(NSArray *)resultArray {
    NSLog(@"didFinishPostChallengeRequestWithResult");
}
@end
