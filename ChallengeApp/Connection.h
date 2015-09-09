//
//  Connection.h
//  Networking
//
//  Copyright (c) 2014 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Connection;

@protocol ConnectionDelegate <NSObject>

- (void) connection: (Connection *) connection didFinishWithResultData: (NSData *) resultData;

@end



@interface Connection : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<ConnectionDelegate> delegate;

- (void) downloadFileFromUrl:(NSString *)urlString;

@end
