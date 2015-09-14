//
//  Comment.h
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (strong, nonatomic) NSString *commentsId;
@property (strong, nonatomic) NSString *evidenceId;
@property (strong, nonatomic) NSString *descripcion;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *idAuthor;

@end
