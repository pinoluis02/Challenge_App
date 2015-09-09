//
//  ChallengeDao.h
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
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

#define getAllChallenges_url "http://dev.fuzzproductions.com/MobileTest/test.json"
#define getLastChallenges_url ""
#define getPopularChallenges_url ""
#define getChallengesFromUser_url  ""
#define addChallenge_url ""
#define searchChallenges_url ""
#define getChallengesRequests_url ""
#define getChallengesResponses_url ""
#define acceptChallengeRequest_url ""
#define rejectChallengeRequest_url ""


#import <Foundation/Foundation.h>
#import "Challenge.h"
#import "ChallengeCriteria.h"
#import "Connection.h"
#import "JSONParsing.h"

@protocol ChallengeDelegate <NSObject>

-(void)  didFinishGetAllChallengesWithResult:(NSArray *) resultArray;
-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray;
-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray;
-(void)  didFinishGetChallengesFromUserWithResult:(NSArray *) resultArray;

-(void)  didFinishAddChallengeWithResult:(NSError *) error;
-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray;

// This method returns a list of challenges requests for a given challenge
-(void)  didFinishGetChallengeRequestsWithResult:(NSArray *) resultArray;

// This method returns a list of evidences or reponses for a given challenge
-(void)  didFinishGetChallengesResponsesWithResult:(NSArray *) resultArray;

-(void)  didFinishAcceptChallengeRequestWithResult:(NSError *) error;

-(void)  didFinishRejectChallengeRequestWithResult:(NSError *) error;

@end


@interface ChallengeDao : NSObject <ConnectionDelegate, JSONParsingDelegate>

@property (nonatomic, weak) id<ChallengeDelegate> delegate;
@property Connection *connection;
@property JSONParsing *jsonParsing;


-(void) getAllChallenges;
-(void) getLastChallenges;
-(void) getPopularChallenges;
-(void) getChallengesFromUser:(NSNumber *) user_id;

-(void)addChallenge:(Challenge *)challenge;
-(void) searchChallenges:(ChallengeCriteria *)criteria;

// This method returns a list of challenges requests for a given challenge
-(void) getChallengesRequests:(NSNumber *) challenge_id;

// This method returns a list of evidences or reponses for a given challenge
-(void) getChallengesResponses:(NSNumber *) challenge_id;

-(void) acceptChallengeRequest:(NSNumber *) challengeRequest_id;
-(void) rejectChallengeRequest:(NSNumber *) challengeRequest_id;



@end
