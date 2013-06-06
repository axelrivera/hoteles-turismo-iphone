//
//  Hotel.h
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Hotel : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *rooms;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *zone;
@property (copy, nonatomic) NSString *region;
@property (copy, nonatomic) NSString *URLString;
@property (copy, nonatomic) NSString *category;
@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)locationString;

@end
