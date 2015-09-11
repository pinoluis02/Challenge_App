//
//  ParsingChallenge.m
//  ChallengeApp
//
//  Created by Nivardo Ibarra on 08/09/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

#import "ParsingChallenge.h"

@implementation ParsingChallenge

-(NSMutableArray *)getParsingChallenge:(NSDictionary *) dictonaryJson {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for (NSDictionary *snippet in dictonaryJson) {
        Challenge *challenge = [Challenge alloc];
        challenge.title = [snippet objectForKey:@"title"];
        challenge.descriptionItem = [snippet objectForKey:@"description"];
        challenge.urlResource = [snippet objectForKey:@"url"];
        [resultArray addObject:challenge];
    }
    return resultArray;
}
@end
