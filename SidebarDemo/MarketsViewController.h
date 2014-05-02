//
//  MarketsViewController.h
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MarketsViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) NSArray *marketNames;
@property (weak, nonatomic) NSArray *marketLat;
@property (weak, nonatomic) NSArray *marketLong;
@end
