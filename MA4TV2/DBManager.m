//
//  dbManager.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 27.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

- (void)populateDatabase{
    
    //Tour Categories
    TourCategory *tourCategory = [[TourCategory alloc] init];
    
    tourCategory.name = @"Lisbon Tours";
    tourCategory.image = @"lisbon_tours.jpg";
    [self insertTourCategory: tourCategory];
    
    tourCategory.name = @"Sintra Tours";
    tourCategory.image = @"sintra_tours.jpg";
    [self insertTourCategory: tourCategory];
    //Tours
    Tour *tour = [[Tour alloc]init];
    
    tour.name = @"Lisbon Highlights Tour";
    tour.description = @"Lisbon Highlights Tour, Compact, cosmopolitan and across the 7 hills, Lisbon is very much a walker's city.";
    tour.image = @"lisbon_highlights.jpg";
    tour.category = @"Lisbon Tours";
    tour.totalHours = 4.0;
    tour.totalKms = 3.6;
    [self insertTour:tour];
    
    tour.name = @"Sintra Palaces Tours";
    tour.description = @"Some description";
    tour.image = @"sintra_palaces.jpg";
    tour.category = @"Sintra Tours";
    tour.totalHours = 5.0;
    tour.totalKms = 6.0;
    [self insertTour:tour];
    
    tour.name = @"Lisbon Belém Tour";
    tour.description = @"Lisbon BelÈm Tour, Stretched out across the river bank just 15 minutes west of the centre, BelÈm reflects all the grandeur and heroism of the Age of Discovery.";
    tour.image = @"lisbon_belem.jpg";
    tour.category = @"Lisbon Tours";
    tour.totalHours = 4.0;
    tour.totalKms = 5.7;
    [self insertTour:tour];
    
    //POI Categories
    POICategory *poiCategory = [[POICategory alloc] init];
    
    poiCategory.name = @"Food and Drinks";
    poiCategory.image = @"food.gif";
    [self insertPOICategory:poiCategory];
    
    poiCategory.name = @"Attractions";
    poiCategory.image = @"attraction.png";
    [self insertPOICategory:poiCategory];
    
    poiCategory.name = @"Hotels";
    poiCategory.image = @"hotel.jpg";
    [self insertPOICategory:poiCategory];
    
    //POIs
    POI *poi = [[POI alloc] init];
    
    poi.name = @"Castle of Sao Jorge";
    poi.description = @"Description";
    poi.imagePath = @"sao_jorge.jpg";
    poi.latitude = 38.714364;
    poi.longitude = -9.133526;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/Castle_of_S%C3%A3o_Jorge";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    poi.name = @"SÈ de Lisboa (Cathedral)";
    poi.description = @"Description";
    poi.imagePath = @"se.jpg";
    poi.latitude = 38.710328;
    poi.longitude = -9.132603;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/S%C3%A9_de_Lisboa";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    poi.name = @"Rossio (Pedro IV Square)";
    poi.description = @"Description";
    poi.imagePath = @"rossio.jpg";
    poi.latitude = 38.71423;
    poi.longitude = -9.138955;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/Rossio";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    poi.name = @"CalÁada da GlÛria (Funicular)";
    poi.description = @"Description";
    poi.imagePath = @"gloria.jpg";
    poi.latitude = 38.715552;
    poi.longitude = -9.143482;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/Elevador_da_Gl%C3%B3ria";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    poi.name = @"Instituto Superior TÈcnico (IST)";
    poi.description = @"Instituto Superior TÈcnico (IST) is a school of engineering, part of the Universidade de Lisboa (University of Lisbon). Founded in 1911, IST is the largest and the most prestigious school of engineering in Portugal. It is a public school with a large degree of scientific and financial autonomy.";
    poi.imagePath = @"ist.jpg";
    poi.latitude = 38.737616;
    poi.longitude = -9.139387;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/Instituto_Superior_T%C3%A9cnico";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    poi.name = @"Bairro Alto";
    poi.description = @"Bairro Alto is a central district of the city of Lisbon, the Portuguese capital. Unlike many of the civil parishes of Lisbon, this region can be commonly explained as a loose association of neighbourhoods, with no formal local political authority but social and historical significance to the urban community of Lisbon.";
    poi.imagePath = @"barrio.jpg";
    poi.latitude = 38.711433;
    poi.longitude = -9.150631;
    poi.rating = 5.0;
    poi.url = @"http://en.wikipedia.org/wiki/Bairro_Alto";
    poi.category = @"Attractions";
    [self insertPOI:poi];
    
    //Geo Points
    GeoPointTour *geoPoint = [[GeoPointTour alloc] init];
    
    geoPoint.position = 1;
    geoPoint.tour = @"Lisbon Highlights Tour";
    geoPoint.poi = @"Castle of Sao Jorge";
    [self insertGeoPointTour:geoPoint];
    
    geoPoint.position = 2;
    geoPoint.tour = @"Lisbon Highlights Tour";
    geoPoint.poi = @"SÈ de Lisboa (Cathedral)";
    [self insertGeoPointTour:geoPoint];
    
    geoPoint.position = 3;
    geoPoint.tour = @"Lisbon Highlights Tour";
    geoPoint.poi = @"Rossio (Pedro IV Square)";
    [self insertGeoPointTour:geoPoint];
    
    geoPoint.position = 4;
    geoPoint.tour = @"Lisbon Highlights Tour";
    geoPoint.poi = @"CalÁada da GlÛria (Funicular)";
    [self insertGeoPointTour:geoPoint];
}

- (void)initDatabase{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    _databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: _databasePath ] == NO){
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
            sql_stmt = "CREATE TABLE IF NOT EXISTS FAVOURITES (NAME TEXT PRIMARY KEY, IMAGE TEXT)";
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
            sql_stmt = "CREATE TABLE IF NOT EXISTS GEOPOINTTOURS (POSITION INTEGER,POI TEXT,TOUR TEXT, FOREIGN KEY(POI) REFERENCES POIS(NAME), FOREIGN KEY(TOUR) REFERENCES TOURS(NAME))";
            if (sqlite3_exec(_TOURISMDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                //_status.text = @"Failed to create table";
            }
            sqlite3_close(_TOURISMDB);
        } else {
        //_status.text = @"Failed to open/create database";
        }
        [self populateDatabase];
        NSLog(@"Database created! Path: %@",_databasePath);
        
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
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO TOURS (name, description, image, totalhours, totalkms, tourcategory) VALUES (\"%@\", \"%@\", \"%@\", \"%f\", \"%f\", \"%@\")", tour.name, tour.description, tour.image, tour.totalHours, tour.totalKms,tour.category];
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
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO POIS (name, description, image, url, latitude, longitude, rating) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%f\", \"%f\", \"%f\")", poi.name, poi.description, poi.imagePath, poi.url, poi.latitude, poi.longitude, poi.rating];
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

- (void)insertFavourite:(Favourite *)favourite{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT OR IGNORE INTO FAVOURITES (name,image) VALUES (\"%@\", \"%@\")", favourite.name, favourite.imagePath];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Favourite inserted");
        }else{
            //NSLog(@"%s",sqlite3_errmsg(_TOURISMDB));
        }
        sqlite3_reset(statement);
        sqlite3_finalize(statement);
        sqlite3_close(_TOURISMDB);
    }
}

- (void)deleteFavourite:(Favourite *)favourite{
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM FAVOURITES WHERE (name) = (\"%@\")", favourite.name];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_TOURISMDB, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            NSLog(@"Favourite deleted");
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
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO GEOPOINTTOURS (position, poi, tour) VALUES (\"%d\", \"%@\", \"%@\")", geoPointTour.position, geoPointTour.poi, geoPointTour.tour];
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

- (NSMutableArray*)getAllPOIs{
    NSMutableArray *POIs =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM POIS"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                POI *newPOI = [[POI alloc]init];
                newPOI.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newPOI.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newPOI.imagePath = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newPOI.url = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                newPOI.latitude = sqlite3_column_double(statement, 4);
                newPOI.longitude = sqlite3_column_double(statement, 5);
                newPOI.rating = sqlite3_column_double(statement, 6);
                [POIs addObject:newPOI];
                NSLog(@"POI added to array");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return POIs;
}

- (NSMutableArray*)getAllTours{
    NSMutableArray *Tours =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM TOURS"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Tour *newTour = [[Tour alloc]init];
                newTour.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newTour.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newTour.image = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newTour.totalHours = sqlite3_column_double(statement, 3);
                newTour.totalKms = sqlite3_column_double(statement, 4);
                [Tours addObject:newTour];
                NSLog(@"Tour added to array");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return Tours;
}

- (NSMutableArray*)getAllFavourites{
    NSMutableArray *favourites =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM FAVOURITES"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Favourite *newFavourite = [[Favourite alloc]init];
                newFavourite.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newFavourite.imagePath = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                [favourites addObject:newFavourite];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return favourites;
}

- (NSMutableArray*)getAllTourCategories{
    NSMutableArray *tourCategories =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM TOURCATEGORIES"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                TourCategory *newTourCategory = [[TourCategory alloc]init];
                newTourCategory.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newTourCategory.image = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                [tourCategories addObject:newTourCategory];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return tourCategories;
}

- (NSMutableArray*)getAllPOICategories{
    NSMutableArray *POICategories =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM CATEGORIES"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                POICategory *newPOICategory = [[POICategory alloc]init];
                newPOICategory.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newPOICategory.image = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [POICategories addObject:newPOICategory];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return POICategories;
}

- (POI*)getPOIbyName:(NSString *)poiName{
    POI *newPOI = [[POI alloc]init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM POIS WHERE name=\"%@\" ", poiName];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                newPOI.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newPOI.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newPOI.imagePath = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newPOI.url = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                newPOI.latitude = sqlite3_column_double(statement, 4);
                newPOI.longitude = sqlite3_column_double(statement, 5);
                newPOI.rating = sqlite3_column_double(statement, 6);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return newPOI;
}

- (NSMutableArray*)getToursbyTourCategory:(NSString *)tourCategory{
    NSMutableArray *toursByCategoryName = [[NSMutableArray alloc]init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM TOURS WHERE TOURCATEGORY=\"%@\"", tourCategory];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                Tour *newTour = [[Tour alloc] init];
                newTour.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newTour.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newTour.image = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newTour.totalHours = sqlite3_column_double(statement, 3);
                newTour.totalKms = sqlite3_column_double(statement, 4);
                newTour.category = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                [toursByCategoryName addObject:newTour];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return toursByCategoryName;
}

- (NSMutableArray*)getPOIsbyTourName:(NSString *) tourName{
    NSMutableArray *POIs =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"select gp.position,p.name, p.description, p.image, p.latitude, p.longitude from Tours as t inner join geopointtours as gp on gp.tour=t.name inner join pois as p on p.name=gp.poi where t.name =  \"%@\"", tourName];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                POI *newPOI = [[POI alloc]init];
                newPOI.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newPOI.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newPOI.imagePath = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                newPOI.latitude = sqlite3_column_double(statement, 4);
                newPOI.longitude = sqlite3_column_double(statement, 5);
                [POIs addObject:newPOI];
                NSLog(@"Tour added to array");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return POIs;
}

- (NSMutableArray*)seachPOIs:(NSString *)searchText :(NSString *)categoryName{
    NSMutableArray *POIs =[[NSMutableArray alloc] init];
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_TOURISMDB) == SQLITE_OK){
        NSString *querySQL;
        if (categoryName == NULL) {
            querySQL = [NSString stringWithFormat:@"select * from POIS where name like \"%%%@%%\" or description like \"%%%@%%\"", searchText, searchText];
        }else{
            querySQL = [NSString stringWithFormat:@"select * from POIS where name like \"%%%@%%\" or description like \"%%%@%%\" and category= \"%@\"", searchText, searchText, categoryName];
        }
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_TOURISMDB,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement) == SQLITE_ROW){
                POI *newPOI = [[POI alloc]init];
                newPOI.name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                newPOI.description = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                newPOI.imagePath = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                newPOI.latitude = sqlite3_column_double(statement, 3);
                newPOI.longitude = sqlite3_column_double(statement, 4);
                [POIs addObject:newPOI];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_TOURISMDB);
    }
    return POIs;
}


@end
