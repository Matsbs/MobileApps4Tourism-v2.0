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
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
        self.navigationItem.rightBarButtonItem = newButton;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    
    self.poi = [[POI alloc] init];
    self.poi = [dbManager getPOIbyName:self.poiName];
    NSLog(@"Name: %@", self.poi.name);
    
    self.view.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    self.title = self.poi.name;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.poi.image]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    [self.view addSubview:self.imageView];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,40+ 40+(screenHeight/4), screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    //pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *wikiButton = [[UIBarButtonItem alloc] initWithTitle:@"Wikipedia" style: UIBarButtonItemStylePlain target:self action:@selector(wikiClicked:)];
    [barItems addObject:wikiButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Add to Favourites" style: UIBarButtonItemStylePlain target:self action:nil];
    [barItems addObject:saveButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];

    [pickerToolbar setItems:barItems animated:YES];
    [self.view addSubview:pickerToolbar];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40+80+(screenHeight/4), screenWidth, screenHeight/2)];
    self.textView.text = self.poi.description;
    [self.view addSubview:self.textView];
    
    UIToolbar *downToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight-40, screenWidth, 40)];
    downToolbar.barStyle = UIBarStyleDefault;
    [downToolbar sizeToFit];
    //pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prev.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    [barItems2 addObject:prevButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    [barItems2 addObject:nextButton];

    [downToolbar setItems:barItems2 animated:YES];
    [self.view addSubview:downToolbar];
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
