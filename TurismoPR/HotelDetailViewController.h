//
//  HotelDetailViewController.h
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelDetailViewController : UITableViewController

@property (strong, nonatomic) Hotel *hotel;

- (id)initWithHotel:(Hotel *)hotel;

@end
