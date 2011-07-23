//
//  WeatherTableViewCell.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherEstimateProtocol;   
@interface WeatherTableViewCell : UITableViewCell {
    id <WeatherEstimateProtocol> delegate;
}
@property (nonatomic,assign) id <WeatherEstimateProtocol> delegate;

- (void) setWeatherInfo:(NSString*)weather tempInfo:(NSString*)tempInfo statisticsInfo:(NSString*)statistics sourceImage:(UIImage*)image;

- (void) accurateBtnPressed:(id)sender;
- (void) unaccurateBtnPressed:(id)sender;

@end

@protocol WeatherEstimateProtocol <NSObject>

- (void) accurateAdded:(WeatherTableViewCell*)cell;
- (void) unaccurateAdded:(WeatherTableViewCell*)cell;

@end
