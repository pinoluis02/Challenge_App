//
//  FBclass.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FbSingleton.h"

@implementation FbSingleton


+ (id)sharedInstance {
    static FbSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id) init 
{
    self = [super init];
    if (self) {
        _friendsFbUser  = [[NSArray  alloc]init];
        _idFbUser       = [[NSString alloc]init];
        _nameFbUser     = [[NSString alloc]init];
        _emailFbUser    = [[NSString alloc]init];
        _urlImageFbUser = [[NSString alloc]init];
    }
    return self;
}


- (void) startDownloadingUserFriends{
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/friends"
                                  parameters:@{@"fields": @"id, name, email, picture"}
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          NSDictionary *result,
                                          NSError *error) {
        
        NSMutableDictionary *friendRequest = [[NSMutableDictionary alloc]init];
        // Handle the result
        if (!error) {
            
        
            NSMutableArray *arrayOfFriends = [[NSMutableArray alloc]init];
           
            for(NSMutableDictionary *dic in [result objectForKey:@"data"]){
                NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
               // [temp setObject:[dic objectForKey:@"email"] forKey:@"email"];
                [temp setObject:[dic objectForKey:@"id"] forKey:@"id"];
                [temp setObject:[dic objectForKey:@"name"] forKey:@"name"];
                [temp setObject:[[[dic objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"] forKey:@"urlImage"];
                [arrayOfFriends addObject:temp];
            }
            
            [friendRequest setObject:arrayOfFriends forKey:@"data"];
            [friendRequest setObject:@"YES" forKey:@"successful"];
            
            _friendsFbUser = [friendRequest objectForKey:@"data"];
        }
        else{
            
            NSLog(@"error:%@",error);
            [friendRequest setObject:@"NO" forKey:@"successful"];
            [friendRequest setObject:error forKey:@"error"];
            
        }
        
        [self.delegate FBclass:self didFinishDownloadingUserFriends:friendRequest];
    }];
    
}



-(void) startDownloadingUserInfo{
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me"
                                  parameters:@{@"fields": @"id, name, email, picture"}
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if (!error) {
            
            [userInfo setValue:@"YES" forKey:@"successful"];
            
            if ([result objectForKey:@"name"]) {
                _nameFbUser = [result objectForKey:@"name"];
                [userInfo setValue:[result objectForKey:@"name"] forKey:@"name"];
            }
            if ([result objectForKey:@"id"]) {
                _idFbUser = [result objectForKey:@"id"];
                [userInfo setValue:[result objectForKey:@"id"] forKey:@"id"];
            }
            if ([result objectForKey:@"email"]) {
                _emailFbUser = [result objectForKey:@"email"];
                [userInfo setValue:[result objectForKey:@"email"] forKey:@"email"];
            }
            if ([result objectForKey:@"picture"]) {
                _urlImageFbUser = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                [userInfo setValue:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"] forKey:@"urlImage"];
            }
        }
        else{
            NSLog(@"error:%@",error);
            [userInfo setValue:@"NO" forKey:@"successful"];
            [userInfo setValue:error forKey:@"error"];
        }
        
        [self.delegate FBclass:self didFinishDownloadingUserInfo:userInfo];
    }];
    
}


- (void) shareLinkWithURL:(NSString*)url Title:(NSString*)title Description:(NSString*)description ImageUrl:(NSString*)imageUrl{
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL = [NSURL URLWithString:@"https://www.youtube.com/watch?v=KxJLYM9XOT4"];
//    content.contentTitle = @"<INSERT Title HERE>";
//    content.contentDescription = @"<INSERT Description HERE>";
//    content.imageURL =  [NSURL URLWithString:@"http://www.dummymag.com//media/img/dummy-logo.png"];

    content.contentURL = [NSURL URLWithString:url];
    content.contentTitle = title;
    content.contentDescription = description;
    content.imageURL =  [NSURL URLWithString:imageUrl];
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
}

@end
