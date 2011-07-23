//
//  PeaceHttpTool.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PeaceHttpToolDelegate; 
@interface PeaceHttpTool : NSObject {
    id<PeaceHttpToolDelegate> delegate;
    NSMutableData* data;
    NSMutableDictionary* dict;
    
}
@property (assign) id<PeaceHttpToolDelegate> delegate;

- (void) sendHttpRequestWithUrl:(NSString*)url isGetMethod:(BOOL)get withData:(NSData*)data withDelegate:(id)aDelegate;

@end

@protocol PeaceHttpToolDelegate <NSObject>

- (void) httpFinished:(NSDictionary*)dict;
- (void) httpFailed:(NSDictionary*)dict;

@end