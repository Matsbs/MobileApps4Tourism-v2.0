//
//  dbManager.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 27.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POIViewController.h"
#import "FavouritesViewController.h"
#import "TourViewController.h"
#import <sqlite3.h>
#import "TourCategory.h"
#import "POICategory.h"
#import "Tour.h"
#import "POI.h"
#import "Favorite.h"
#import "GeoPointTour.h"

@interface DBManager : NSObject

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *TOURISMDB;

- (void)populateDatabase;
- (void)initDatabase;
- (void)insertTourCategory:(TourCategory *)tourCategory;
- (void)insertTour:(Tour *)tour;
- (void)insertPOICategory:(POICategory *)poiCategory;
- (void)insertPOI:(POI *)poi;
- (void)insertFavourite:(Favorite *)favorite;
- (void)insertGeoPointTour:(GeoPointTour *)geoPointTour;
- (NSMutableArray*)getAllPOIs;
- (NSMutableArray*)getAllTours;
- (NSMutableArray*)getAllTourCategories;
- (NSMutableArray*)getAllPOICategories;
- (POI*)getPOIbyName:(NSString *)poiName;
- (NSMutableArray*)getPOIsbyTourName:(NSString *) tourName;
- (NSMutableArray*)seachPOIs:(NSString *)searchText :(NSString *)categoryName;
- (NSMutableArray*)getToursbyTourCategory:(NSString *)tourCategory;


@end
