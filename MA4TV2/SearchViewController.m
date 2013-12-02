//
//  SearchViewController.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 28.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,60,screenWidth,50)];
    self.title = self.category;
    self.searchBar.delegate = self;
    [self.view addSubview: self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, screenWidth, screenHeight-110)];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dbManager = [[DBManager alloc]init];
    [self.dbManager setDbPath];
    
    if (self.searchByCategory == YES) {
        self.searchResults = [self.dbManager seachPOIs:@"" :self.category];
    }else{
        self.searchResults = [self.dbManager seachPOIs:@"" :nil];
    }
}

-(void)hideKeyboard {
    [self.searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:self.tapGesture];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.view removeGestureRecognizer:self.tapGesture];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.searchByCategory == YES) {
         self.searchResults = [self.dbManager seachPOIs:searchText :self.category];
    }else{
        self.searchResults = [self.dbManager seachPOIs:searchText :nil];
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.searchResults objectAtIndex:indexPath.row]name];
    [cell setIndentationWidth:64];
    [cell setIndentationLevel:1];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
    imgView.backgroundColor=[UIColor clearColor];
    [imgView.layer setMasksToBounds:YES];
    [imgView setImage:[UIImage imageNamed:[[self.searchResults objectAtIndex:indexPath.row]imagePath]]];
    [cell.contentView addSubview:imgView];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    POIDetailViewController *poiDetail = [[POIDetailViewController alloc] init];
    poiDetail.poiName = [[self.searchResults objectAtIndex:indexPath.row] name];
    [self.navigationController pushViewController:poiDetail animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
