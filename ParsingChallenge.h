//
//  ParsingChallenge.h
//  ChallengeApp
//
//  Created by Nivardo Ibarra on 08/09/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Challenge.h"
#import "Message.h"
#import "Evidence.h"

@interface ParsingChallenge : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionItem;
@property (strong, nonatomic) NSString *imageUrl;

-(NSMutableArray *)getParsingChallenge:(NSDictionary *) dictonaryJson;
-(NSMutableArray *)getParsingMessage:(NSString *) result;
-(NSMutableArray *)getParsingEvidence:(NSDictionary *) dictonaryJson;
-(NSMutableArray *)getParsingChallengeEvidence:(NSDictionary *) dictonaryJson;
-(NSMutableArray *)getParsingChallengeRequests:(NSDictionary *) dictonaryJson;
@end
