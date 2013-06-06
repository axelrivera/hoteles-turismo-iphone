//
//  HotelMapViewController.h
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView  *mapView;
@property (strong, nonatomic) NSArray *hotels;

- (id)initWithHotels:(NSArray *)hotels;

@end
