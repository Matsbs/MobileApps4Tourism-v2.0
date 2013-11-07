//
//  MapViewController.h
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 04.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController <UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>

@property (nonatomic, retain) MKMapView *mapView;

@end
