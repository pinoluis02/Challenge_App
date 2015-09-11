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
            
        case  didFinishGetPopularChallengesWithResult_:
            NSLog(@"HERE: didFinishetPopularChallengesWithResult_");
            [self.delegate didFinishGetPopularChallengesWithResult:resultArray];
            break;
          
        case  didFinishGetLastChallengesWithResult_:
            [self.delegate didFinishGetLastChallengesWithResult:resultArray];
            break;
            
        case  didFinishGetChallengesByCriteriaWithResult_:
            [self.delegate didFinishSearchChallengesWithResult:resultArray];
            break;
            
        case  didFinishGetChallengesRequestByUserIdWithResult_:
            [self.delegate didFinishGetChallengesRequestByUserIdWithResult:resultArray];
            break;
            
        case  didFinishPutChallengesRequestStatusWithResult_:
            [self.delegate didFinishAcceptOrRejectChallengeRequestWithResult:error_];
            break;
            
        case  didFinishGetChallengesEvidencesByUserIdWithResult_:            
            [self.delegate didFinishGetChallengesEvidencesByUserIdWithResult:resultArray];
            break;

        case  didFinishGetChallengesPendingEvidencesByUserIdWithResult_:
            [self.delegate didFinishGetChallengesPendingEvidencesByUserIdWithResult:resultArray];
            break;
            
        case  didFinishPostChallengeWithResult_:
            [self.delegate didFinishAddChallengeWithResult:error_];
            break;

        case  didFinishPostUserWithResult_:
            [self.delegate didFinishAddUserWithResult:error_];
            break;

        case  didFinishGetExistUserWithResult_:
            [self.delegate didFinishGetExistUserWithResult:resultArray];
            break;
            
        /*
            
        case  didFinishGetChallengesFromUserWithResult_:
            
            [self.delegate didFinishGetChallengesFromUserWithResult:resultArray];
            
            break;
            
        case  didFinishAddChallengeWithResult_:
            
            [self.delegate didFinishAddChallengeWithResult:error_];
            break;
            
         
        case  didFinishGetChallengeRequestsWithResult_:
            [self.delegate didFinishGetChallengeRequestsWithResult:resultArray ];
            
            break;
         
        case  didFinishAcceptChallengeRequestWithResult_:
            
            [self.delegate didFinishAcceptChallengeRequestWithResult: error_];
            break;
            
        case  didFinishRejectChallengeRequestWithResult_:
            
            [self.delegate didFinishRejectChallengeRequestWithResult: error_];
            break;*/
            
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
//    [self.connection downloadFileFromUrl:[NSString stringWithFormat:@"%@%@", @getChallengesFromUser_url, user_id]];
}

-(void) postChallenge:(Challenge *)challenge {
    NSString *url_request = [NSString stringWithFormat:@"%@title=%@&date=%@&media=%@&desc=%@&donation=%@&id_pay=%@&org=%@&mount=%f&user_id=%@",@getChallengesRequestByUserId_url, challenge.title, challenge.creationDate, challenge.type, challenge.descriptionItem, challenge.donation, challenge.idPayPal, challenge.organization, challenge.mount, challenge.idAuthor];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:@postChallenge_url];
//    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
}

-(void) searchChallenges:(ChallengeCriteria *)criteria {
    [self.connection downloadFileFromUrl:@getChallengesByCriteria_url];
    
}

// This method returns a list of challenges requests for a given challenge
-(void) getChallengesRequests:(NSNumber *) challenge_id {
//    [self.connection downloadFileFromUrl:@getChallengesRequests_url];
}

// This method returns a list of evidences or reponses for a given challenge
-(void) getChallengesResponses:(NSNumber *) challenge_id {
//    [self.connection downloadFileFromUrl:@getChallengesResponses_url];
}

-(void) acceptChallengeRequest:(NSNumber *) challengeRequest_id {
//    [self.connection downloadFileFromUrl:@acceptChallengeRequest_url];
}

-(void) rejectChallengeRequest:(NSNumber *) challengeRequest_id {
//    [self.connection downloadFileFromUrl:@rejectChallengeRequest_url];
    
}

-(void) getChallengesRequestByUserId:(NSNumber *)destination_id withStatus:(NSNumber *)status {
    NSString *url_request = [NSString stringWithFormat:@"%@destination_id=%@&status=%@",@getChallengesRequestByUserId_url, destination_id, status];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:@getChallengesRequestByUserId_url];
//    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
}

-(void) putChallengesRequestStatus:(NSNumber *) challengeRequest_id withStatus:(NSNumber *)status {
    NSString *url_request = [NSString stringWithFormat:@"%@status_id=%@&challengeRequest_id=%@",@putChallengesRequestStatus_url, challengeRequest_id, status];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:@putChallengesRequestStatus_url];
//    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
}

-(void) getChallengesEvidencesByUserId:(NSNumber *) user_id {
    [self.connection downloadFileFromUrl:@getChallengesEvidencesByUserId_url];
}

-(void) getChallengesPendingEvidencesByUserId:(NSNumber *) user_id {
    [self.connection downloadFileFromUrl:@getChallengesPendingEvidencesByUserId_url];
}

-(void) postUser:(User *) user {
    [self.connection downloadFileFromUrl:@postUser_url];
}

-(void) getExistUser:(NSString *) user_id {
    [self.connection downloadFileFromUrl:@getExistUser_url];
}
@end
