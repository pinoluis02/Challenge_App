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
@property (strong, nonatomic) NSString *challengeId;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *videoUrl;
@property (strong, nonatomic) NSString *date;
@end
