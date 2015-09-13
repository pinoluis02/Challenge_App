//
//  NetworkManager.h
//  ChallengeApp
//
//  Created by MCS on 9/12/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (NetworkManager *)sharedInstance;

- (NSURL *)smartURLForString:(NSString *)str;
- (BOOL)isImageURL:(NSURL *)url;

- (NSString *)pathForTestImage:(NSUInteger)imageNumber;
- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;

@property (nonatomic, assign, readonly ) NSUInteger     networkOperationCount;  // observable

- (void)didStartNetworkOperation;
- (void)didStopNetworkOperation;

@end
