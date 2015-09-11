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
    NSLog(@"type : %@", type);
    resultDictionary = [resultDictionary objectForKey:@"challenges"];
    
    self.resultArrayModel = [[NSMutableArray alloc] init];
    
    if ([type isEqualToString:@"didFinishGetAllChallengesWithResult_"]) {
        resultType = 0;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetPopularChallengesWithResult_"]) {
        resultType = @1;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetLastChallengesWithResult_"]) {
        resultType = @2;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetChallengesByCriteriaWithResult_"]) {
        resultType = @3;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetChallengesRequestByUserIdWithResult_"]) {
        resultType = @10;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishPutChallengesRequestStatusWithResult_"]) {
        resultType = @20;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetChallengesEvidencesByUserIdWithResult_"]) {
        resultType = @30;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];    
    }else if ([type isEqualToString:@"didFinishGetChallengesPendingEvidencesByUserIdWithResult_"]) {
        resultType = @31;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishPostChallengeWithResult_"]) {
        resultType = @21;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];    
    }else if ([type isEqualToString:@"didFinishPostUserWithResult_"]) {
        resultType = @11;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }else if ([type isEqualToString:@"didFinishGetExistUserWithResult_"]) {
        resultType = @12;
        ParsingChallenge *parsingChallenge = [ParsingChallenge alloc];
        self.resultArrayModel = [parsingChallenge getParsingChallenge:resultDictionary];
    }

    
    if (!error) {
        //[self.delegate JSONParsing:self didFinishParsingWithResult:resultArray resultType:resultType error:nil];
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
