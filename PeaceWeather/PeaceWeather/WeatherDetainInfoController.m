//
//  WeatherDetainInfoController.m
//  PeaceWeather
//
//  Created by peacezhao on 11-7-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WeatherDetainInfoController.h"


@implementation WeatherDetainInfoController
@synthesize dict;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- initWithWeatherDict:(NSDictionary*)adict
{
    self = [self initWithStyle:UITableViewStyleGrouped];
    self.dict = adict;
    return self;
}

- (void)dealloc
{
    [dict release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSUInteger ret = 0;
    ret = 3;
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    
    // Configure the cell...
    if(indexPath.section == 0)
    {
        NSDictionary* currentdict = [self.dict valueForKey:@"currentWeatherDict"];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"天气:%@",[currentdict valueForKey:@"condition"]];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"当前温度:%@",[currentdict valueForKey:@"temp"]];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"更新日期:%@",[currentdict valueForKey:@"date"]];
            cell.textLabel.lineBreakMode = UILineBreakModeWordWrap; 
        }
    }
    else if(indexPath.section == 1)
    {
        NSDictionary* currentdict = [self.dict valueForKey:@"today"];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"天气:%@",[currentdict valueForKey:@"condition"]];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"最高温度:%@",[currentdict valueForKey:@"highTemp"]];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"最低温度:%@",[currentdict valueForKey:@"lowTemp"]];
        }
    }
    else if(indexPath.section == 2)
    {
        NSDictionary* currentdict = [self.dict valueForKey:@"nextday"];
        if(indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"天气:%@",[currentdict valueForKey:@"condition"]];
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"最高温度:%@",[currentdict valueForKey:@"highTemp"]];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"最低温度:%@",[currentdict valueForKey:@"lowTemp"]];
        }
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* title = nil;
    if(section == 0)
    {
        title = @"当前天气状况";
    }
    else if(section == 1)
    {
        title = @"今日天气";
    }
    else if(section == 2)
    {
        title = @"明日天气";
    }
    return title;
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
