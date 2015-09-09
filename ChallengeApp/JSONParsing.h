//
//  JSONParsing.h
//  Networking
//
//  Copyright (c) 2014 Mobile Consulting Solutions. All rights reserved.
//

#define didFinishGetAllChallengesWithResult_ 0
#define didFinishGetLastChallengesWithResult_ 1
#define didFinishGetPopularChallengesWithResult_ 2
#define didFinishGetChallengesFromUserWithResult_ 3
#define didFinishAddChallengeWithResult_ 4
#define didFinishSearchChallengesWithResult_ 5
#define didFinishGetChallengeRequestsWithResult_ 6
#define didFinishGetChallengesResponsesWithResult_ 7
#define didFinishAcceptChallengeRequestWithResult_ 8
#define didFinishRejectChallengeRequestWithResult_ 9

#import <Foundation/Foundation.h>
@class JSONParsing;

@protocol JSONParsingDelegate <NSObject>

-(void) JSONParsing: (JSONParsing *)jsonParsing didFinishParsingWithResult: (NSArray *) resultArray resultType: (NSNumber *)resultType_ error:(NSError *)error_;

@end


@interface JSONParsing : NSObject

@property (nonatomic, weak) id<JSONParsingDelegate> delegate;

- (instancetype)initWithData: (NSData *) jsonData;
- (void) startParsing;
- (void) customParsing:(NSData *)nsdata;

@end
