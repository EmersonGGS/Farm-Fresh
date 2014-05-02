//
//  DirectionsMapViewController.m
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import "DirectionsMapViewController.h"
#import "ShoppingViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "mapAnnotationsClass.h"
@interface DirectionsMapViewController ()
@end

MKPolyline *_routeOverlay;
MKRoute *_currentRoute;

@implementation DirectionsMapViewController

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
	// Do any additional setup after loading the view.

    
    self.mapView.delegate = self;
    
    [self.mapView setShowsUserLocation:YES];
    
    float localLat = [self.selectedLat floatValue];
    float localLong = [self.selectedLong floatValue];
    //Output passed global vars
    NSLog(@"SELECTED LAT: %f", localLat);
    NSLog(@"SELECTED LONG: %f", localLong);
    
    //Covert NSNumbers to flot values

    
    //Initialize
    MKDirectionsRequest *directionsRequest = [MKDirectionsRequest new];
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    
    // Make the destination
    CLLocationCoordinate2D destinationCoords = CLLocationCoordinate2DMake(localLat, localLong);
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoords addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    // Set the source and destination on the request
    [directionsRequest setSource:source];
    [directionsRequest setDestination:destination];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        // Now handle the result
        if (error) {
            NSLog(@"There was an error getting your directions");
            return;
        }
        
        // No Errors, plot the route
        self.route = [response.routes firstObject];
        [self plotRouteOnMap:self.route];
        
    }];
    
    //Creates and palces annotation
    CLLocationCoordinate2D carrotPin;
    
    carrotPin.latitude = localLat;
    carrotPin.longitude = localLong;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = carrotPin;
    annotationPoint.title = self.detailFarm;
    annotationPoint.subtitle = @"";
    [self.mapView addAnnotation:annotationPoint];
}

- (void)plotRouteOnMap:(MKRoute *)route
{
    
    if(_routeOverlay) {
        [self.mapView removeOverlay:_routeOverlay];
    }
    
    // Update the ivar
    _routeOverlay = route.polyline;
    
    // Add it to the map
    [self.mapView addOverlay:_routeOverlay];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 3.0;
    return  renderer;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"displaySteps"]) {
        DirectionsMapViewController *transferViewController = segue.destinationViewController;
        transferViewController.route = self.route;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
