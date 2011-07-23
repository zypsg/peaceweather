//
//  WeatherTableViewCell.m
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WeatherTableViewCell.h"
#define kImageViewTag 100001
#define kInfoLabelTag 100002
#define ktemperatureImageViewTag 100004
#define kStatisticsLabelTag 100003

@implementation WeatherTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView* iv = [[UIImageView alloc] initWithFrame:CGRectMake(2, 7, 30, 30)];
        iv.tag = ktemperatureImageViewTag; 
        [self.contentView addSubview:iv];
        [iv release];
        
        UILabel* infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 2, 100, 24)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textAlignment = UITextAlignmentCenter;
        infoLabel.tag = kInfoLabelTag;
        infoLabel.font = [UIFont systemFontOfSize:16];
        infoLabel.lineBreakMode = UILineBreakModeWordWrap;
        infoLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:infoLabel];
        [infoLabel release];
        
        UILabel* tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 28, 100, 16)];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.textAlignment = UITextAlignmentCenter;
        tempLabel.tag = kInfoLabelTag;
        tempLabel.font = [UIFont systemFontOfSize:13];
        tempLabel.lineBreakMode = UILineBreakModeWordWrap;
        tempLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:tempLabel];
        [tempLabel release];
        
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(infoLabel.frame.origin.x+infoLabel.frame.size.width+2.5, 0, 2, 44)];
        lineView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineView];
        [lineView release];
        
        UILabel* statisticsLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineView.frame.origin.x+lineView.frame.size.width+2.5, 12, 60, 20)];
        statisticsLabel.backgroundColor = [UIColor clearColor];
        statisticsLabel.textAlignment = UITextAlignmentCenter;
        statisticsLabel.font = [UIFont systemFontOfSize:15];
        statisticsLabel.tag = kStatisticsLabelTag;
        statisticsLabel.lineBreakMode = UILineBreakModeWordWrap;
        statisticsLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:statisticsLabel];
        [statisticsLabel release];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(statisticsLabel.frame.origin.x+statisticsLabel.frame.size.width+2.5, 0, 2, 44)];
        lineView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:lineView];
        [lineView release];
        
        UIButton* accurateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        accurateBtn.frame = CGRectMake(lineView.frame.origin.x+lineView.frame.size.width+5, 7, 50, 30);
        [accurateBtn addTarget:self action:@selector(accurateBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [accurateBtn setTitle:@" right" forState:UIControlStateNormal];
        [self.contentView addSubview:accurateBtn];
        
        
        UIButton* unaccurateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        unaccurateBtn.frame = CGRectMake(accurateBtn.frame.origin.x+accurateBtn.frame.size.width+5, 7, 50, 30);
        [unaccurateBtn setTitle:@"wrong" forState:UIControlStateNormal];
        [unaccurateBtn addTarget:self action:@selector(unaccurateBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:unaccurateBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

- (void) setWeatherInfo:(NSString*)weather statisticsInfo:(NSString*)statistics sourceImage:(UIImage*)image
{
    UIImageView* iv = (UIImageView*)[self.contentView viewWithTag: ktemperatureImageViewTag];
    iv.image = image;
    
    UILabel* weatherLabel = (UILabel*)[self.contentView viewWithTag:kInfoLabelTag];
    weatherLabel.text = weather;
    
    UILabel* statisticsLabel = (UILabel*)[self.contentView viewWithTag:kStatisticsLabelTag];
    statisticsLabel.text = statistics;
}

- (void) accurateBtnPressed:(id)sender
{
    NSLog(@"accurateBtnPressed...");
}
- (void) unaccurateBtnPressed:(id)sender
{
    NSLog(@"unaccurateBtnPressed...");
}
@end
