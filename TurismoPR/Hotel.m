//
//  Hotel.m
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "Hotel.h"

#import <CoreLocation/CoreLocation.h>

@implementation Hotel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = [dictionary[@"name"] copy];
        _rooms = [[dictionary[@"rooms"] stringValue] copy];
        _city = [dictionary[@"city"] copy];
        _zone = [dictionary[@"zone"] copy];
        _region = [dictionary[@"region"] copy];
        _URLString = [dictionary[@"url"] copy];
        _category = [dictionary[@"category"] copy];
        
        NSDictionary *coordinateDictionary = dictionary[@"coordinate"];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([coordinateDictionary[@"latitude"] floatValue],
                                                                       [coordinateDictionary[@"longitude"] floatValue]);
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)locationString
{
    NSNumber *latitude = [NSNumber numberWithFloat:self.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithFloat:self.coordinate.longitude];
    
    NSString *str = [NSString stringWithFormat:@"%@,%@", [latitude stringValue], [longitude stringValue]];
    return str;
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
