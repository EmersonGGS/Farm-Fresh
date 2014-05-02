//
//  MarketsViewController.m
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-08.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MarketsViewController.h"
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "mapAnnotationsClass.h"
@interface MarketsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end

@implementation MarketsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:0.667 green:0.796 blue:0.655 alpha:1.0];
	// Do any additional setup after loading the view.
    UIBarButtonItem* _sidebarButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(infoButtonSelected:)];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target =
    self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    self.marketNames = [NSArray arrayWithObjects:@"Egos Farm Market and Greenhouses", @"Hewitt's Sweet Corn/Farm Market & Bakery", @"Rural Roots Nursery & Market Garden", nil];
    self.marketLat = [NSArray arrayWithObjects:[NSNumber numberWithDouble:44.590757],[NSNumber numberWithDouble:44.646786],[NSNumber numberWithDouble:44.361316], nil];
    self.marketLong = [NSArray arrayWithObjects: [NSNumber numberWithDouble:-79.582408],[NSNumber numberWithDouble:-79.533846],[NSNumber numberWithDouble:-79.928924],  nil];
   /*
    for (int i = 0; i < self.marketNames.count; i++) {
    //Creates and palces annotation
    CLLocationCoordinate2D carrotPin;
    
    carrotPin.latitude = self.marketLat[i];
    carrotPin.longitude = self.marketLong[i];
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = carrotPin;
    annotationPoint.title = self.marketNames[i];
    annotationPoint.subtitle = @"";
    [self.mapView addAnnotation:annotationPoint];
    }
    */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
