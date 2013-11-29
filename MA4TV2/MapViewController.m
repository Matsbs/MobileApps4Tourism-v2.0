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
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    if (self.showAll == NO) {
        //self.poi = [[POI alloc] init];
        self.poi = [dbManager getPOIbyName:self.poiName];
        
        CLLocationCoordinate2D coord = {.latitude =  self.poi.latitude, .longitude =  self.poi.longitude};
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        //CLLocationCoordinate2D coord = {.latitude =  self.poi.latitude, .longitude =  self.poi.longitude};
        point.coordinate = coord;
        point.title = self.poi.name;
        point.subtitle = self.poi.description;
        [self.mapView addAnnotation:point];
    }else{
        self.pois = [dbManager getAllPOIs];
        for (int i=0; i<self.pois.count; i++) {
            CLLocationCoordinate2D coord = {.latitude =  [[self.pois objectAtIndex:i] latitude], .longitude =  [[self.pois objectAtIndex:i] longitude]};
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 10000, 10000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
            
            // Add an annotation
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            //CLLocationCoordinate2D coord = {.latitude =  self.poi.latitude, .longitude =  self.poi.longitude};
            point.coordinate = coord;
            point.title = [[self.pois objectAtIndex:i] name];
            point.subtitle = [[self.pois objectAtIndex:i] description];
            [self.mapView addAnnotation:point];
        }
    }
    [self.view addSubview:self.mapView];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
//    
//    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D coord = {.latitude =  self.poi.latitude, .longitude =  self.poi.longitude};
//    point.coordinate = coord;
//    point.title = @"You are here!";
//    
//    NSLog(@"Lat: %f", self.poi.latitude);
//    [self.mapView addAnnotation:point];
    //point.subtitle = @"Yes, you are!";
    
    
    //MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    //MKCoordinateRegion test = {coord, span};
    
    //[mapView setRegion:test];
    
    
    // Add an new annotation
//    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = userLocation.coordinate.latitude+1;
//    zoomLocation.longitude= userLocation.coordinate.longitude+1;
//    point2.coordinate = zoomLocation;
//    point2.title = @"New point";
//    point2.subtitle = @"I'm here!!!";
//
//    [self.mapView addAnnotation:point2];
    //[self.mapView addAnnotation:point];
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
        UIImageView *houseIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
        [houseIconView setFrame:CGRectMake(0, 0, 30, 30)];
        pinView.leftCalloutAccessoryView = houseIconView;
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    else{
        pinView.annotation = annotation;
    }
    return pinView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    POIDetailViewController *poiDetail = [[POIDetailViewController alloc] init];
    poiDetail.poiName = view.annotation.title;
    [self.navigationController pushViewController:poiDetail animated:YES];
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
