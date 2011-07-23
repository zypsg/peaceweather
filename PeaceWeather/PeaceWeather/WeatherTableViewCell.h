//
//  WeatherTableViewCell.h
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherTableViewCell : UITableViewCell {
    
}

- (void) setWeatherInfo:(NSString*)weather statisticsInfo:(NSString*)statistics sourceImage:(UIImage*)image;

- (void) accurateBtnPressed:(id)sender;
- (void) unaccurateBtnPressed:(id)sender;

@end
