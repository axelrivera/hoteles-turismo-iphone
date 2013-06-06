//
//  HotelMapViewController.m
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "HotelMapViewController.h"

@interface HotelMapViewController ()

- (void)reloadHotels;

@end

@implementation HotelMapViewController

- (id)init
{
    self = [super initWithNibName:@"HotelMapViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHotels:(NSArray *)hotels
{
    self = [self init];
    if (self) {
        _hotels = hotels;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mapa Hoteles";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hoteles"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(dismissAction:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadHotels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadHotels
{
    
}

- (void)dismissAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
