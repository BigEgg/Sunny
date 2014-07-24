//
//  RecordTableViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordTableViewController.h"

@interface RecordTableViewController ()

@end

@implementation RecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Records";

    [self initData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tableViewData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [self.tableViewData objectForKey:[self sectionToSectionName:section]];
    return [(NSArray *) sectionInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Common to all cells
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure individual cells
    id section = [self.tableViewData objectForKey:[self sectionToSectionName:indexPath.section]];
    NSString *rowLabel = [section objectAtIndex:indexPath.row];
    cell.textLabel.text = rowLabel;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Stop Records";
        case 1:
            return @"Shake Records";
        case 2:
            return @"Walk Records";
        case 3:
            return @"Run Records";
        default:
            return nil;
    }
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma Private Methods

- (void)initData {
    NSArray *sectionStop = [NSArray arrayWithObjects:@"Straight Lines", @"Curves", @"Shapes", nil];
    NSArray *sectionShake = [NSArray arrayWithObjects:@"Solid Fills", @"Gradient Fills", @"Image & Pattern Fills", nil];
    NSArray *sectionWalk = [NSArray arrayWithObjects:@"Simple Animations", @"Bounce", @"Other Options", nil];
    NSArray *sectionRun = [NSArray arrayWithObjects:@"Simple Animations", @"Bounce", @"Other Options", nil];
    self.tableViewData = [NSDictionary dictionaryWithObjectsAndKeys:
                          sectionStop, [self sectionToSectionName:0],
                          sectionShake, [self sectionToSectionName:1],
                          sectionWalk, [self sectionToSectionName:2],
                          sectionRun, [self sectionToSectionName:3],
                          nil];
}

- (NSString *)sectionToSectionName:(NSInteger)sectionId {
    switch (sectionId) {
        case 0:
            return @"sectionStop";
        case 1:
            return @"sectionShake";
        case 2:
            return @"sectionWalk";
        case 3:
            return @"sectionRun";
        default:
            return nil;
    }
}

@end
