//
//  MarketsViewController.h
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-08.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MarketsViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) NSArray *marketNames;
@property (weak, nonatomic) NSArray *marketLat;
@property (weak, nonatomic) NSArray *marketLong;
@end
