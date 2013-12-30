//
//  TourDetailViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 07.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import <sqlite3.h>
#import "MapViewController.h"
#import "POI.h"
#import "Favourite.h"
@class DBManager;

@interface POIDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) NSString *poiName;
@property (nonatomic, retain) POI *poi;
@property (nonatomic, retain) NSMutableArray *pois;
@property NSInteger indexOfPOI;
@property (nonatomic, retain) DBManager *dbManager;
@property (nonatomic, retain) NSMutableArray *tours;

@end
