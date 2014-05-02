//
//  DirectionsMapViewController.h
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface DirectionsMapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSNumber *selectedLat;
@property (strong, nonatomic) NSNumber *selectedLong;
@property (strong, nonatomic) NSString *detailFarm;
@property (strong, nonatomic) MKRoute *route;
@property (strong, nonatomic) IBOutlet UIScrollView *detailsScroller;


@end
