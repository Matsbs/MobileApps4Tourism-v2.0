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
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
    self.navigationItem.rightBarButtonItem = newButton;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.view.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    self.tour = [dbManager getToursByName:self.tourName];
    self.title = self.tour.name;
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.tour.image]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    [self.view addSubview:self.imageView];
    
    UILabel *totalKM = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/5,40+10+40+(screenHeight/4), screenWidth, 25)];
    totalKM.text = [NSString stringWithFormat:@"%d %@ %.1f %@ %.f %@", 3, @"stops, ", self.tour.totalKms, @"km, ", self.tour.totalHours, @"hours"];
    [self.view addSubview:totalKM];
    
    
//    UILabel *totalH = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 +20,40+10+ 40+(screenHeight/4), screenWidth/3, 25)];
//    totalH.text = [NSString stringWithFormat:@"%@ %.1f %@", @"Duration:", self.tour.totalKms, @"hours"];
//    [self.view addSubview:totalH];
//    
//    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 40+(screenHeight/4), screenWidth, 40)];
//    pickerToolbar.barStyle = UIBarStyleDefault;
//    [pickerToolbar sizeToFit];
//    //pickerToolbar.backgroundColor = [UIColor clearColor];
//    NSMutableArray *barItems = [[NSMutableArray alloc] init];
//    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [barItems addObject:flexSpace];
//    
//    UILabel *totalKM = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    totalKM.text = @"Total KM: 5";
//    [barItems addObject:totalKM];
//    
//    UIBarButtonItem *wikiButton = [[UIBarButtonItem alloc] initWithTitle:@"Wiki" style: UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
//    [barItems addObject:wikiButton];
//    
//    
//    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [barItems addObject:flexSpace];
//    
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
//    [barItems addObject:saveButton];
//    
//    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [barItems addObject:flexSpace];
//    
//    //    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    //    [barItems addObject:flexSpace];
//    
//    [pickerToolbar setItems:barItems animated:YES];
//    [self.view addSubview:pickerToolbar];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40+80+(screenHeight/4), screenWidth, screenHeight/8)];
    self.textView.text = @"This is the description.";
    [self.view addSubview:self.textView];
    
    self.POIs = [[NSMutableArray alloc] initWithArray:[dbManager getPOIsbyTourName:self.tour.name]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40+80+(screenHeight/4)+(screenHeight/8),screenWidth, screenHeight-(40+40+80+(screenHeight/4)+(screenHeight/8))) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIToolbar *downToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight-40, screenWidth, 40)];
    //pickerToolbar.barStyle = UIBarStyleDefault;
    //[pickerToolbar sizeToFit];
    //pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"<" style: UIBarButtonItemStylePlain target:self action:nil];
    [barItems2 addObject:prevButton];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:nil];
    [barItems2 addObject:nextButton];
    
    [downToolbar setItems:barItems2 animated:YES];
    [self.view addSubview:downToolbar];
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
