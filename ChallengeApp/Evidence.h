//
//  Evidence.h
//  ChallengeApp
//
//  Created by Nivardo Ibarra on 10/09/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Evidence : NSObject

@property (strong, nonatomic) NSString *evidenceId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *videoUrl;
@property (strong, nonatomic) NSString *mediaType;
@property (strong, nonatomic) NSString *created_at;
@property (strong, nonatomic) NSString *updated_at;
@property (strong, nonatomic) NSString *challengeId;
@property BOOL                          hasevidence;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *descriptionEvidence;
@property (strong, nonatomic) NSString *userfacebookId;

@end
