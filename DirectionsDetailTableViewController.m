//
//  DirectionsDetailTableViewController.m
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-04-14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "DirectionsDetailTableViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface DirectionsDetailTableViewController ()

@end

@implementation DirectionsDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Directions";
    NSLog(@"%@", self.route);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.route.steps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stepCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Pull out the correct step
    MKRouteStep *step = self.route.steps[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%02d) %0.1fkm", indexPath.row, step.distance / 1000.0];
    cell.detailTextLabel.text = step.instructions;
    
    return cell;

}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:0.867 green:0.325 blue:0.161 alpha:1.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0.867 green:0.325 blue:0.161 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.867 green:0.325 blue:0.161 alpha:1.0];
    }
}

@end
