//
//  MapViewController.m
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 04.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    // Add an new annotation
    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = userLocation.coordinate.latitude+1;
    zoomLocation.longitude= userLocation.coordinate.longitude+1;
    point2.coordinate = zoomLocation;
    point2.title = @"New point";
    point2.subtitle = @"I'm here!!!";

    [self.mapView addAnnotation:point2];
    [self.mapView addAnnotation:point];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    NSString *annotationIdentifier = @"PinViewAnnotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!pinView){
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        [pinView setPinColor:MKPinAnnotationColorGreen];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        //UIImageView *houseIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"house.png"]];
        //[houseIconView setFrame:CGRectMake(0, 0, 30, 30)];
        //pinView.leftCalloutAccessoryView = houseIconView;
    }
    else{
        pinView.annotation = annotation;
    }
    return pinView;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
