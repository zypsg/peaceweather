//
//  RootViewController.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherTableViewCell.h"
#import "WeatherInfoFetcher.h"

@interface RootViewController : UITableViewController <WeatherEstimateProtocol,WeatherInfoFetcherProtocol>{
    NSMutableDictionary* weatherDict;
}


@end
