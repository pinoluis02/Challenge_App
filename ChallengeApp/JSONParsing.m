//
//  JSONParsing.m
//  Networking
//
//  Copyright (c) 2014 Mobile Consulting Solutions. All rights reserved.
//

#import "JSONParsing.h"

@interface JSONParsing ()

@property (nonatomic, strong) NSData *jsonData;

@end

@implementation JSONParsing

- (instancetype)initWithData: (NSData *) jsonData
{
    self = [super init];
    if (self) {
        _jsonData = jsonData;
    }
    return self;
}

- (void) startParsing {
    NSError *error;
    NSNumber* resultType;
    NSObject *obj;
    
    // Check if the object is of a specific subclass.
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
    }
    
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingAllowFragments error:&error];
    
    NSString *type = [resultDictionary objectForKey:@"resultType"];
    NSString *result = [resultDictionary objectForKey:@"result"];
    
//    NSLog(@"type : %@", type);
//    NSLog(@"resultDictionary: %@", resultDictionary);
    
    NSDictionary *challengeRequestsDictionary = [resultDictionary objectForKey:@"challengerequests"];
    NSDictionary *evidencesDictionary = [resultDictionary objectForKey:@"evidences"];
    resultDictionary = [resultDictionary objectForKey:@"challenges"];
    
    self.resultArrayModel = [[NSMutableArray alloc] init];
    if ([type isEqualToString:@"getAllChallenges"]) {
        resultType = 0;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"getPopularChallenges"]) {
        resultType = @1;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"getLastChallenges"]) {
        resultType = @2;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"searchChallenges"]) {
        resultType = @3;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"getChallengesRequestByUserId"]) {
        resultType = @10;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallengeRequests:challengeRequestsDictionary];
    }else if ([type isEqualToString:@"putChallengesRequestStatus"]) {
        resultType = @20;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"getChallengesEvidencesByUserId"]) {
        resultType = @30;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallengeEvidence:evidencesDictionary];
        for (Challenge *challege in self.resultArrayModel) {
            NSLog(@"challege.title %@", challege.title);
            NSLog(@"descriptionItem %@", challege.descriptionItem);
        }
        NSLog(@"self.resultArrayModel:%@",self.resultArrayModel);
    }else if ([type isEqualToString:@"getChallengesPendingEvidencesByUserId"]) {
        resultType = @31;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallengeEvidence:evidencesDictionary];

    }else if ([type isEqualToString:@"postChallenge"]) {
        resultType = @21;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"postUser"]) { //DELETE OR CHANGE
        //    }else if ([type isEqualToString:@"didFinishPostUserWithResult_"]) {
        resultType = @11;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        //self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"existUser"]) {
        resultType = @12;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"postChallengeRequest"]) {
        resultType = @32;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"postChallengeEvidence"]) {
        resultType = @33;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }else if ([type isEqualToString:@"getChallengesEvidencesByChallengeId"]) {
        resultType = @34;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingEvidence:evidencesDictionary];
    }else if ([type isEqualToString:@"putChallengesEvidenceStatus"]) {
        resultType = @35;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingMessage:result];
    }
    
    if (!error) {
        [self.delegate JSONParsing:self didFinishParsingWithResult:self.resultArrayModel resultType:resultType error:nil];
    }
}

- (void) customParsing:(NSData *)nsdata {
    NSError *error;
    NSNumber* resultType;
    
    NSObject *obj;
    
    // Check if the object is of a specific subclass.
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
    }
    
    
    NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:nsdata options:NSJSONReadingAllowFragments error:&error];
    
    if (!error) {
        [self.delegate JSONParsing:self didFinishParsingWithResult:resultArray resultType:resultType error:nil];
    }
}

@end
