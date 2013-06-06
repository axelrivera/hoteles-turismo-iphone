//
//  Venue.m
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = [dictionary[@"name"] copy];
        
        NSDictionary *location = dictionary[@"location"];
        
        _address = [location[@"address"] copy];
        _city = [location[@"city"] copy];
        _state = [location[@"state"] copy];
        _postalCode = [location[@"postalCode"] copy];
        _country = [location[@"country"] copy];
        _coordinate = CLLocationCoordinate2DMake([location[@"lat"] floatValue], [location[@"lng"] floatValue]);
    }
    return self;
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.city;
}

- (NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"Name: %@, City: %@, Latitude: %f, Longitude: %f",
                        self.name, self.city, self.coordinate.latitude, self.coordinate.longitude];
    return string;
}

@end
