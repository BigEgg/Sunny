//
//  RecordsTableViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordsTableViewController.h"
#import "RecordDetailViewController.h"
#import "Utils.h"

@interface RecordsTableViewController ()

@end

@implementation RecordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Records";

    [self initData];

    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(startNewRecord)];
    self.navigationItem.rightBarButtonItem = plusButton;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // Common to all cells
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    // Configure individual cells
    NSString *rowLabel = [self.tableViewData objectAtIndex:indexPath.row];
    cell.textLabel.text = rowLabel;
    cell.detailTextLabel.text = @"sometype";

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];

    // Pass the selected object to the new view controller.

    // Push the view controller.
    //[self.navigationController pushViewController:detailViewController animated:YES];

    RecordDetailViewController *recordDetailVC = [[RecordDetailViewController alloc] initWithFileName:
            [[tableView cellForRowAtIndexPath:indexPath] textLabel].text];

    [self.motionService removeRecordDetailhandlers];
    [self.motionService addHandler:recordDetailVC];

    [self.navigationController pushViewController:recordDetailVC animated:YES];
}

#pragma mark - Actions

- (void)startNewRecord {
    RecordDetailViewController *recordDetailVC = [[RecordDetailViewController alloc] init];

    [self.motionService removeRecordDetailhandlers];
    [self.motionService addHandler:recordDetailVC];

    [self.navigationController pushViewController:recordDetailVC animated:YES];
}


#pragma mark - Private Methods

- (void)initData {
    self.tableViewData = [[NSArray alloc] initWithArray:[Utils getAllFilesName]];
}

@end
