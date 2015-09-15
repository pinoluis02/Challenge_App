//
//  FriendList.h
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFriend : NSObject

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, strong) NSString * email;

@end
