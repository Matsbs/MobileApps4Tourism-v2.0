//
//  POIViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 07.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POIDetailViewController.h"

@interface POIViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@end
