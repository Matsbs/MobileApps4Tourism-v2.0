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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,60,screenWidth,50)];
    self.title = @"Search";
    self.searchBar.delegate = self;
    [self.view addSubview: self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, screenWidth, screenHeight-110)];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    self.searchResults = [dbManager seachPOIs:@"" :nil];
    
}

-(void)hideKeyboard {
    [self.searchBar resignFirstResponder];
}
- (void)searchBarTextDidStartEditing:(UISearchBar *)searchBar{
    NSLog(@"startet entering");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"OLA!");
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    self.searchResults = [dbManager seachPOIs:searchText :nil];
    NSLog(@"Length %d", self.searchResults.count);
    [self.tableView reloadData];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"something");
    [self.searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
