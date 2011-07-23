//
//  WeatherInfoFetcher.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeaceHttpTool.h"

typedef enum _WeatherFetchStep
{
    WeatherFetchStepGoogle =1,
    WeatherFetchStepYahoo
}WeatherFetchStep;

@protocol WeatherInfoFetcherProtocol;
@interface WeatherInfoFetcher : NSObject <PeaceHttpToolDelegate,NSXMLParserDelegate>{
    PeaceHttpTool* httpTool;
    WeatherFetchStep step;
    id<WeatherInfoFetcherProtocol> delegate;
    NSMutableDictionary* weatherDict;
}
@property (nonatomic,assign) id<WeatherInfoFetcherProtocol> delegate;

- (void) getWeatherInfo;

- (void) parserWeather:(NSString*)weather;

 

@end

@protocol WeatherInfoFetcherProtocol <NSObject>

- (void) weatherFetchedSuccess:(NSDictionary*)dict;

- (void) weatherFetchedFailed:(NSDictionary*)dict;

@end