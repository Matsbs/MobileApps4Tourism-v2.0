//
//  MainViewController.m
//  MobileApps4Tourism
//
//  Created by Mats Sandvoll on 18.09.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager initDatabase];
    [self.dbManager getAllTours];
    self.tourCategories = [[NSMutableArray alloc] initWithArray:[self.dbManager getAllTourCategories]];
    self.poiCategories = [[NSMutableArray alloc] initWithArray:[self.dbManager getAllPOICategories]];

    self.title = @"Tourism Advisor";
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lisbon_wallpaper.jpg"]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,25+80+(screenHeight/4), screenWidth, screenHeight-(25+80+(screenHeight/4))) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,40+ 40+(screenHeight/4), screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
    [barItems addObject:mapButton];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
       [barItems addObject:flexSpace];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style: UIBarButtonItemStylePlain target:self action:@selector(searchClicked:)];
    [barItems addObject:searchButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *syncButton = [[UIBarButtonItem alloc] initWithTitle:@"Sync" style: UIBarButtonItemStylePlain target:self action:nil];
    [barItems addObject:syncButton];
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *favButton = [[UIBarButtonItem alloc] initWithTitle:@"Favourites" style: UIBarButtonItemStylePlain target:self action:@selector(favouritesClicked:)];
    [barItems addObject:favButton];
    [pickerToolbar setItems:barItems animated:YES];
    [self.view addSubview:pickerToolbar];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)favouritesClicked:(id)sender {
    FavouritesViewController *favView = [[FavouritesViewController alloc] init];
    [self.navigationController pushViewController:favView animated:YES];
}

- (IBAction)searchClicked:(id)sender{
    SearchViewController *searchView = [[SearchViewController alloc] init];
    searchView.category = @"Search";
    [self.navigationController pushViewController:searchView animated:YES];
}

- (IBAction)mapClicked:(id)sender {
    MapViewController *mapView = [[MapViewController alloc] init];
    mapView.showAll = YES;
    mapView.isTour = NO;
    [self.navigationController pushViewController:mapView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return [self.tourCategories count];
    }else{
        return [self.poiCategories count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 ) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [(TourCategory*)[self.tourCategories objectAtIndex:indexPath.row] name];
        [cell setIndentationWidth:64];
        [cell setIndentationLevel:1];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
        imgView.backgroundColor=[UIColor clearColor];
        [imgView.layer setMasksToBounds:YES];
        [imgView setImage:[UIImage imageNamed:[(TourCategory*)[self.tourCategories objectAtIndex:indexPath.row] image]]];
        [cell.contentView addSubview:imgView];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [(POICategory*)[self.poiCategories objectAtIndex:indexPath.row] name];
        [cell setIndentationWidth:64];
        [cell setIndentationLevel:1];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
        imgView.backgroundColor=[UIColor clearColor];
        [imgView.layer setMasksToBounds:YES];
        [imgView setImage:[UIImage imageNamed:[(POICategory*)[self.poiCategories objectAtIndex:indexPath.row] image]]];
        [cell.contentView addSubview:imgView];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        TourViewController *tourView = [[TourViewController alloc]init];
        tourView.tourCategory = [(TourCategory*)[self.tourCategories objectAtIndex:indexPath.row] name];
        [self.navigationController pushViewController:tourView animated:YES];
    }else{
        SearchViewController *seachView = [[SearchViewController alloc] init];
        seachView.category = [(POICategory*)[self.poiCategories objectAtIndex:indexPath.row] name];
        seachView.searchByCategory = YES;
        [self.navigationController pushViewController:seachView animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Tours";
    }else{
        return @"Categories";
    }
}

//Extra Functions

/*
//For custom table header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel = [[UILabel alloc]init];
    if (section==0) {
       headerLabel.text = @"Tours";
    }else{
        headerLabel.text = @"Categories";
    }


    headerLabel.textColor = [UIColor blackColor];
    //headerLabel.shadowColor = [UIColor blackColor];
    headerLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;

    return headerLabel;
}
*/

/*
//Reset memory using NSUserDefaults
- (void)resetMemory {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}*/

/*
//Load from memory using NSUserDefalts
- (void) loadFromMemory{
    for (int i=0; i<20; i++) {
        NSString *counter = [NSString stringWithFormat:@"%d",i];
        NSString *name = @"Task";
        NSString *task = [name stringByAppendingString:counter];
        NSString *key1 = [task stringByAppendingString:@"name"];
        self.task = [[Task alloc] init];
        self.task.name = [[NSUserDefaults standardUserDefaults] objectForKey:key1];
        NSString *key2 = [task stringByAppendingString:@"date"];
        self.task.date = [[NSUserDefaults standardUserDefaults] objectForKey:key2];
        NSString *key3 = [task stringByAppendingString:@"note"];
        self.task.note = [[NSUserDefaults standardUserDefaults] objectForKey:key3];
        if ([self.task.name length]!=0){
            [self.taskArray addObject:self.task];
            NSLog(@"Loaded from memory:%@",self.task.name);
        }
    }
}*/

/*
//Save to memory using NSUserDefaults
- (void) saveToMemory{
    [self resetMemory];
    for (int i=0; i<[self.taskArray count]; i++) {
        NSString *counter = [NSString stringWithFormat:@"%d",i];
        NSString *name = @"Task";
        NSString *task = [name stringByAppendingString:counter];
        NSString *key1 = [task stringByAppendingString:@"name"];
        Task *taskObject = [self.taskArray objectAtIndex:i];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.name forKey:key1];
        NSString *key2 = [task stringByAppendingString:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.date forKey:key2];
        NSString *key3 = [task stringByAppendingString:@"note"];
        [[NSUserDefaults standardUserDefaults] setObject:taskObject.note forKey:key3];
    }
    //Save in memory
    [[NSUserDefaults standardUserDefaults] synchronize];
    //Log all saved keys
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
}*/

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

@end
