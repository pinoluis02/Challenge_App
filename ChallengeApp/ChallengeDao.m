//
//  ChallengeDao.m
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

#import "ChallengeDao.h"
#import "Connection.h"

@implementation ChallengeDao


- (id) init {
    
    self = [super init];
    if (self != nil) {
        
        self.connection = [[Connection alloc] init];
        self.connection.delegate = self;
        
    }
    return self;
    
}

- (void) connection: (Connection *) connection didFinishWithResultData: (NSData *) resultData {
  
   // JSON Parsing
   self.jsonParsing = [[JSONParsing alloc] initWithData:resultData];
   self.jsonParsing.delegate = self;
   [self.jsonParsing startParsing];
    
 
}

-(void) JSONParsing: (JSONParsing *)jsonParsing didFinishParsingWithResult: (NSArray *) resultArray
         resultType: (NSNumber *)resultType_  error:(NSError *)error_{
    
    NSLog(@" jsonParsing ----------- ");
    
    switch(resultType_.intValue) {
            
        case  didFinishGetAllChallengesWithResult_:
            
            [self.delegate didFinishGetAllChallengesWithResult:resultArray];
            
            break;
            
        case  didFinishGetLastChallengesWithResult_:
            
            [self.delegate didFinishGetLastChallengesWithResult:resultArray];
            break;
            
        case  didFinishGetPopularChallengesWithResult_:
            
            [self.delegate didFinishGetPopularChallengesWithResult:resultArray];
            
            break;
            
        case  didFinishGetChallengesFromUserWithResult_:
            
            [self.delegate didFinishGetChallengesFromUserWithResult:resultArray];
            
            break;
            
        case  didFinishAddChallengeWithResult_:
            
            [self.delegate didFinishAddChallengeWithResult:error_];
            break;
            
        case  didFinishSearchChallengesWithResult_:
            
            [self.delegate didFinishSearchChallengesWithResult:resultArray];
            
            break;
            
        case  didFinishGetChallengeRequestsWithResult_:
            [self.delegate didFinishGetChallengeRequestsWithResult:resultArray ];
            
            break;
            
        case  didFinishGetChallengesResponsesWithResult_:
            
            [self.delegate didFinishGetChallengesResponsesWithResult :resultArray];
            break;
            
        case  didFinishAcceptChallengeRequestWithResult_:
            
            [self.delegate didFinishAcceptChallengeRequestWithResult: error_];
            break;
            
        case  didFinishRejectChallengeRequestWithResult_:
            
            [self.delegate didFinishRejectChallengeRequestWithResult: error_];
            break;
            
    }
    
    
}


-(void) getAllChallenges {
   [self.connection downloadFileFromUrl:@getAllChallenges_url];
    
}

-(void) getLastChallenges {
    [self.connection downloadFileFromUrl:@getLastChallenges_url];
    
}

-(void) getPopularChallenges {
    [self.connection downloadFileFromUrl:@getPopularChallenges_url];
}

-(void) getChallengesFromUser:(NSNumber *) user_id {
    [self.connection downloadFileFromUrl:[NSString stringWithFormat:@"%@%@", @getChallengesFromUser_url, user_id]];
}

-(void)addChallenge:(Challenge *)challenge {
    [self.connection downloadFileFromUrl:@addChallenge_url];
    
}

-(void) searchChallenges:(ChallengeCriteria *)criteria {
    [self.connection downloadFileFromUrl:@searchChallenges_url];
    
}

// This method returns a list of challenges requests for a given challenge
-(void) getChallengesRequests:(NSNumber *) challenge_id {
    [self.connection downloadFileFromUrl:@getChallengesRequests_url];
}

// This method returns a list of evidences or reponses for a given challenge
-(void) getChallengesResponses:(NSNumber *) challenge_id {
    [self.connection downloadFileFromUrl:@getChallengesResponses_url];
}

-(void) acceptChallengeRequest:(NSNumber *) challengeRequest_id {
    [self.connection downloadFileFromUrl:@acceptChallengeRequest_url];
}

-(void) rejectChallengeRequest:(NSNumber *) challengeRequest_id {
    [self.connection downloadFileFromUrl:@rejectChallengeRequest_url];
    
}

@end
