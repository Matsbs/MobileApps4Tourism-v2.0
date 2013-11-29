//
//  TourDetailViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "Tour.h"
#import "DBManager.h"

@interface TourDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) NSString *tourName;
@property (nonatomic, retain) NSMutableArray *POIs;
@property (nonatomic, retain) Tour *tour;

@end
