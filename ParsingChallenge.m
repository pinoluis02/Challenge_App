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
        challenge.urlThumbnail = [snippet objectForKey:@"url_thumbnail"];
        challenge.urlResource = [snippet objectForKey:@"urlresource"];
        NSLog(@"challenge.urlThumbnail: %@", challenge.urlThumbnail);
        [resultArray addObject:challenge];
    }
    return resultArray;
}

-(NSMutableArray *)getParsingMessage:(NSString *) result {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    Message *message = [Message alloc];
    message.exist = result;
    message.successful = result;
    [resultArray addObject:message];
    return resultArray;
}

-(NSMutableArray *)getParsingEvidence:(NSDictionary *) dictonaryJson {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for (NSDictionary *snippet in dictonaryJson) {
        Evidence *evidence = [Evidence alloc];
        evidence.evidenceId = [snippet objectForKey:@"id"];
        evidence.userId = [snippet objectForKey:@"user_id"];
        evidence.imageUrl = [snippet objectForKey:@"imageUrl"];
        evidence.videoUrl = [snippet objectForKey:@"videoUrl"];
        evidence.mediaType = [snippet objectForKey:@"mediaType"];
        evidence.created_at = [snippet objectForKey:@"created_at"];
        evidence.updated_at = [snippet objectForKey:@"updated_at"];
        evidence.challengeId = [snippet objectForKey:@"challenge_id"];
        evidence.hasevidence = [snippet objectForKey:@"hasevidence"];
        [resultArray addObject:evidence];
    }
    NSLog(@"resultArray: %lu", [resultArray count]);
    return resultArray;
}

-(NSMutableArray *)getParsingChallengeEvidence:(NSDictionary *) dictonaryJson {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSLog(@"dictonaryJson: %@", dictonaryJson);
    for (NSDictionary *snippet in dictonaryJson) {
        Challenge *challenge = [Challenge alloc];
        challenge.title = [[snippet objectForKey:@"challenge"] objectForKey:@"title"];
        challenge.descriptionItem = [[snippet objectForKey:@"challenge"] objectForKey:@"description"];
        challenge.urlThumbnail = [[snippet objectForKey:@"challenge"] objectForKey:@"url_thumbnail"];
        challenge.urlResource = [[snippet objectForKey:@"challenge"] objectForKey:@"urlresource"];
        NSLog(@"challenge.urlThumbnail: %@", challenge.urlThumbnail);
        [resultArray addObject:challenge];
    }
    return resultArray;
}

-(NSMutableArray *)getParsingChallengeRequests:(NSDictionary *) dictonaryJson {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSLog(@"dictonaryJson: %@", dictonaryJson);
    for (NSDictionary *snippet in dictonaryJson) {
        Challenge *challenge = [Challenge alloc];
        challenge.title = [[snippet objectForKey:@"challenge"] objectForKey:@"title"];
        challenge.descriptionItem = [[snippet objectForKey:@"challenge"] objectForKey:@"description"];
        challenge.urlThumbnail = [[snippet objectForKey:@"challenge"] objectForKey:@"url_thumbnail"];
        challenge.urlResource = [[snippet objectForKey:@"challenge"] objectForKey:@"urlresource"];
        NSLog(@"challenge.urlThumbnail: %@", challenge.urlThumbnail);
        [resultArray addObject:challenge];
    }
    return resultArray;
}


@end
