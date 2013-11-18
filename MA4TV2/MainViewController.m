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
    
    [self initDatabase];
    [self populateDatabase];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.view.backgroundColor =  [UIColor whiteColor];
    self.title = @"Lisbon";
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.png"]];
    self.imageView.frame = CGRectMake(0, 40, screenWidth, screenHeight/4+40);
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.imageView];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,40+ 40+(screenHeight/4), screenWidth, 40)];
    pickerToolbar.barStyle = UIBarStyleDefault;
    [pickerToolbar sizeToFit];
    //pickerToolbar.tintColor = [UIColor groupTableViewBackgroundColor];
    //pickerToolbar.translucent = YES;
    pickerToolbar.backgroundColor = [UIColor clearColor];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style: UIBarButtonItemStylePlain target:self action:@selector(mapClicked:)];
    [barItems addObject:mapButton];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
       [barItems addObject:flexSpace];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style: UIBarButtonItemStylePlain target:self action:nil];
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
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,40+80+(screenHeight/4), screenWidth, screenHeight) style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 40;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 0.0;
    self.tableView.sectionFooterHeight = 0.0;
    [self.view addSubview:self.tableView];
    
//    select p.name, p.image, gt.position
//    from tours as t
//    inner join geopointtour as gt
//    on gt.tour = t.name
//    inner join POIS as p
//    on gt.poi = p.name
//    where t.name = ''
    
}

- (void)populateDatabase{
    TourCategory *tourCategory = [[TourCategory alloc] init];
    tourCategory.name = @"Lisbon Tours";
    tourCategory.image = @"lisbon_tours.jpeg";
    [self insertTourCategory: tourCategory];
    TourCategory *tourCategory2 = [[TourCategory alloc] init];
    tourCategory2.name = @"Sintra Tours";
    tourCategory2.image = @"sintra_tours.jpeg";
    [self insertTourCategory: tourCategory2];
    Tour *tour = [[Tour alloc]init];
    tour.name = @"Lisbon Tours";
    tour.description = @"Some desc";
    tour.totalHours = 2.5;
    tour.totalKms = 3.0;
    [self insertTour:tour];
    POICategory *poiCategory = [[POICategory alloc] init];
    poiCategory.name = @"Food and Drinks";
    poiCategory.image = @"image";
    [self insertPOICategory:poiCategory];
    POI *poi = [[POI alloc] init];
    poi.name = @"Sintra";
    poi.description = @"description of sintra";
    poi.image = @"some image";
    poi.latitude = 33.44;
    poi.longitude = 22.33;
    poi.rating = 5.0;
    [self insertPOI:poi];

}

- (void)initDatabase{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    //NSFileManager *filemgr = [NSFileManager defaultManager];
    //if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        char *errMsg;
        const char *sql_stmt ="CREATE TABLE IF NOT EXISTS TOURCATEGORIES (NAME TEXT PRIMARY KEY, IMAGE TEXT)";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sql_stmt = "CREATE TABLE IF NOT EXISTS CATEGORIES (NAME TEXT PRIMARY KEY, DESCRIPTION TEXT, IMAGE TEXT)";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sql_stmt = "CREATE TABLE IF NOT EXISTS FAVOURITES (NAME TEXT PRIMARY KEY)";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sql_stmt = "CREATE TABLE IF NOT EXISTS POIS (NAME TEXT PRIMARY KEY, DESCRIPTION TEXT, IMAGE TEXT, URL TEXT, LATITUDE DOUBLE, LONGITUDE DOUBLE, RATING DOUBLE, FAVOURITE TEXT, CATEGORY TEXT, FOREIGN KEY (FAVOURITE) REFERENCES FAVOURITES(NAME), FOREIGN KEY(CATEGORY) REFERENCES CATEGORIES(NAME))";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sql_stmt = "CREATE TABLE IF NOT EXISTS TOURS (NAME TEXT PRIMARY KEY, DESCRIPTION TEXT, IMAGE TEXT, TOTALHOURS DOUBLE, TOTALKMS DOUBLE, TOURCATEGORY TEXT, FOREIGN KEY(TOURCATEGORY) REFERENCES TOURCATEGORYS(NAME))";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sql_stmt = "CREATE TABLE IF NOT EXISTS GEOPOINTTOUR (LATITUDE DOUBLE, LONGITUDE DOUBLE, POSITION INTEGER,POI TEXT,TOUR TEXT, FOREIGN KEY(POI) REFERENCES POIS(NAME), FOREIGN KEY(TOUR) REFERENCES TOURS(NAME))";
        if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
            //_status.text = @"Failed to create table";
        }
        sqlite3_close(_TOURISMDB);
    } else {
        //_status.text = @"Failed to open/create database";
    }
}

- (void)insertTourCategory:(TourCategory *)tourCategory{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TOURCATEGORIES (name, image) VALUES (\"%@\", \"%@\")", tourCategory.name, tourCategory.image];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Tour category inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)insertTour:(Tour *)tour{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TOURS (name, description, image, totalhours, totalkms) VALUES (\"%@\", \"%@\", \"%@\", \"%f\", \"%f\")", tour.name, tour.description, tour.image, tour.totalHours, tour.totalKms];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Tour inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)insertPOICategory:(POICategory *)poiCategory{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CATEGORIES (name, image) VALUES (\"%@\", \"%@\")", poiCategory.name, poiCategory.image];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"POI category inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)insertPOI:(POI *)poi{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO POIS (name, description, image, url, latitude, longitude, rating) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%f\", \"%f\", \"%f\")", poi.name, poi.description, poi.image, poi.url, poi.latitude, poi.latitude, poi.rating];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"POI inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)insertFavourite:(Favorite *)favorite{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO FAVORITES (name) VALUES (\"%@\")", favorite.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Favorite inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)insertGeoPointTour:(GeoPointTour *)geoPointTour{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO GEOPOINTTOURS (latitude, longitude, position) VALUES (\"%f\", \"%f\", \"%d\")", geoPointTour.latitude, geoPointTour.longitude, geoPointTour.position];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Favorite inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

//- (void) findContact:(id)sender{
//    const char *dbpath = [_databasePath UTF8String];
//    sqlite3_stmt *statement;
//    if (sqlite3_open(dbpath, &_ma4tDB) == SQLITE_OK){
//        NSString *querySQL = [NSString stringWithFormat:
//                              @"SELECT address, phone FROM contacts WHERE name=\"%@\"",
//                              @"Name"];
//        const char *query_stmt = [querySQL UTF8String];
//        if (sqlite3_prepare_v2(_ma4tDB,
//                               query_stmt, -1, &statement, NULL) == SQLITE_OK){
//            if (sqlite3_step(statement) == SQLITE_ROW){
//                NSString *addressField = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
//                //_address.text = addressField;
//                NSString *phoneField = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
//                //_phone.text = phoneField;
//                //_status.text = @"Match found";
//            } else {
//                //_status.text = @"Match not found";
//                //_address.text = @"";
//                //_phone.text = @"";
//            }
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(_ma4tDB);
//    }
//}

//- (void)addItemViewController:(NewTaskViewController *)controller didFinishEnteringItem:(Task *)item
//{
//    NSLog(@"This was returned from ViewControllerB %@",item.category.name);
//    [self.taskArray addObject:item];
//    [self.tableView reloadData];
//}
//
//- (void)removeItemViewController:(ViewNoteController *)controller didFinishEnteringItem:(Task *)item{
//    if([self.taskArray containsObject:item]){
//        [self.taskArray removeObject:item];
//    }
//    [self.tableView reloadData];
//}

- (IBAction)favouritesClicked:(id)sender {
    FavouritesViewController *favView = [[FavouritesViewController alloc] init];
    [self.navigationController pushViewController:favView animated:YES];
}

- (IBAction)mapClicked:(id)sender {
    MapViewController *mapView = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapView animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0){
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0 ) {
//        self.task= [self.taskArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"Tour1";
        cell.imageView.image = [UIImage imageNamed:@"5.png"];
    } else {
        cell.textLabel.text = @"Category1";
        cell.imageView.image = [UIImage imageNamed:@"1.png"];
        //cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        TourViewController *tourView = [[TourViewController alloc]init];
        [self.navigationController pushViewController:tourView animated:YES];
    }else{
        POIViewController *poiView = [[POIViewController alloc] init];
        [self.navigationController pushViewController:poiView animated:YES];
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
