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
#import "POI.h"
#import "DBManager.h"
@class DBManager;
@interface MapViewController : UIViewController <UIApplicationDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) NSString *poiName;
@property (nonatomic, retain) NSString *tourName;
@property (nonatomic, retain) POI *poi;
@property (nonatomic, retain) NSMutableArray *pois;
@property (nonatomic, retain) MKPolyline *polyLine;
@property (nonatomic, retain) DBManager *dbManager;
@property bool showAll;
@property bool isTour;
@property int counter;

@end
