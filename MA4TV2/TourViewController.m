//
//  TourViewController.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "TourViewController.h"

@interface TourViewController ()

@end

@implementation TourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DBManager *dbManager = [[DBManager alloc]init];
    //[dbManager initDatabase];
    //[dbManager populateDatabase];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    
    self.tours = [[NSMutableArray alloc] initWithArray:[dbManager getToursbyTourCategory:self.tourCategory]];
    NSLog(@"size: %lu", (unsigned long)[self.tours count]);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.title = self.tourCategory;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
