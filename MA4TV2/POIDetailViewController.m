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
    
    self.view.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    
    self.title = @"POI Detail";
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5.png"]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4);
    [self.view addSubview:self.imageView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 40+(screenHeight/4), screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    //pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *wikiButton = [[UIBarButtonItem alloc] initWithTitle:@"Wiki" style: UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
    [barItems addObject:wikiButton];
    
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
    [barItems addObject:saveButton];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    //    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //    [barItems addObject:flexSpace];
    
    [pickerToolbar setItems:barItems animated:YES];
    [self.view addSubview:pickerToolbar];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80+(screenHeight/4), screenWidth, screenHeight/2)];
    self.textView.text = @"This is the description.";
    [self.view addSubview:self.textView];
    
    UIToolbar *downToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,screenHeight-40, screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    //pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"<" style: UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
    [barItems2 addObject:prevButton];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(resignPicker:)];
    [barItems2 addObject:nextButton];
   
    
    
    //    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //    [barItems addObject:flexSpace];
    
    [downToolbar setItems:barItems2 animated:YES];
    [self.view addSubview:downToolbar];
    
}

- (IBAction)mapClicked:(id)sender{
    MapViewController *mapView = [[MapViewController alloc] init];
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
