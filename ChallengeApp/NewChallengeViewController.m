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

#import "NetworkManager.h"

#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NewChallengeViewController ()
{
    MPMoviePlayerController *_player;
//    IBOutlet  UIImageView *image;
}

@property (strong, nonatomic) MPMoviePlayerController *player;
// things for IB

@property (nonatomic, strong, readwrite) IBOutlet UITextField * urlText;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString * userNameText;
@property (nonatomic, strong) NSString * passwordText;


@property (nonatomic, strong, readwrite) NSOutputStream *  networkStream;
@property (nonatomic, strong, readwrite) NSInputStream *   fileStream;

@property (weak, nonatomic) IBOutlet UIView *movieView; // this should point to a view where the movie will play


@end

@implementation NewChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL URLWithString:@"http://ebookfrenzy.com/ios_book/movie/movie.mov"];
    
//    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/watch?v=lp-EO5I60KA"];

    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    _player.view.frame = CGRectMake(30, 464, 150, 150);
    [self.view addSubview:_player.view];
    
    _player.shouldAutoplay = YES;
    [_player prepareToPlay];
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

- (IBAction)makeDonationSwith:(UISwitch *)sender
{
    if ([sender isOn])
    {
        [self performSegueWithIdentifier:@"ShowDontationSegue" sender:self];
    }
    else
    {
        NSLog(@"Donataion is Off");
    }
}

- (IBAction)submitChallengeButton:(UIButton *)sender
{
    NSLog(@"Submit button action pressed");
}

- (IBAction)ChooseFromGallery:(id)sender
{
    NSLog(@"Open the Choose From Gallery");
    
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage, nil];
        
        [self presentModalViewController:picker animated:YES];
    }
    
    NSLog(@"Choose From Gallery Ended");
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    NSLog(@"This is the image PickerController");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"progressIndicatorView");
    [self progressIndicatorView];
    self.ChooseFromGallery.hidden =YES;
    
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
    
    NSString *urlString=[urlvideo path];
    NSLog(@"urlString for file ->%@", urlString);
    
    NSString *urlpath = [NSString stringWithFormat:@"ftp://mcs:Welcome2MCS@192.168.1.10/Public/TestFolder/"];
    
//    NSString *urlpath = [NSString stringWithFormat:@"ftp://MCSCHALLENGE:Welcome2MCS@ftp.drivehq.com/My%20Documents/"];
    
    NSLog(@"urlpath server ->%@", urlpath);
    
    NSURL *url = [NSURL URLWithString:[urlpath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"url file server ->%@", url);
    
    NSLog(@"URL Video -> %@", urlvideo);
    
    [self startSend:urlString];
}

- (void)startSend:(NSString *)filePath
{
    NSLog(@"filePath for file -> %@", filePath);
    
    BOOL                    success;
    NSURL *                 url;
    
    assert(filePath != nil);
    assert([[NSFileManager defaultManager] fileExistsAtPath:filePath]);
    assert( [filePath.pathExtension isEqual:@"MOV"] || [filePath.pathExtension isEqual:@"jpg"] || [filePath.pathExtension isEqual:@"png"] );
    
    assert(self.networkStream == nil);      // don't tap send twice in a row!
    assert(self.fileStream == nil);         // ditto
    
    // First get and check the URL.
    
    NSString * urlText = [NSString stringWithFormat:@"ftp://192.168.1.10/Public/TestFolder/"];
    
//    NSString * urlText = [NSString stringWithFormat:@"ftp://mcs:Welcome2MCS@192.168.1.10/Public/TestFolder/"];
    
//    NSString * urlText = @"ftp://ftp.drivehq.com/My%20Documents/";
    
    NSLog(@"urlText -> %@", urlText);
    
    url = [[NetworkManager sharedInstance] smartURLForString:urlText];
    
    NSLog(@"url -> %@", url);
    success = (url != nil);
    
    if (success)
    {
        NSLog(@"Success");
        // Add the last part of the file name to the end of the URL to form the final
        // URL that we're going to put to.
        
        url = CFBridgingRelease(
                                CFURLCreateCopyAppendingPathComponent(NULL, (__bridge CFURLRef) url, (__bridge CFStringRef) [filePath lastPathComponent], false)
                                );
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
}

-(void)progressIndicatorView
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
    
    self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 70, 15)];
    [self.progressLabel setBackgroundColor:[UIColor whiteColor]];
    _progressIndicator = [[UIProgressView alloc] init];
    _progressIndicator.frame = CGRectMake(30,65,140,20);
    [aProgressView addSubview:progressTitleLabel];
    [aProgressView addSubview:self.progressLabel];
    [aProgressView addSubview:_progressIndicator];
    [self.view addSubview:aProgressView];
}

@end
