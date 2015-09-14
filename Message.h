//
//  Message.h
//  ChallengeApp
//
//  Created by Nivardo Ibarra on 13/09/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong, nonatomic) NSString *exist;
@property (strong, nonatomic) NSString *successful;

@property (strong, nonatomic) NSString *error;
@property (strong, nonatomic) NSString *descriptionMessage;

@end
