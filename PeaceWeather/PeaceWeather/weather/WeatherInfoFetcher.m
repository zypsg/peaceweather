//
//  WeatherInfoFetcher.m
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WeatherInfoFetcher.h"



@implementation WeatherInfoFetcher
@synthesize delegate;
//- (void) sendHttpRequestWithUrl:(NSString*)url isGetMethod:(BOOL)get withData:(NSData*)data withDelegate:(id)aDelegate;

- (void) getWeatherInfo
{
    if(httpTool==nil)
    {
        httpTool = [[PeaceHttpTool alloc] init];
        step= WeatherFetchStepGoogle;
    }
    if(weatherDict==nil)
    {
        weatherDict = [[NSMutableDictionary  alloc] init];
    }
    if(step == WeatherFetchStepGoogle)
    {
        [httpTool sendHttpRequestWithUrl:@"http://www.google.com/ig/api?weather=Beijing" isGetMethod:YES withData:nil withDelegate:self];
    }
    else if(step == WeatherFetchStepYahoo)
    {
        [httpTool sendHttpRequestWithUrl:@"http://weather.yahooapis.com/forecastrss?w=2151330&u=c" isGetMethod:YES withData:nil withDelegate:self];
    }

}


- (void)dealloc
{
    [httpTool release];
    [super dealloc];
}

#pragma mark-
#pragma mark---PeaceHttpToolDelegate Methods---
- (void) httpFinished:(NSDictionary*)dict
{
    NSString* statusCode= [dict valueForKey:@"statuscode"];
    NSData* responseData= [dict valueForKey:@"data"];
    NSString* content=nil;
    if(step== WeatherFetchStepGoogle)
    {
        content = [[NSString alloc] initWithData:responseData encoding: CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000)];
        
//        NSXMLParser* parser = [[NSXMLParser alloc] initWithData:responseData];
//        [parser setDelegate:self];
//        [parser parse];
//        [parser release];
        
    }
    else if(step == WeatherFetchStepYahoo)
    {
        content = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    }
    [self parserWeather:content];
//    NSLog(@"status code:%@,content:%@",statusCode,content);
    [content release];
}
- (void) httpFailed:(NSDictionary*)dict
{
    [weatherDict removeAllObjects];
    [weatherDict setValue:[NSNumber numberWithInt:step] forKey:@"step"];
    [weatherDict setValue:@"获取天气信息出错" forKey:@"condition"];
    if(step == WeatherFetchStepGoogle)
    {
        
        step = WeatherFetchStepYahoo;
        [self getWeatherInfo];
    }
    else if(step == WeatherFetchStepYahoo)
    {
    }
    if([delegate respondsToSelector:@selector(weatherFetchedFailed:)])
    {
        [delegate weatherFetchedFailed:weatherDict];
    }
    
}

#pragma mark-
#pragma mark--- parser weather---
- (void) parserWeather:(NSString*)weather;
{
 
    [weatherDict setValue:[NSNumber numberWithInt:step] forKey:@"step"];
    if(step == WeatherFetchStepGoogle)
    {
        /*
         <xml_api_reply version="1">
         <weather module_id="0" tab_id="0" mobile_row="0" mobile_zipped="1" row="0" section="0">
         <forecast_information>
         <city data="Beijing, Beijing"/>
         <postal_code data="Beijing"/>
         <latitude_e6 data=""/>
         <longitude_e6 data=""/>
         <forecast_date data="2011-07-23"/>
         <current_date_time data="2011-07-23 19:30:00 +0000"/>
         <unit_system data="SI"/>
         </forecast_information>
         <current_conditions>
         <condition data="多云"/>
         <temp_f data="88"/>
         <temp_c data="31"/>
         <humidity data="湿度： 75%"/>
         <icon data="/ig/images/weather/cn_cloudy.gif"/>
         <wind_condition data="风向： 东、风速：2 米/秒"/>
         </current_conditions>
         <forecast_conditions>
         <day_of_week data="周六"/>
         <low data="25"/>
         <high data="34"/>
         <icon data="/ig/images/weather/sunny.gif"/>
         <condition data="晴"/>
         </forecast_conditions>
         <forecast_conditions>
         <day_of_week data="周日"/>
         <low data="23"/>
         <high data="30"/>
         <icon data="/ig/images/weather/chance_of_storm.gif"/>
         <condition data="可能有暴风雨"/>
         </forecast_conditions>
         <forecast_conditions>
         <day_of_week data="周一"/>
         <low data="23"/>
         <high data="33"/>
         <icon data="/ig/images/weather/chance_of_storm.gif"/>
         <condition data="可能有暴风雨"/>
         </forecast_conditions>
         <forecast_conditions>
         <day_of_week data="周二"/>
         <low data="22"/>
         <high data="33"/>
         <icon data="/ig/images/weather/mostly_sunny.gif"/>
         <condition data="晴间多云"/>
         </forecast_conditions>
         </weather>
         </xml_api_reply>
         */
//        NSDictionary* dict = [weather propertyListFromStringsFileFormat];
//        NSLog(@"dict:%@",dict);
        NSRange beginRange = [weather rangeOfString:@"<forecast_conditions>"];
        NSRange endRange = [weather rangeOfString:@"</forecast_conditions>"];
        NSString* todaySubString = [weather substringWithRange:NSMakeRange(beginRange.location+beginRange.length, endRange.location-(beginRange.location+beginRange.length))];
//        NSLog(@"todaySubString:%@",todaySubString);
        //<day_of_week data="周六"/><low data="25"/><high data="34"/><icon data="/ig/images/weather/sunny.gif"/><condition data="晴"/>
 
        beginRange = [todaySubString rangeOfString:@"<low data=\""];
        NSString* lowDataSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [lowDataSubString rangeOfString:@"\"/>"];
        NSString* lowData = [lowDataSubString substringToIndex:beginRange.location];
//        NSLog(@"lowData:%@",lowData);
        [weatherDict setValue:lowData forKey:@"lowTemp"];
        
        beginRange = [todaySubString rangeOfString:@"<high data=\""];
        NSString* highDataSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [highDataSubString rangeOfString:@"\"/>"];
        NSString* highData = [highDataSubString substringToIndex:beginRange.location];
//        NSLog(@"highData:%@",highData);
        [weatherDict setValue:highData forKey:@"highTemp"];
        
        beginRange = [todaySubString rangeOfString:@"<condition data=\""];
        NSString* conditionSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [conditionSubString rangeOfString:@"\"/>"];
        NSString* conditionData = [conditionSubString substringToIndex:beginRange.location];
//        NSLog(@"conditionData:%@",conditionData);
        [weatherDict setValue:conditionData forKey:@"condition"];
        
        if([delegate respondsToSelector:@selector(weatherFetchedSuccess:)])
        {
            [delegate weatherFetchedSuccess:weatherDict];
        }
        
        step = WeatherFetchStepYahoo;
        [self getWeatherInfo];
    }
    else if(step == WeatherFetchStepYahoo)
    {
        /*
         <rss xmlns:yweather="http://xml.weather.yahoo.com/ns/rss/1.0" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#" version="2.0">
         <channel>
         <title>Yahoo! Weather - Beijing, CN</title>
         <link>
         http://us.rd.yahoo.com/dailynews/rss/weather/Beijing__CN/*http://weather.yahoo.com/forecast/CHXX0008_c.html
         </link>
         <description>Yahoo! Weather for Beijing, CN</description>
         <language>en-us</language>
         <lastBuildDate>Sat, 23 Jul 2011 12:59 pm CST</lastBuildDate>
         <ttl>60</ttl>
         <yweather:location city="Beijing" region="" country="China"/>
         <yweather:units temperature="C" distance="km" pressure="mb" speed="km/h"/>
         <yweather:wind chill="30" direction="0" speed="3.22"/>
         <yweather:atmosphere humidity="79" visibility="1" pressure="982.05" rising="0"/>
         <yweather:astronomy sunrise="5:04 am" sunset="7:36 pm"/>
         <image>
         <title>Yahoo! Weather</title>
         <width>142</width>
         <height>18</height>
         <link>http://weather.yahoo.com</link>
         <url>
         http://l.yimg.com/a/i/brand/purplelogo//uh/us/news-wea.gif
         </url>
         </image>
         <item>
         <title>Conditions for Beijing, CN at 12:59 pm CST</title>
         <geo:lat>39.91</geo:lat>
         <geo:long>116.39</geo:long>
         <link>
         http://us.rd.yahoo.com/dailynews/rss/weather/Beijing__CN/*http://weather.yahoo.com/forecast/CHXX0008_c.html
         </link>
         <pubDate>Sat, 23 Jul 2011 12:59 pm CST</pubDate>
         <yweather:condition text="Fog" code="20" temp="30" date="Sat, 23 Jul 2011 12:59 pm CST"/>
         <description>
         <![CDATA[
         <img src="http://l.yimg.com/a/i/us/we/52/20.gif"/><br /> <b>Current Conditions:</b><br /> Fog, 30 C<BR /> <BR /><b>Forecast:</b><BR /> Sat - Sunny. High: 33 Low: 26<br /> Sun - PM Thunderstorms. High: 29 Low: 23<br /> <br /> <a href="http://us.rd.yahoo.com/dailynews/rss/weather/Beijing__CN/*http://weather.yahoo.com/forecast/CHXX0008_c.html">Full Forecast at Yahoo! Weather</a><BR/><BR/> (provided by <a href="http://www.weather.com" >The Weather Channel</a>)<br/>
         ]]>
         </description>
         <yweather:forecast day="Sat" date="23 Jul 2011" low="26" high="33" text="Sunny" code="32"/>
         <yweather:forecast day="Sun" date="24 Jul 2011" low="23" high="29" text="PM Thunderstorms" code="38"/>
         <guid isPermaLink="false">CHXX0008_2011_07_23_12_59_CST</guid>
         </item>
         </channel>
         </rss>
         <!--
         api2.weather.sg1.yahoo.com compressed/chunked Fri Jul 22 23:22:35 PDT 2011
         -->
         */
        
        NSRange beginRange = [weather rangeOfString:@"<yweather:forecast day="];
        NSString* todaySubString = [weather substringFromIndex:beginRange.location+beginRange.length];
        //"Sat" date="23 Jul 2011" low="26" high="33" text="Sunny" code="32"/>
//        NSLog(@"todaySubString:%@",todaySubString);
        
        beginRange = [todaySubString rangeOfString:@"low=\""];
        NSString* lowDataSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [lowDataSubString rangeOfString:@"\""];
        NSString* lowData = [lowDataSubString substringToIndex:beginRange.location];
//        NSLog(@"lowData:%@",lowData);
        [weatherDict setValue:lowData forKey:@"lowTemp"];
        
        beginRange = [todaySubString rangeOfString:@"high=\""];
        NSString* highDataSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [highDataSubString rangeOfString:@"\""];
        NSString* highData = [highDataSubString substringToIndex:beginRange.location];
//        NSLog(@"highData:%@",highData);
        [weatherDict setValue:highData forKey:@"highTemp"];
        
        beginRange = [todaySubString rangeOfString:@"text=\""];
        NSString* conditionSubString = [todaySubString substringFromIndex:beginRange.location+beginRange.length];
        beginRange = [conditionSubString rangeOfString:@"\""];
        NSString* conditionData = [conditionSubString substringToIndex:beginRange.location];
//        NSLog(@"conditionData:%@",conditionData);
        [weatherDict setValue:conditionData forKey:@"condition"];
        
        if([delegate respondsToSelector:@selector(weatherFetchedSuccess:)])
        {
            [delegate weatherFetchedSuccess:weatherDict];
        }
        [weatherDict removeAllObjects];
    }
}
 

#pragma mark-
#pragma mark--- NSXMLParserDelegate Methods---
//- (void)parserDidStartDocument:(NSXMLParser *)parser
//{
//    NSLog(@"parserDidStartDocument...");
//}
//- (void)parserDidEndDocument:(NSXMLParser *)parser
//{
//    NSLog(@"parserDidEndDocument...");
//}
//
//- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
//{
//    NSLog(@"parseErrorOccurred...%@,line:%d,column:%d",parseError,[parser lineNumber],[parser columnNumber] );
//}
//
//- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
//{
//    NSLog(@"didStartElement:%@",elementName);
//}
//
//- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
//{
//      NSLog(@"didEndElement:%@",elementName);
//}

@end
