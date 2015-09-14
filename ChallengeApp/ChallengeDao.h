//
//  ChallengeDao.h
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

/*#define didFinishGetAllChallengesWithResult_ 0
#define didFinishGetLastChallengesWithResult_ 1
#define didFinishGetPopularChallengesWithResult_ 2
#define didFinishGetChallengesFromUserWithResult_ 3
#define didFinishAddChallengeWithResult_ 4
#define didFinishSearchChallengesWithResult_ 5
#define didFinishGetChallengeRequestsWithResult_ 6
#define didFinishGetChallengesResponsesWithResult_ 7
#define didFinishAcceptChallengeRequestWithResult_ 8
#define didFinishRejectChallengeRequestWithResult_ 9 */

/*#define getAllChallenges_url "http://dev.fuzzproductions.com/MobileTest/test.json" //No working for me
#define getLastChallenges_url ""
#define getPopularChallenges_url ""
#define getChallengesFromUser_url  ""
#define addChallenge_url ""
#define searchChallenges_url ""
#define getChallengesRequests_url ""
#define getChallengesResponses_url ""
#define acceptChallengeRequest_url ""
#define rejectChallengeRequest_url ""*/

// CONSTANTS
#define didFinishGetAllChallengesWithResult_ 0
#define didFinishGetPopularChallengesWithResult_ 1
#define didFinishGetLastChallengesWithResult_ 2
#define didFinishGetChallengesByCriteriaWithResult_ 3

#define didFinishGetChallengesRequestByUserIdWithResult_ 10
#define didFinishPostUserWithResult_ 11
#define didFinishGetExistUserWithResult_ 12

#define didFinishPutChallengesRequestStatusWithResult_ 20
#define didFinishPostChallengeWithResult_ 21

#define didFinishGetChallengesEvidencesByUserIdWithResult_ 30
#define didFinishGetChallengesPendingEvidencesByUserIdWithResult_ 31



// REQUEST
// REQ0004 The user can see a specific challenge from all
#define getAllChallenges_url  "http://192.168.1.3/mcs/team/challengue/getAllChallenges.json"
                              //"http://ip_server/getAllChallenges"
//REQ0005 The user can see a popular challenge
#define getPopularChallenges_url "http://192.168.1.3/mcs/team/challengue/getPopularChallenges.json"
                            //"http://ip_server/getPopularChallenges"
//REQ0006 The user can see a lates challenge
#define getLastChallenges_url "http://192.168.1.3/mcs/team/challengue/getLastChallenges.json"
                            //"http://ip_server/getLastChallenges"
//REQ0007 The user can search challenges that have specific criteria search
#define getChallengesByCriteria_url "http://192.168.1.3/mcs/team/challengue/getChallengesByCriteria.json"
                            //"http://ip_server/getChallengesByCriteria?criteria=?&value=?"
// REQ0008 The user can see his challenges requests (Challenge Not decided still)
#define getChallengesRequestByUserId_url  "http://192.168.1.3/mcs/team/challengue/getChallengesRequestByUserId.json"
                            //"http://ip_server/getChallengesRequestByUserId?"
                            //"http://ip_server/getChallengesRequestByUserId?destination_id=%@&status=%@"
//REQ0009 The user can accept a challenge request
//REQ0010 The user can reject a challenge request
#define putChallengesRequestStatus_url "http://192.168.1.3/mcs/team/challengue/putChallengesRequestStatus.json"
                            //"http://ip_server/putChallengesRequestStatus?"
                            //"http://ip_server/putChallengesRequestStatus?status_id=?&challengeRequest_id=?"
//REQ0011 The user can see his challenges responses (Accepted with evidence)
#define getChallengesEvidencesByUserId_url  "http://192.168.1.3/mcs/team/challengue/getChallengesEvidencesByUserId.json"
                            //"http://ip_server/getChallengesEvidencesByUserId?user_id=?"
//REQ0012 The user can see his pending challenges  (Accepted without evidence) incompleted
#define getChallengesPendingEvidencesByUserId_url "http://192.168.1.3/mcs/team/challengue/getChallengesPendingEvidencesByUserId.json"
                            //"http://ip_server/getChallengesPendingEvidencesByUserId?user_id=?"
//REQ0003 The user can create a new challenge
#define postChallenge_url  "http://192.168.1.3/mcs/team/challengue/postChallenge.json"
                            //"http://ip_server/postChallenge?"
                            //"http://ip_server/postChallenge?title=?&date=?&media=?&desc=?&donation=?&id_pay=?&org=?&mount=?&user_id=?"
//REQ0100 The user can register
#define postUser_url  "http://192.168.1.3/mcs/team/challengue/postUser.json"
//"http://ip_server/postChallenge?title=?&date=?&media=?&desc=?&donation=?&id_pay=?&org=?&mount=?&user_id=?"

//REQ0101 The user is registered in Database
#define getExistUser_url  "http://192.168.1.3/mcs/team/challengue/getExistUser.json"
//"http://ip_server/postChallenge?title=?&date=?&media=?&desc=?&donation=?&id_pay=?&org=?&mount=?&user_id=?"


#import <Foundation/Foundation.h>
#import "Challenge.h"
#import "User.h"
#import "ChallengeCriteria.h"
#import "Connection.h"
#import "JSONParsing.h"

@protocol ChallengeDelegate <NSObject>

@optional
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

-(void)  didFinishGetChallengesRequestByUserIdWithResult:(NSArray *) resultArray;

-(void)  didFinishAcceptOrRejectChallengeRequestWithResult:(NSError *) error;

-(void)  didFinishGetChallengesEvidencesByUserIdWithResult:(NSArray *) resultArray;

-(void)  didFinishGetChallengesPendingEvidencesByUserIdWithResult:(NSArray *) resultArray;

-(void)  didFinishAddUserWithResult:(NSError *) error;

-(void)  didFinishGetExistUserWithResult:(NSArray *) resultArray;
@end



@interface ChallengeDao : NSObject <ConnectionDelegate, JSONParsingDelegate>

@property (nonatomic, weak) id<ChallengeDelegate> delegate;
@property Connection *connection;
@property JSONParsing *jsonParsing;


-(void) getAllChallenges;
-(void) getLastChallenges;
-(void) getPopularChallenges;
-(void) getChallengesFromUser:(NSNumber *) user_id;

-(void) postChallenge:(Challenge *)challenge;
-(void) searchChallenges:(ChallengeCriteria *)criteria;

// This method returns a list of challenges requests for a given challenge
-(void) getChallengesRequests:(NSNumber *) challenge_id;

// This method returns a list of evidences or reponses for a given challenge
-(void) getChallengesResponses:(NSNumber *) challenge_id;

-(void) acceptChallengeRequest:(NSNumber *) challengeRequest_id;
-(void) rejectChallengeRequest:(NSNumber *) challengeRequest_id;


-(void) getChallengesRequestByUserId:(NSNumber *) destination_id withStatus:(NSNumber *)status;
-(void) putChallengesRequestStatus:(NSNumber *) challengeRequest_id withStatus:(NSNumber *)status;
-(void) getChallengesEvidencesByUserId:(NSNumber *) user_id;
-(void) getChallengesPendingEvidencesByUserId:(NSNumber *) user_id;

-(void) postUser:(User *) user;
-(void) getExistUser:(NSString *) user_id;
@end
