//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>


@interface MainViewController ()
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Home";

    
    self.view.backgroundColor = [UIColor colorWithRed:0.667 green:0.796 blue:0.655 alpha:1.0];
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
    /*
    NSArray *farmFoodsArray = [[NSArray alloc] initWithObjects:@"Apples",@"Cider",@"Beef",nil];
    PFObject *newFarm = [PFObject objectWithClassName:@"Farm"];
    newFarm[@"farmName"] = @"Avalon Orchards";
    newFarm[@"produce"] = farmFoodsArray;
    newFarm[@"lat"] = @44.253888;
    newFarm[@"long"] = @-79.646527;
    [newFarm saveInBackground];
     */

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
