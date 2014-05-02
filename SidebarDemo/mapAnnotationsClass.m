//
//  mapAnnotationsClass.m
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import "mapAnnotationsClass.h"
#import <MapKit/MapKit.h>

@implementation mapAnnotationsClass
@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	title = ttl;
	coordinate = c2d;
	return self;
}

@end
