//
//  TourDetailViewController.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 07.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface POIDetailViewController : UIViewController

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
