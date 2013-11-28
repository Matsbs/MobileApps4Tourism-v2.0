//
//  Tour.h
//  MA4TV2
//
//  Created by Mats Sandvoll on 18.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tour : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *category;
@property double totalHours;
@property double totalKms;

@end
