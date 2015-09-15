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
            [self.delegate didFinishAcceptOrRejectChallengeRequestWithResult:resultArray];
            break;
            
        case  didFinishGetChallengesEvidencesByUserIdWithResult_:
            [self.delegate didFinishGetChallengesEvidencesByUserIdWithResult:resultArray];
            break;
            
        case  didFinishGetChallengesPendingEvidencesByUserIdWithResult_:
            [self.delegate didFinishGetChallengesPendingEvidencesByUserIdWithResult:resultArray];
            break;
            
        case  didFinishPostChallengeWithResult_:
            [self.delegate didFinishAddChallengeWithResult:resultArray];
            break;
            
        case  didFinishPostUserWithResult_:
            [self.delegate didFinishAddUserWithResult:resultArray];
            break;
            
        case  didFinishGetExistUserWithResult_:
            [self.delegate didFinishGetExistUserWithResult:resultArray];
            break;
            
        case didFinishPostChallengeRequestWithResult_:
            [self.delegate didFinishPostChallengeRequestWithResult:resultArray];
            break;
            
        case didFinishPostChallengeEvidenceWithResult_:
            [self.delegate didFinishPostChallengeEvidenceWithResult:resultArray];
            break;
            
        case didFinishGetChallengesEvidencesByChallengeIdWithResult_:
            [self.delegate didFinishGetChallengesEvidencesByChallengeIdWithResult:resultArray];
            break;
            
        case didFinishPutChallengesEvidenceStatusWithResult_:
            [self.delegate didFinishPutChallengesEvidenceStatusWithResult:resultArray];
            break;
    }
}

-(NSString *)replaceCharactersDot:(NSString *) originalString {
    NSString *newString = [originalString stringByReplacingOccurrencesOfString:@"." withString:@"$2E"];
    return newString;
}

-(NSString *)replaceCharactersSlash:(NSString *) originalString {
    NSString *newString = [originalString stringByReplacingOccurrencesOfString:@"/" withString:@"$2S"];
    return newString;
}

-(void) getAllChallenges { // OK
    [self.connection downloadFileFromUrl:@getAllChallenges_url];
}

-(void) getLastChallenges { // OK
    NSLog(@"getLastChallenges_url: %@", @getLastChallenges_url);
    [self.connection downloadFileFromUrl:@getLastChallenges_url];
}

-(void) getPopularChallenges { // OK
    [self.connection downloadFileFromUrl:@getPopularChallenges_url];
}

-(void) postChallenge:(Challenge *)challenge { // REVISAR ESTE POST
    //http://ruby-mcschallenge.rhcloud.com/postChallenge/:title/:desc/:media/:id_pay/:org/:mount/:user_id.json
    
    //http://ruby-mcschallenge.rhcloud.com/postChallenge/:title/:desc/:user_id/:hashtags/:urlresource/:typeresource/:organization_id.json
    
    //    NSString *mount = [NSString stringWithFormat:@"%0.f", challenge.mount];
    //    NSLog(@"mount: %@", mount);
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@/%@/%@/%@/%@/%@.json", @postChallenge_url,
                             [[self replaceCharactersDot:challenge.title] urlEncode],
                             [[self replaceCharactersDot:challenge.descriptionItem] urlEncode],
                             [[self replaceCharactersDot:challenge.idAuthor] urlEncode],
                             [[self replaceCharactersDot:challenge.hashtags] urlEncode],
                             [[self replaceCharactersSlash:[self replaceCharactersDot:challenge.urlResource] ] urlEncode],
                             [[self replaceCharactersDot:challenge.type] urlEncode],
                             [[self replaceCharactersDot:challenge.organization] urlEncode]];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
    //    [self.connection downloadFileFromUrl:@postChallenge_url];
}

-(void) searchChallenges:(ChallengeCriteria *)criteria {
    //"http://ip_server/getChallengesByCriteria?criteria=?&value=?"
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@/%@.json",@getChallengesByCriteria_url,
                             [[self replaceCharactersDot:criteria.title] urlEncode],
                             [[self replaceCharactersDot:criteria.hashtag] urlEncode],
                             criteria.userId];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
    //    [self.connection downloadFileFromUrl:@getChallengesByCriteria_url];
    
}

-(void) getChallengesRequestByUserId:(NSNumber *)destination_id withStatus:(NSNumber *)status {// OK Dinamic
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@.json",@getChallengesRequestByUserId_url, destination_id, status];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
    //    [self.connection downloadFileFromUrl:@getChallengesRequestByUserId_url];
}

-(void) putChallengesRequestStatus:(NSNumber *) challengeRequest_id withStatus:(NSNumber *)status {
    //http://ruby-mcschallenge.rhcloud.com/putChallengesRequestStatus/:challengeRequest_id/:status_id.json
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@.json",@putChallengesRequestStatus_url, challengeRequest_id, status];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
    //    [self.connection downloadFileFromUrl:@putChallengesRequestStatus_url];
}

-(void) getChallengesEvidencesByUserId:(NSNumber *) user_id {
    NSString *url_request = [NSString stringWithFormat:@"%@%@.json",@getChallengesEvidencesByUserId_url, user_id];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request]; // OK Dinamic
    //    [self.connection downloadFileFromUrl:@getChallengesEvidencesByUserId_url];
}

-(void) getChallengesPendingEvidencesByUserId:(NSNumber *) user_id { // OK Dinamic
    NSString *url_request = [NSString stringWithFormat:@"%@%@.json", @getChallengesPendingEvidencesByUserId_url, user_id];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
    //    [self.connection downloadFileFromUrl:@getChallengesPendingEvidencesByUserId_url];
}

-(void) postUser:(User *) user { // OK Dinamic
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@/%@/%@.json", @postUser_url,
                             [[self replaceCharactersDot:user.facebookUser] urlEncode],
                             [[self replaceCharactersDot:user.username] urlEncode],
                             [[self replaceCharactersDot:user.password] urlEncode],
                             [[self replaceCharactersDot:user.email] urlEncode]
                             ];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
    //    [self.connection downloadFileFromUrl:@postUser_url];
}

-(void) getExistUser:(NSString *) user_id {
    NSString *url_request = [NSString stringWithFormat:@"%@%@.json", @getExistUser_url, user_id];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
    //    [self.connection downloadFileFromUrl:@getExistUser_url];
}

-(void) postChallengeRequest:(NSNumber *) challenge_id sourceId:(NSNumber *) source_id destinationId:(NSNumber *) destination_id {
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@/%@.json", @postChallengeRequest_url, challenge_id, source_id, destination_id];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
}

-(void) postChallengeEvidence:(NSNumber *) challenge_id userId:(NSNumber *) user_id mediaUrl:(NSString *) media_url mediaType:(NSString *) media_type {
    //"http://ruby-mcschallenge.rhcloud.com/postChallengeEvidence/:challenge_id/:user_id/:mediaurl/:mediaType.json"
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%@/%@/%@.json", @postChallengeEvidence_url,
                             challenge_id,
                             user_id,
                             [[self replaceCharactersSlash:[self replaceCharactersDot:media_url]] urlEncode],
                             media_type];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
}


-(void) getChallengesEvidencesByChallengeId:(NSNumber *) challenge_id {
    //http://ruby-mcschallenge.rhcloud.com/getChallengesEvidencesByChallengeId/:challenge_id.json
    NSString *url_request = [NSString stringWithFormat:@"%@%@.json", @getChallengesEvidencesByChallengeId_url, challenge_id];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
}


-(void) putChallengesEvidenceStatus:(NSNumber *)challengeEvidence_id hasEvidence:(BOOL) has_evidence {
    //"http://ruby-mcschallenge.rhcloud.com/putChallengesEvidenceStatus/:challengeEvidence_id/:hasevidence.json"
    NSString *url_request = [NSString stringWithFormat:@"%@%@/%d.json", @putChallengesEvidenceStatus_url, challengeEvidence_id, has_evidence];
    NSLog(@"url_request: %@", url_request);
    [self.connection downloadFileFromUrl:url_request];
    
}
@end
