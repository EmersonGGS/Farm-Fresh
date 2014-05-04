//
//  ShoppingViewController.m
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-10.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ShoppingViewController.h"
#import "SWRevealViewController.h"
#import "DirectionsMapViewController.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ShoppingViewController ()
@end

@implementation ShoppingViewController

NSArray *global;
NSArray *january;
NSArray *february;
NSArray *march;
NSArray *april;
NSArray *may;
NSArray *june;
NSArray *july;
NSArray *august;
NSArray *september;
NSArray *october;
NSArray *november;
NSArray *december;
NSArray *listArray;
NSMutableArray *monthsArray;

NSString *detailFarm;


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
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.667 green:0.796 blue:0.655 alpha:1.0];
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    // User location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
    NSLog(@"Current Location Lat: %f Long: %f",self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    
    self.titlesArray = [[NSMutableArray alloc] init];
    
    PFQuery *updateTableArray = [PFQuery queryWithClassName:@"saveList"];
    [updateTableArray whereKey:@"User" equalTo:PFUser.currentUser];
    [updateTableArray findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d objects.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                self.titlesArray = object[@"listItems"];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
    
    
   
    //Init arrays for checking in season.v
    may = [NSArray arrayWithObjects:@"Asparagus",@"Fiddleheads",@"Radishes", nil];
    june = [NSArray arrayWithObjects:@"Asparagus",@"Beans",@"Beets",@"Broccoli",@"Cauliflower",@"Cherries",@"Cucumber",@"Lettuce",@"Peas",@"Radishes",@"Strawberries", nil];
    july = [NSArray arrayWithObjects:@"Beans",@"Beets",@"Blueberries",@"Broccoli",@"Cabbage",@"Carrots",@"Cauliflower",@"Celery",@"Cherries",@"Corn",@"Cucumber",@"Lettuce",@"Onions",@"Peaches",@"Peas",@"Peppers",@"Plums",@"Potatoes",@"Radishes",@"Raspberries",@"Strawberries",@"Tomatoes", nil];
    
    august = [NSArray arrayWithObjects:@"Apples",@"Beans",@"Beets",@"Blueberries",@"Broccoli",@"Cabbage",@"Carrots",@"Cauliflower",@"Celery",@"Corn",@"Cucumber",@"Eggplant",@"Grapes",@"Lettuce",@"Nectarines",@"Onions",@"Peaches",@"Pears",@"Peas",@"Peppers",@"Plums",@"Potatoes",@"Radishes",@"Raspberries",@"Squash",@"Tomatoes", nil];
    
    september = [NSArray arrayWithObjects:@"Apples",@"Beans",@"Beets",@"Broccoli",@"Cabbage",@"Carrots",@"Cauliflower",@"Celery",@"Corn",@"Cucumber",@"Eggplant",@"Grapes",@"Lettuce",@"Nectarines",@"Onions",@"Peaches",@"Pears",@"Peas",@"Peppers",@"Plums",@"Potatoes",@"Radishes",@"Raspberries",@"Squash",@"Tomatoes", nil];
    
    october = [NSArray arrayWithObjects:@"Apples",@"Beans",@"Beets",@"Broccoli",@"Cabbage",@"Carrots",@"Cauliflower",@"Celery",@"Corn",@"Cucumber",@"Eggplant",@"Grapes",@"Lettuce",@"Onions",@"Pears",@"Peppers",@"Plums",@"Potatoes",@"Radishes",@"Squash",@"Tomatoes", nil];
    
    november = [NSArray arrayWithObjects:@"Apples",@"Beets",@"Cabbage",@"Carrots",@"Cauliflower",@"Pears",@"Potatoes",@"Radishes",@"Squash", nil];
    
    december = [NSArray arrayWithObjects:@"Cabbage",@"Carrots",@"Potatoes",@"Squash", nil];
    
    //delegate textfield as to close it on "return"
    self.item.delegate = self;
    
    
    //initializing swipe recognizer, to remove list items.
    UISwipeGestureRecognizer *lpgr = [[UISwipeGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(handleLongPress:)];
    
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    self.tableView.dataSource = self;
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//When swiped remove the corresponding cell
-(void)handleLongPress:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil){
        
    }
    else{
        [self.titlesArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}

//Set number of rows for the table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titlesArray count];
    
}



// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    //Testing call
    NSLog(@"Cell Tapped.");
    
    // Save text of the selected cell:
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringVariable = cell.detailTextLabel.text;
    
    //Output tapped farm name
    NSLog(@"Farm Selected: %@", stringVariable);
    
    //Query for tapped item lat and lang
    
    if (![cell.detailTextLabel.text  isEqual: @"Not Found"]) {
        
        PFQuery *coordsQuery = [PFQuery queryWithClassName:@"Farm"];
        [coordsQuery whereKey:@"farmName" equalTo:cell.detailTextLabel.text];
        [coordsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %d objects.", objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    NSLog(@"%@", object.objectId);
                    self.selectedLat = [object objectForKey:@"lat"];
                    self.selectedLong = [object objectForKey:@"long"];
                    
                    NSLog(@"Latitude of Farm: %@", self.selectedLat);
                    NSLog(@"Longitude of Farm: %@", self.selectedLong);
                    
                    [self performSegueWithIdentifier: @"displayMap" sender: self];
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"displayMap"]) {
        DirectionsMapViewController *transferViewController = segue.destinationViewController;
        transferViewController.selectedLat = self.selectedLat;
        transferViewController.selectedLong = self.selectedLong;
        transferViewController.detailFarm = self.detailFarm;
    }
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:0.973 green:0.969 blue:0.894 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1.0];
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed:0.882 green:0.878 blue:0.773 alpha:1.0];
        cell.textLabel.textColor = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.114 green:0.114 blue:0.114 alpha:1.0];
    }
}

// locationManager.location.coordinate.latitude;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"myCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *foodItem = [self.titlesArray objectAtIndex:indexPath.row];
    foodItem = [foodItem capitalizedString];
    [cell.textLabel setText:foodItem];
    PFQuery *query = [PFQuery queryWithClassName:@"Farm"];
    [query whereKey:@"produce" equalTo:foodItem];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d farms.", objects.count);
            if (objects.count==0) {
                [cell.detailTextLabel setText: @"Not Found"];
            }
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", [object objectForKey:@"farmName"]);
                NSLog(@"%@", object);
                 
                NSString *detailFarm = [object objectForKey:@"farmName"];
                [cell.detailTextLabel setText: detailFarm];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            
        }
    }];
    cell.textLabel.textColor=[UIColor colorWithRed:0.953 green:0.475 blue:0.302 alpha:1.0];
    cell.layer.cornerRadius = 0;
    
    // grabs month of year for appropriate array
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    
    NSLog(@"%ld",(long)[components month]);
    
    if([components month] == 1){global = january;}
    if([components month] == 2){global = february;}
    if([components month] == 3){global = march;}
    if([components month] == 4){global = june;}
    if([components month] == 5){global = may;}
    if([components month] == 6){global = june;}
    if([components month] == 7){global = july;}
    if([components month] == 8){global = august;}
    if([components month] == 9){global = september;}
    if([components month] == 10){global = october;}
    if([components month] == 11){global = november;}
    if([components month] == 12){global = december;}
    
    
    // checks if in season
    BOOL isItemInSeason = [global containsObject:foodItem];
    if (isItemInSeason) {
        cell.imageView.image = [UIImage imageNamed:@"season.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"notseason.png"];
    }
    
    return cell;
    
}



//basic first responder function to close keyboard on "return"
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.item) {
        NSLog(@"SAVED");   /* Confirmed button pressed */
        
        //Filters empty text
        if (![self.item.text isEqual:@""]) {
            
            //take enetered data and add it to the titlesArray
            [self.titlesArray insertObject:self.item.text atIndex:0];
            
            //reload data from array into table
            [self.tableView reloadData];
        }
        
        //If enetered text is accepted, clear field
        self.item.text
        = @"";
        
        [textField resignFirstResponder];
    }
    return YES;
}


- (IBAction)savebtn:(id)sender {
    
    //Delete prevoius list(s) to reduce clutter and excessive object pulls
    PFQuery *deleteQuery = [PFQuery queryWithClassName:@"saveList"];
    [deleteQuery whereKey:@"User" equalTo:PFUser.currentUser];
    [deleteQuery findObjectsInBackgroundWithBlock:^(NSArray *objToClear, NSError *error) {
        if (!error) {
            //delete objects that exist already
            for (PFObject *obj in objToClear) {
                [obj delete];
            }
        }
        
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    
    //Query for a user with a previous list, or new list
    PFQuery *idQuery = [PFQuery queryWithClassName:@"saveList"];
    [idQuery whereKey:@"User" equalTo:PFUser.currentUser];
    [idQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
                // The find succeeded.
                NSLog(@"Successfully saved list!");
                PFObject *myList = [PFObject objectWithClassName:@"saveList"];
                myList[@"listItems"] = _titlesArray;
                myList[@"User"] = PFUser.currentUser;
                [myList saveEventually];
                self.listObjectId = myList.objectId;
        }
        
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

@end
















