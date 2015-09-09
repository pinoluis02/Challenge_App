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
    
    
    NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (!error) {
        
        // todo: set the correct type
        resultType = [NSNumber numberWithInt:didFinishGetAllChallengesWithResult_];

        [self.delegate JSONParsing:self didFinishParsingWithResult:resultArray resultType:resultType error:nil];
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
