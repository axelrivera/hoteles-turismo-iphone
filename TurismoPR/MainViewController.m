//
//  MainViewController.m
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "MainViewController.h"

#import "HotelMapViewController.h"
#import "HotelDetailViewController.h"
#import "Hotel.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self = [super initWithNibName:@"MainViewController" bundle:nil];
    if (self) {
        self.hotels = @[];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Hoteles";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:self
                                                                                          action:@selector(reloadAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Mapa"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(mapAction:)];
    [self reloadAction:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadAction:(id)sender
{
    [[TurismoData sharedData] reloadHotelsWithCompletion:^(BOOL succedded, NSError *error) {
        if (succedded) {
            self.hotels = [TurismoData sharedData].hotels;
            [self.tableView reloadData];
        }
    }];
}

- (void)mapAction:(id)sender
{
    HotelMapViewController *hotelController = [[HotelMapViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hotelController];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Hotel *hotel = self.hotels[indexPath.row];

    cell.textLabel.text = hotel.name;
    cell.detailTextLabel.text = hotel.city;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"I'm here!!!");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Hotel *hotel = self.hotels[indexPath.row];
    
    HotelDetailViewController *detailController = [[HotelDetailViewController alloc] initWithHotel:hotel];
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
