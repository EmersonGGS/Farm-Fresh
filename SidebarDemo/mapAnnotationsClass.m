//
//  mapAnnotationsClass.m
//  Farm Fresh Simcoe
//
//  Created by Emerson Stewart on 2014-04-14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
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
