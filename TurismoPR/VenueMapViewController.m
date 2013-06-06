//
//  VenueMapViewController.m
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "VenueMapViewController.h"
#import "FoursquareAPIClient.h"
#import <CoreLocation/CoreLocation.h>

@interface VenueMapViewController ()

- (void)reloadVenues;

@end

@implementation VenueMapViewController

- (id)init
{
    self = [super initWithNibName:@"VenueMapViewController" bundle:nil];
    if (self) {
        _venues = @[];
    }
    return self;
}

- (id)initWithHotel:(Hotel *)hotel
{
    self = [self init];
    if (self) {
        _hotel = hotel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Venues";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(dismissAction:)];
    
    NSString *nearStr = [NSString stringWithFormat:@"%@, PR", self.hotel.city];
    NSDictionary *options = @{ @"near" : nearStr };
    
    DLog(@"Venue Options: %@", options);
    
    [[FoursquareAPIClient sharedClient] exploreVenuesWithOptions:options
                                                         success:^(NSArray *venues, NSNumber *latitude, NSNumber *longitude)
    {
        self.latitude = latitude;
        self.longitude = longitude;
        self.venues = venues;
        [self reloadVenues];
        
    }
                                                         failure:^(NSError *error)
    {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadVenues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadVenues
{
    DLog(@"Latitude: %@", self.latitude);
    DLog(@"Longitude: %@", self.longitude);
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 3000, 3000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    for (Venue *venue in self.venues) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = venue.coordinate;
        point.title = venue.title;
        point.subtitle = venue.subtitle;
        
        [self.mapView addAnnotation:point];
    }
    // Add an annotation
}

- (void)dismissAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
