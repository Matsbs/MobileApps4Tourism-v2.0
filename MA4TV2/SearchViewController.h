//
//  SearchViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 28.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *searchResults;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;
@property bool searchByCategory;

@end
