//
//  DirectionsMapViewController.h
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-13.
//  Copyright (c) 2014 Appcoda. All rights reserved.
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
