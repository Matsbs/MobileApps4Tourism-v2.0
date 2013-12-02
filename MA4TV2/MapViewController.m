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
	
    self.counter = 1;
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    if (self.showAll == NO && self.isTour == NO) {
        self.poi = [self.dbManager getPOIbyName:self.poiName];
        CLLocationCoordinate2D coord = {.latitude =  self.poi.latitude, .longitude =  self.poi.longitude};
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coord;
        point.title = self.poi.name;
        point.subtitle = self.poi.description;
        [self.mapView addAnnotation:point];
    }else if (self.isTour == YES){
        self.pois = [self.dbManager getPOIsbyTourName:self.tourName];
        CLLocationCoordinate2D coords[self.pois.count];
        for (int i=0; i<self.pois.count; i++) {
            CLLocationCoordinate2D coord = {.latitude =  [[self.pois objectAtIndex:i] latitude], .longitude =  [[self.pois objectAtIndex:i] longitude]};
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 10000, 10000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coord;
            point.title = [[self.pois objectAtIndex:i] name];
            point.subtitle = [[self.pois objectAtIndex:i] description];
            [self.mapView addAnnotation:point];
            coords[i].latitude = coord.latitude;
            coords[i].longitude = coord.longitude;
//            if (i==2) {
//                [self drawRoute:[[self.pois objectAtIndex:i] latitude] :[[self.pois objectAtIndex:i] longitude] : [[self.pois objectAtIndex:i+1] latitude]: [[self.pois objectAtIndex:i+1] longitude]];
//            }
        }
        MKPolyline *routeLine = [MKPolyline polylineWithCoordinates:coords count:self.pois.count];
        [self.mapView addOverlay:routeLine];
    }else{
        self.pois = [self.dbManager getAllPOIs];
        for (int i=0; i<self.pois.count; i++) {
            CLLocationCoordinate2D coord = {.latitude =  [[self.pois objectAtIndex:i] latitude], .longitude =  [[self.pois objectAtIndex:i] longitude]};
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 10000, 10000);
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coord;
            point.title = [[self.pois objectAtIndex:i] name];
            point.subtitle = [[self.pois objectAtIndex:i] description];
            [self.mapView addAnnotation:point];
        }
    }
    [self.view addSubview:self.mapView];
}

- (void)drawRoute:(double) latSource :(double)longSource :(double) latDest :(double) longDest {
    MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(latSource, longSource) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    
    MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
    [srcMapItem setName:@""];
    
    MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(latDest, longSource) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
    
    MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
    [distMapItem setName:@""];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:srcMapItem];
    [request setDestination:distMapItem];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSLog(@"response = %@",response);
        NSArray *arrRoutes = [response routes];
        [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MKRoute *rout = obj;
            
            MKPolyline *line = [rout polyline];
            [self.mapView addOverlay:line];
            NSLog(@"adding route to map");
            //            NSLog(@"Rout Name : %@",rout.name);
            //            NSLog(@"Total Distance (in Meters) :%f",rout.distance);
            //
            //            NSArray *steps = [rout steps];
            //
            //            NSLog(@"Total Steps : %d",[steps count]);
            //
            //            [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //                NSLog(@"Rout Instruction : %@",[obj instructions]);
            //                NSLog(@"Rout Distance : %f",[obj distance]);
            //            }];
        }];
    }];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView* aView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline*)overlay] ;
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        aView.lineWidth = 10;
        return aView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    NSString *annotationIdentifier = @"PinViewAnnotation";

    MKPinAnnotationView *pinView1 = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    MKAnnotationView *pinView2 = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView1){
        pinView1 = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        pinView2 = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        [pinView1 setPinColor:MKPinAnnotationColorGreen];
        pinView1.animatesDrop = YES;
        pinView1.canShowCallout = YES;
        pinView2.canShowCallout = YES;
        POI *newPoi = [self.dbManager getPOIbyName:annotation.title];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:newPoi.imagePath]];
        [iconView setFrame:CGRectMake(0, 0, 30, 30)];
        pinView1.leftCalloutAccessoryView = iconView;
        pinView1.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView2.leftCalloutAccessoryView = iconView;
        pinView2.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        if (self.isTour) {
            NSString *imagePath = [[NSString alloc] initWithFormat:@"%@%d%@",@"number_" ,self.counter,@".png" ];
            pinView2.image = [UIImage imageNamed:imagePath];
            pinView2.frame = CGRectMake(0, 0, 20, 20);
            self.counter++;
        }
    }
    else{
        pinView1.annotation = annotation;
        pinView2.annotation = annotation;
    }
    if (self.isTour==YES) {
        return pinView2;
    }else{
        return pinView1;
    }
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
