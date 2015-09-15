//
//  ChallengeDao.h
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

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

#define didFinishPostChallengeRequestWithResult_ 32
#define didFinishPostChallengeEvidenceWithResult_ 33
#define didFinishGetChallengesEvidencesByChallengeIdWithResult_ 34
#define didFinishPutChallengesEvidenceStatusWithResult_ 35


// REQ0004 The user can see a specific challenge from all
#define getAllChallenges_url  "http://ruby-mcschallenge.rhcloud.com/getAllChallenges.json"
//"http://192.168.1.3/mcs/team/challengue/getAllChallenges.json"

//REQ0005 The user can see a popular challenge
#define getPopularChallenges_url "http://ruby-mcschallenge.rhcloud.com/getPopularChallenges.json"
//"http://192.168.1.3/mcs/team/challengue/getPopularChallenges.json"

//REQ0006 The user can see a lates challenge
#define getLastChallenges_url "http://ruby-mcschallenge.rhcloud.com/getLastChallenges.json"
//"http://192.168.1.3/mcs/team/challengue/getLastChallenges.json"

//REQ0007 The user can search challenges that have specific criteria search
#define getChallengesByCriteria_url "http://ruby-mcschallenge.rhcloud.com/searchChallenges/"
//"http://192.168.1.3/mcs/team/challengue/getChallengesByCriteria.json"
// REQ0008 The user can see his challenges requests (Challenge Not decided still)
#define getChallengesRequestByUserId_url "http://ruby-mcschallenge.rhcloud.com/getChallengesRequestByUserId/"
//"http://192.168.1.3/mcs/team/challengue/getChallengesRequestByUserId.json"

//REQ0009 The user can accept a challenge request
//REQ0010 The user can reject a challenge request
#define putChallengesRequestStatus_url "http://ruby-mcschallenge.rhcloud.com/putChallengesRequestStatus/"
//"http://192.168.1.3/mcs/team/challengue/putChallengesRequestStatus.json"

//REQ0011 The user can see his challenges responses (Accepted with evidence)
#define getChallengesEvidencesByUserId_url  "http://ruby-mcschallenge.rhcloud.com/getChallengesEvidencesByUserId/"
//"http://ip_server/getChallengesEvidencesByUserId?user_id=?"

//REQ0012 The user can see his pending challenges  (Accepted without evidence) incompleted
#define getChallengesPendingEvidencesByUserId_url "http://ruby-mcschallenge.rhcloud.com/getChallengesPendingEvidencesByUserId/"
//"http://192.168.1.3/mcs/team/challengue/getChallengesPendingEvidencesByUserId.json"

//REQ0003 The user can create a new challenge
#define postChallenge_url  "http://ruby-mcschallenge.rhcloud.com/postChallenge/"
//"http://192.168.1.3/mcs/team/challengue/postChallenge.json"

//REQ0100 The user can register
#define postUser_url  "http://ruby-mcschallenge.rhcloud.com/postUser/"
//"http://192.168.1.3/mcs/team/challengue/postUser.json"
//"http://ip_server/postChallenge?title=?&date=?&media=?&desc=?&donation=?&id_pay=?&org=?&mount=?&user_id=?"

//REQ0101 The user is registered in Database
#define getExistUser_url  "http://ruby-mcschallenge.rhcloud.com/existUser/"
//"http://192.168.1.3/mcs/team/challengue/getExistUser.json"
//"http://ip_server/postChallenge?title=?&date=?&media=?&desc=?&donation=?&id_pay=?&org=?&mount=?&user_id=?"

//#REQ0013 Post Chellenge request
#define postChallengeRequest_url  "http://ruby-mcschallenge.rhcloud.com/postChallengeRequest/"
//http://ruby-mcschallenge.rhcloud.com/postChallengeRequest/:challenge_id/:source_id/:destination_id.json

//#REQ0014  Post Chellenge evidence
#define postChallengeEvidence_url "http://ruby-mcschallenge.rhcloud.com/postChallengeEvidence/"
//"http://ruby-mcschallenge.rhcloud.com/postChallengeEvidence/:challenge_id/:user_id/:mediaurl/:mediaType.json"
#define getChallengesEvidencesByChallengeId_url "http://ruby-mcschallenge.rhcloud.com/getChallengesEvidencesByChallengeId/"
//http://ruby-mcschallenge.rhcloud.com/getChallengesEvidencesByChallengeId/:challenge_id.json

#define putChallengesEvidenceStatus_url "http://ruby-mcschallenge.rhcloud.com/putChallengesEvidenceStatus/"
//"http://ruby-mcschallenge.rhcloud.com/putChallengesEvidenceStatus/:challengeEvidence_id/:hasevidence.json"


#import <Foundation/Foundation.h>
#import "Challenge.h"
#import "User.h"
#import "ChallengeCriteria.h"
#import "Connection.h"
#import "JSONParsing.h"
#import "NSString+URLEncode.h"

@protocol ChallengeDelegate <NSObject>
@optional
-(void)  didFinishGetAllChallengesWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishAddChallengeWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetChallengesRequestByUserIdWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishAcceptOrRejectChallengeRequestWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetChallengesEvidencesByUserIdWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetChallengesPendingEvidencesByUserIdWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishAddUserWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishGetExistUserWithResult:(NSArray *) resultArray; //OK
-(void)  didFinishPostChallengeRequestWithResult:(NSArray *)resultArray;
-(void)  didFinishPostChallengeEvidenceWithResult:(NSArray *)resultArray;
-(void)  didFinishGetChallengesEvidencesByChallengeIdWithResult:(NSArray *)resultArray;
-(void)  didFinishPutChallengesEvidenceStatusWithResult:(NSArray *)resultArray;
@end


@interface ChallengeDao : NSObject <ConnectionDelegate, JSONParsingDelegate>

@property (nonatomic, weak) id<ChallengeDelegate> delegate;
@property Connection *connection;
@property JSONParsing *jsonParsing;

-(void) getAllChallenges;
-(void) getLastChallenges;
-(void) getPopularChallenges;
-(void) postChallenge:(Challenge *)challenge;
-(void) searchChallenges:(ChallengeCriteria *)criteria;
-(void) getChallengesRequestByUserId:(NSNumber *) destination_id withStatus:(NSNumber *)status;
-(void) putChallengesRequestStatus:(NSNumber *) challengeRequest_id withStatus:(NSNumber *)status;
-(void) getChallengesEvidencesByUserId:(NSNumber *) user_id;
-(void) getChallengesPendingEvidencesByUserId:(NSNumber *) user_id;
-(void) postUser:(User *) user;
-(void) getExistUser:(NSString *) user_id;
-(void) postChallengeRequest:(NSNumber *) challenge_id sourceId:(NSNumber *) source_id destinationId:(NSNumber *) destination_id;
-(void) postChallengeEvidence:(NSNumber *) challenge_id userId:(NSNumber *) user_id mediaUrl:(NSString *) media_url mediaType:(NSString *) media_type;
-(void) getChallengesEvidencesByChallengeId:(NSNumber *) challenge_id;
-(void) putChallengesEvidenceStatus:(NSNumber *)challengeEvidence_id hasEvidence:(BOOL) has_evidence;
@end
