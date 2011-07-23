//
//  PeaceHttpTool.m
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PeaceHttpTool.h"


@implementation PeaceHttpTool
@synthesize delegate;

- (void) sendHttpRequestWithUrl:(NSString*)urlstr isGetMethod:(BOOL)get withData:(NSData*)postdata withDelegate:(id)aDelegate
{
    NSURL* url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest* request= [[NSMutableURLRequest alloc] initWithURL:url];
    if(get)
    {
        [request setHTTPMethod:@"GET"]; 
    }
    else
    {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postdata];
    }
    self.delegate = aDelegate;
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [connection release];
    
}

- (void) dealloc
{
    [super dealloc];
    if(data)
    {
        [data release];
    }
    if(dict)
    {
        [dict release];
    }
}

#pragma mark-
#pragma mark---NSURLConnection Delegate Methods ---
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(dict)
    {
        [dict release];
        dict= nil;
    }
    if(data)
    {
        [data release];
        data= nil;
    }
    dict = [[NSMutableDictionary alloc] init];
    NSInteger statusCode = 0;
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        statusCode = [httpResponse statusCode];
    }
    [dict  setValue:[NSNumber numberWithInt:statusCode] forKey:@"statuscode"];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)receivedata
{
    if(data==nil)
    {
        data = [[NSMutableData alloc] init];
    }
    [data appendData:receivedata];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [dict setValue:data forKey:@"data"];
    if([delegate respondsToSelector:@selector(httpFinished:)])
    {
        [delegate httpFinished:dict];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [dict setValue:error  forKey:@"error"];
    if([delegate respondsToSelector:@selector(httpFailed:)])
    {
        [delegate httpFailed:dict];
    }
}
@end
