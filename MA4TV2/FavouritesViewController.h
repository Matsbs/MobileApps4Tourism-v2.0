//
//  FavouritesViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POI.h"
#import "DBManager.h"

@interface FavouritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *favourites;
//@property (nonatomic, retain) DBManager *dbManager;

@end
