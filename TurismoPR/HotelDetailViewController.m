//
//  HotelDetailViewController.m
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "HotelDetailViewController.h"

#import "VenueMapViewController.h"

@interface HotelDetailViewController ()

@end

@implementation HotelDetailViewController

- (id)init
{
    self = [super initWithNibName:@"HotelDetailViewController" bundle:nil];
    if (self) {
        // Custom initialization
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
    self.title = @"Detalles";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Venues"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(venuesAction:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)venuesAction:(id)sender
{
    VenueMapViewController *venueController = [[VenueMapViewController alloc] initWithHotel:self.hotel];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:venueController];
    
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NameCellIdentifier = @"NameCell";
    static NSString *CellIdentifier = @"Cell";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NameCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NameCellIdentifier];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
            cell.textLabel.numberOfLines = 2.0;
        }
        
        cell.textLabel.text = self.hotel.name;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSString *textStr = nil;
    NSString *detailStr = nil;
    
    if (indexPath.row == 1) {
        textStr = @"Category";
        detailStr = self.hotel.category;
    } else if (indexPath.row == 2) {
        textStr = @"City";
        detailStr = self.hotel.city;
    } else if (indexPath.row == 3) {
        textStr = @"Region";
        detailStr = self.hotel.region;
    } else if (indexPath.row == 4) {
        textStr = @"Rooms";
        detailStr = self.hotel.rooms;
    }
    
    cell.textLabel.text = textStr;
    cell.detailTextLabel.text = detailStr;

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"I'm here!!!");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotelDetailViewController *detailController = [[HotelDetailViewController alloc] init];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60.0;
    }
    return 44.0;
}

@end
