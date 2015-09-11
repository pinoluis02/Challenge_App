//
//  Challenge.h
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 mobile.consulting.services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Challenge : NSObject
@property (strong, nonatomic) NSString *idChallenge;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionItem;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *urlResource;
@property (strong, nonatomic) NSString *urlThumbnail;
@property (strong, nonatomic) NSString *idAuthor;
@property (strong, nonatomic) NSString *nameAuthor;
@property (strong, nonatomic) NSString *creationDate;

@property (strong, nonatomic) NSString *donation;
@property (strong, nonatomic) NSString *idPayPal;
@property (strong, nonatomic) NSString *organization;
//@property (strong, nonatomic) NSString *idUser;
@property float mount;
@end
