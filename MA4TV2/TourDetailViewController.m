//
//  TourDetailViewController.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "TourDetailViewController.h"

@interface TourDetailViewController ()

@end

@implementation TourDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    self.tour = [self.dbManager getToursByName:self.tourName];
    self.POIs = [[NSMutableArray alloc] initWithArray:[self.dbManager getPOIsbyTourName:self.tour.name]];
    self.title = self.tour.name;
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
    self.navigationItem.rightBarButtonItem = newButton;
    
    self.view.backgroundColor =  [UIColor groupTableViewBackgroundColor];

    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.tour.image]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    [self.view addSubview:self.imageView];
    
    UILabel *totalKM = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/5,40+10+40+(screenHeight/4), screenWidth, 25)];
    totalKM.text = [NSString stringWithFormat:@"%d %@ %.1f %@ %.f %@", self.POIs.count, @"stops, ", self.tour.totalKms, @"km, ", self.tour.totalHours, @"hours"];
    [self.view addSubview:totalKM];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40+80+(screenHeight/4), screenWidth, 100)];
    self.textView.text = self.tour.description;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40+80+(screenHeight/4)+100,screenWidth, screenHeight-(40+40+80+(screenHeight/4)+100)) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIToolbar *downToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight-40, screenWidth, 40)];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    
    self.tours = [self.dbManager getAllTours];
    for (int i=0; i<self.tours.count; i++) {
        if ([[[self.tours objectAtIndex:i] name] isEqualToString:(self.tour.name)]) {
            self.indexOfTour=i;
        }
    }
    if (self.indexOfTour>0) {
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prev.png"] style:UIBarButtonItemStylePlain target:self action:@selector(prevClicked:)];
        [barItems2 addObject:prevButton];
    }
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    if (self.indexOfTour < (self.tours.count-1)) {
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextClicked:)];
        [barItems2 addObject:nextButton];
    }
    
    [downToolbar setItems:barItems2 animated:YES];
    [self.view addSubview:downToolbar];
}

- (IBAction)nextClicked:(id)sender{
    TourDetailViewController *tourDetail = [[TourDetailViewController alloc]init];
    tourDetail.tourName = [[self.tours objectAtIndex:self.indexOfTour+1] name];
    [self.navigationController pushViewController:tourDetail animated:YES];
}

- (IBAction)prevClicked:(id)sender{
    TourDetailViewController *tourDetail = [[TourDetailViewController alloc]init];
    tourDetail.tourName = [[self.tours objectAtIndex:self.indexOfTour-1] name];
    [self.navigationController pushViewController:tourDetail animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.POIs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [(POI*)[self.POIs objectAtIndex:indexPath.row] name];
    [cell setIndentationWidth:64];
    [cell setIndentationLevel:1];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
    imgView.backgroundColor=[UIColor clearColor];
    [imgView.layer setMasksToBounds:YES];
    [imgView setImage:[UIImage imageNamed:[(POI*)[self.POIs objectAtIndex:indexPath.row] imagePath]]];
    [cell.contentView addSubview:imgView];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    POIDetailViewController *poiDetail = [[POIDetailViewController alloc] init];
    poiDetail.poiName = [[self.POIs objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:poiDetail animated:YES];
}


- (IBAction)mapClicked:(id)sender{
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.isTour = YES;
    mapView.showAll = NO;
    mapView.tourName = self.tourName;
    [self.navigationController pushViewController:mapView animated:YES];
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
