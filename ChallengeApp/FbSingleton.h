//
//  FBclass.h
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "FBFriend.h"


@class FbSingleton;

@protocol FBclassDelegate <NSObject>

-(void) FBclass: (FbSingleton *)FBclass didFinishDownloadingUserInfo: (NSDictionary*)result;
-(void) FBclass: (FbSingleton *)FBclass didFinishDownloadingUserFriends: (NSDictionary*)result;

@end


@interface FbSingleton : NSObject

@property (nonatomic, weak) id<FBclassDelegate> delegate;

@property FBFriend *userLoggedIn;
@property NSArray  *friendsFbUser;
//@property NSString *idFbUser;
//@property NSString *nameFbUser;
//@property NSString *emailFbUser;
//@property NSString *urlImageFbUser;

-(void) startDownloadingUserInfo;
-(void) startDownloadingUserFriends;
-(void) shareLinkWithURL:(NSString*)url Title:(NSString*)title Description:(NSString*)description ImageUrl:(NSString*)imageUrl;

+ (FbSingleton*)sharedInstance;


@end
