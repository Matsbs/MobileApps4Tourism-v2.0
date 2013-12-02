//
//  TourDetailViewController.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 07.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "POIDetailViewController.h"

@interface POIDetailViewController ()

@end

@implementation POIDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
	// Do any additional setup after loading the view.
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    self.poi = [self.dbManager getPOIbyName:self.poiName];
    self.tours = [self.dbManager getToursbyPOI:self.poi.name];
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
        self.navigationItem.rightBarButtonItem = newButton;
    
    self.view.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    self.title = self.poi.name;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.poi.imagePath]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    [self.view addSubview:self.imageView];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,40+ 40+(screenHeight/4), screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *wikiButton = [[UIBarButtonItem alloc] initWithTitle:@"Wikipedia" style: UIBarButtonItemStylePlain target:self action:@selector(wikiClicked:)];
    [barItems addObject:wikiButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Add to Favourites" style: UIBarButtonItemStylePlain target:self action:@selector(addToFavourites:)];
    [barItems addObject:saveButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];

    [pickerToolbar setItems:barItems animated:YES];
    [self.view addSubview:pickerToolbar];
    
    NSInteger tableHeight = (self.tours.count)*50;
    NSInteger textY = 40+80+(screenHeight/4);
    NSInteger textHeight = screenHeight-(textY+tableHeight+40);
    NSLog(@"Height %d", textHeight);
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, textY, screenWidth,textHeight)];
    self.textView.text = self.poi.description;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, textY+textHeight,screenWidth, screenHeight-(textY+textHeight+40)) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIToolbar *downToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight-40, screenWidth, 40)];
    downToolbar.barStyle = UIBarStyleDefault;
    [downToolbar sizeToFit];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    
    self.pois = [self.dbManager getAllPOIs];
    for (int i=0; i<self.pois.count; i++) {
        if ([[[self.pois objectAtIndex:i] name] isEqualToString:(self.poi.name)]) {
            self.indexOfPOI=i;
        }
    }
    if (self.indexOfPOI>0) {
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prev.png"] style:UIBarButtonItemStylePlain target:self action:@selector(prevClicked:)];
        [barItems2 addObject:prevButton];
    }
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    if (self.indexOfPOI < (self.pois.count-1)) {
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextClicked:)];
        [barItems2 addObject:nextButton];
    }
    
    [downToolbar setItems:barItems2 animated:YES];
    [self.view addSubview:downToolbar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tours count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [(Tour*)[self.tours objectAtIndex:indexPath.row] name];
    NSString *tourInfo = [NSString stringWithFormat:@"%.1f %@    %.1f %@", [(Tour*)[self.tours objectAtIndex:indexPath.row] totalHours], @"km", [(Tour*)[self.tours objectAtIndex:indexPath.row] totalKms], @"h" ];
    cell.detailTextLabel.text = tourInfo;
    [cell setIndentationWidth:64];
    [cell setIndentationLevel:1];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
    imgView.backgroundColor=[UIColor clearColor];
    [imgView.layer setMasksToBounds:YES];
    [imgView setImage:[UIImage imageNamed:[(Tour*)[self.tours objectAtIndex:indexPath.row] image]]];
    [cell.contentView addSubview:imgView];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TourDetailViewController *tourDetail = [[TourDetailViewController alloc] init];
    tourDetail.tourName = [(Tour*)[self.tours objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:tourDetail animated:YES];
}

- (IBAction)nextClicked:(id)sender{
    POIDetailViewController *poiDetail = [[POIDetailViewController alloc]init];
    poiDetail.poiName = [[self.pois objectAtIndex:self.indexOfPOI+1] name];
    [self.navigationController pushViewController:poiDetail animated:YES];
}

- (IBAction)prevClicked:(id)sender{
    POIDetailViewController *poiDetail = [[POIDetailViewController alloc]init];
    poiDetail.poiName = [[self.pois objectAtIndex:self.indexOfPOI-1] name];
    [self.navigationController pushViewController:poiDetail animated:YES];
}

- (IBAction)addToFavourites:(id)sender{
    Favourite *newFavourite = [[Favourite alloc] init];
    newFavourite.name = self.poi.name;
    [self.dbManager insertFavourite:newFavourite];
    
    NSString *alertTitle = [[NSString alloc] init];
    alertTitle = [NSString stringWithFormat:@"%@ %@", self.poi.name, @"was added to favourites!"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)mapClicked:(id)sender{
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.poiName = self.poiName;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (IBAction)wikiClicked:(id)sender{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.poi.url]];
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
