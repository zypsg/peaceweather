//
//  WeatherDetainInfoController.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherDetainInfoController : UITableViewController {
    
    NSDictionary* dict;
}
@property (nonatomic, retain)  NSDictionary* dict;

- initWithWeatherDict:(NSDictionary*)dict;

@end
