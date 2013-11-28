//
//  TourViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourDetailViewController.h"
#import "dbManager.h"

@interface TourViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tours;
@property (nonatomic, retain) NSString *tourCategory;


@end
