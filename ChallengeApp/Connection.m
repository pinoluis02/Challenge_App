//
//  Connection.m
//  Networking
//
//  Copyright (c) 2014 Mobile Consulting Solutions. All rights reserved.
//

#import "Connection.h"

@interface Connection(){
    NSURLConnection *con;
}

@property (nonatomic, strong) NSMutableData *xmlData;

@end


@implementation Connection


- (void) downloadFileFromUrl:(NSString *)urlString {
 
    self.xmlData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    // Executed when the response is constructed.
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // Executed when chunks of data are recieved
   
    [self.xmlData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Executed when the entire response is finished downloading
    
    [self.delegate connection:self didFinishWithResultData:self.xmlData];
    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
 
    // Executed when the connection is terminated due to error.
}




@end
