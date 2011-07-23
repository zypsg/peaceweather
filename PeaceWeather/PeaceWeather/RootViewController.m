//
//  RootViewController.m
//  PeaceWeather
//
//  Created by peacezhao on 11-7-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

typedef enum _WeatherSource
{
    WeatherSourceGoogle,
    WeatherSourceYahoo
}WeatherSource;
@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PeaceWeather";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    WeatherTableViewCell *cell = (WeatherTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[WeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.delegate = self;
    }
    if(indexPath.row == WeatherSourceGoogle)
    {
        NSUInteger totalcount= [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
        NSUInteger googleCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"googlecount"];
        NSString* imageUrl = [[NSBundle mainBundle] pathForResource:@"google.png" ofType:nil];
        UIImage* googleImage = [[UIImage alloc] initWithContentsOfFile:imageUrl];
        [cell setWeatherInfo:@"晴转多云" statisticsInfo:[NSString stringWithFormat:@"%d/%d",googleCount,totalcount] sourceImage:googleImage];
        [googleImage release];
    }
    else if(indexPath.row == WeatherSourceYahoo)
    {
        NSUInteger totalcount= [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
        NSUInteger yahooCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"yahooCount"];
        NSString* imageUrl = [[NSBundle mainBundle] pathForResource:@"yahoo.png" ofType:nil];
        UIImage* yahooImage = [[UIImage alloc] initWithContentsOfFile:imageUrl];
        [cell setWeatherInfo:@"晴转多云" statisticsInfo:[NSString stringWithFormat:@"%d/%d",yahooCount,totalcount] sourceImage:yahooImage];
        [yahooImage release];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}


#pragma mark-
#pragma mark---WeatherEstimateProtocol Methods ---
- (void) accurateAdded:(WeatherTableViewCell*)cell
{
    NSUInteger totalcount= [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
    totalcount++;
    [[NSUserDefaults standardUserDefaults]  setInteger:totalcount forKey:@"count"];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath.row==WeatherSourceGoogle)
    {
        NSLog(@"accurate google");
        NSUInteger googleCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"googlecount"];
        googleCount++;
        [[NSUserDefaults standardUserDefaults] setInteger:googleCount forKey:@"googlecount"];
    }
    else if(indexPath.row == WeatherSourceYahoo)
    {
        NSLog(@"accurate yahoo");
        NSUInteger yahooCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"yahooCount"];
        yahooCount++;
        [[NSUserDefaults standardUserDefaults] setInteger:yahooCount forKey:@"yahooCount"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) unaccurateAdded:(WeatherTableViewCell*)cell
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath.row==WeatherSourceGoogle)
    {
        NSLog(@"unaccurate google");
    }
    else if(indexPath.row == WeatherSourceYahoo)
    {
          NSLog(@"unaccurate yahoo");
    }
}

@end
