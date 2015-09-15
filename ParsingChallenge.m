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
    NSDictionary *resultDictionary = [dictonaryJson objectForKey:@"challenges"];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for (NSDictionary *snippet in resultDictionary) {
        Challenge * challenge = [Challenge new];
        challenge.idChallenge = [[snippet objectForKey:@"challenge"] objectForKey:@"id"];
        challenge.title = [[snippet objectForKey:@"challenge"] objectForKey:@"title"];
        challenge.descriptionItem = [[snippet objectForKey:@"challenge"] objectForKey:@"description"];
        challenge.type = [[snippet objectForKey:@"challenge"] objectForKey:@"typeresource"];
        challenge.urlResource = [[snippet objectForKey:@"challenge"] objectForKey:@"urlresource"];
        challenge.urlThumbnail = [[snippet objectForKey:@"challenge"] objectForKey:@"url_thumbnail"];
        if([challenge.urlThumbnail isKindOfClass:[NSNull class]]) {
            challenge.urlThumbnail = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        if([challenge.urlResource isKindOfClass:[NSNull class]]) {
            challenge.urlResource = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        challenge.idAuthor = [[snippet objectForKey:@"user"] objectForKey:@"facebookUser"];
        challenge.nameAuthor = [[snippet objectForKey:@"user"] objectForKey:@"username"];
        challenge.creationDate = [[snippet objectForKey:@"challenge"] objectForKey:@"created_at"];
        //unrelated, notified, accepted (incomplete), rejected, completed.
        challenge.userStatus = @"unrelated";
        
        challenge.donation = [[snippet objectForKey:@"challenge"] objectForKey:@"defaultAmount"];
        challenge.idPayPal = [[snippet objectForKey:@"organization"] objectForKey:@"paypalAccount"];
        challenge.organization = [[snippet objectForKey:@"organization"] objectForKey:@"companyName"];
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
    NSDictionary *evidencesDictionary = [dictonaryJson objectForKey:@"evidences"];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    for (NSDictionary *snippet in evidencesDictionary) {
        Evidence *evidence = [Evidence alloc];
        evidence.evidenceId = [[snippet objectForKey:@"challengeresponse"] objectForKey:@"id"];
        evidence.userId = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"user_id"];
        evidence.imageUrl = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"imageUrl"];
        if([evidence.imageUrl isKindOfClass:[NSNull class]]) {
            evidence.imageUrl = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        evidence.videoUrl = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"videoUrl"];
        if([evidence.videoUrl isKindOfClass:[NSNull class]]) {
            evidence.videoUrl = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        evidence.mediaType = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"mediaType"];
        evidence.created_at = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"created_at"];
        evidence.updated_at = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"updated_at"];
        evidence.challengeId = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"challenge_id"];
        evidence.hasevidence = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"hasevidence"];
      
        //evidence.descriptionEvidence = [[snippet objectForKey:@"challengeresponse"]  objectForKey:@"descriptionEvidence"];
        evidence.descriptionEvidence = @"joining a good act";
        
        evidence.userName = [[snippet objectForKey:@"user"]  objectForKey:@"username"];
        evidence.userfacebookId = [[snippet objectForKey:@"user"]  objectForKey:@"facebookUser"];
        [resultArray addObject:evidence];
    }
    NSLog(@"resultArray: %lu", [resultArray count]);
    return resultArray;
}

-(NSMutableArray *)getParsingChallengeEvidence:(NSDictionary *) dictonaryJson {
    NSDictionary *evidencesDictionary = [dictonaryJson objectForKey:@"evidences"];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
   // NSLog(@"dictonaryJson: %@", dictonaryJson);
    for (NSDictionary *snippet in evidencesDictionary) {
        Challenge *challenge = [Challenge alloc];
        challenge.idChallenge = [[snippet objectForKey:@"challenge"] objectForKey:@"id"];
        challenge.title = [[snippet objectForKey:@"challenge"] objectForKey:@"title"];
        challenge.descriptionItem = [[snippet objectForKey:@"challenge"] objectForKey:@"description"];
        challenge.type = [[snippet objectForKey:@"challenge"] objectForKey:@"typeresource"];
        challenge.urlResource = [[snippet objectForKey:@"challenge"] objectForKey:@"urlresource"];
        challenge.urlThumbnail = [[snippet objectForKey:@"challenge"] objectForKey:@"url_thumbnail"];
        if([challenge.urlThumbnail isKindOfClass:[NSNull class]]) {
            challenge.urlThumbnail = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        if([challenge.urlResource isKindOfClass:[NSNull class]]) {
            challenge.urlResource = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        challenge.idAuthor = [[snippet objectForKey:@"user"] objectForKey:@"facebookUser"];
        challenge.nameAuthor = [[snippet objectForKey:@"user"] objectForKey:@"username"];
        challenge.creationDate = [[snippet objectForKey:@"challenge"] objectForKey:@"created_at"];
        //unrelated, notified, accepted (incomplete), rejected, completed.
        if([[dictonaryJson objectForKey:@"resultType"] isEqualToString:@"getChallengesEvidencesByUserId"])
            challenge.userStatus = @"completed";
        if([[dictonaryJson objectForKey:@"resultType"] isEqualToString:@"getChallengesPendingEvidencesByUserId"])
            challenge.userStatus = @"accepted";
        challenge.donation = [[snippet objectForKey:@"challenge"] objectForKey:@"defaultAmount"];
        challenge.idPayPal = [[snippet objectForKey:@"organization"] objectForKey:@"paypalAccount"];
        challenge.organization = [[snippet objectForKey:@"organization"] objectForKey:@"companyName"];
        
        [resultArray addObject:challenge];
    }
    return resultArray;
}

-(NSMutableArray *)getParsingChallengeRequests:(NSDictionary *) dictonaryJson {
    NSDictionary *challengeRequestsDictionary = [dictonaryJson objectForKey:@"challengerequests"];
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    //NSLog(@"dictonaryJson: %@", dictonaryJson);
    for (NSDictionary *snippet in challengeRequestsDictionary) {
        Challenge *challenge = [Challenge alloc];
        challenge.idChallenge = [[snippet objectForKey:@"challenge"] objectForKey:@"id"];
        challenge.title = [[snippet objectForKey:@"challenge"] objectForKey:@"title"];
        challenge.descriptionItem = [[snippet objectForKey:@"challenge"] objectForKey:@"description"];
        challenge.type = [[snippet objectForKey:@"challenge"] objectForKey:@"typeresource"];
        challenge.urlResource = [[snippet objectForKey:@"challenge"] objectForKey:@"urlresource"];
        challenge.urlThumbnail = [[snippet objectForKey:@"challenge"] objectForKey:@"url_thumbnail"];
        if([challenge.urlThumbnail isKindOfClass:[NSNull class]]) {
            challenge.urlThumbnail = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        if([challenge.urlResource isKindOfClass:[NSNull class]]) {
            challenge.urlResource = @"http://www.telebajar.com/wp-content/themes/TechNews/images/img_not_available.png";
        }
        challenge.idAuthor = [[snippet objectForKey:@"sourceuser"] objectForKey:@"facebookUser"];
        challenge.nameAuthor = [[snippet objectForKey:@"sourceuser"] objectForKey:@"username"];
        challenge.creationDate = [[snippet objectForKey:@"challenge"] objectForKey:@"created_at"];
        //unrelated, notified, accepted (incomplete), rejected, completed.
        NSNumber *status = [[snippet objectForKey:@"challengerequest"] objectForKey:@"status_id"];
        if([status integerValue] == 0){
            challenge.userStatus = @"notDecided";
        }else
            if([status integerValue] == 1){
                challenge.userStatus = @"accepted";
            }
        else
            challenge.userStatus = @"rejected";
        challenge.donation = [[snippet objectForKey:@"challenge"] objectForKey:@"defaultAmount"];
        challenge.idPayPal = [[snippet objectForKey:@"organization"] objectForKey:@"paypalAccount"];
        challenge.organization = [[snippet objectForKey:@"organization"] objectForKey:@"companyName"];

        [resultArray addObject:challenge];
    }
    return resultArray;
}


@end
