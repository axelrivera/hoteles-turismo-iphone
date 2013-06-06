//
//  FoursquareAPIClient.m
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "FoursquareAPIClient.h"

#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Venue.h"

#define kFoursquareClientURLHost @"https://api.foursquare.com/v2/"

#define kFoursquareClientID @"ONQJMGM3T0SRIUWORPN4NWP1TVQHZAXJ1DB4Q0QB1MWZ0I0K"
#define kFoursquareClientSecret @"ECM3BG41H2H4DCKTKHCJ5ELDWMGL5JVMWN2UWKNMDFIYWB0M"

@interface FoursquareAPIClient ()

- (NSMutableDictionary *)foursquareAuthDictionary;

@end

@implementation FoursquareAPIClient

- (id)initWithBaseURL:(NSURL *)URL
{
    self = [super initWithBaseURL:URL];
    if (self) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    }
    return self;
}

#pragma mark - Public Methods

- (void)exploreVenuesWithOptions:(NSDictionary *)options success:(FetchVenuesBlock)success failure:(FailureBlock)failure
{
    NSMutableDictionary *parameters = [self foursquareAuthDictionary];
    [parameters addEntriesFromDictionary:options];
    
    NSString *action = @"venues/explore";
    
    DLog(@"Exploring Venues with Action: %@", action);
    DLog(@"Parameters: %@", parameters);
    
    [self getPath:action parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Got Venues Response: %@", responseObject);
        
        NSArray *groups = responseObject[@"response"][@"groups"];
        
        NSDictionary *center = responseObject[@"response"][@"geocode"][@"center"];
        
        NSNumber *latitude = [NSNumber numberWithDouble:[center[@"lat"] doubleValue]];
        NSNumber *longitude = [NSNumber numberWithDouble:[center[@"lng"] doubleValue]];
        
        NSMutableArray *venues = [@[] mutableCopy];
        for (NSDictionary *group in groups) {
            NSArray *items = group[@"items"];
            for (NSDictionary *item in items) {
                NSDictionary *dictionary = item[@"venue"];
                if (dictionary) {
                    Venue *venue = [[Venue alloc] initWithDictionary:dictionary];
                    [venues addObject:venue];
                }
            }
        }
        
        if (success) {
            success(venues, latitude, longitude);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Got Venues Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark Private Methods

- (NSMutableDictionary *)foursquareAuthDictionary
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYYddMM";
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return [ @{ @"client_id" : kFoursquareClientID,
            @"client_secret" : kFoursquareClientSecret,
            @"v" : dateString } mutableCopy];
}

#pragma mark - Singleton Methods

+ (FoursquareAPIClient *)sharedClient
{
    static FoursquareAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"Init Foursquare API Client: %@", kFoursquareClientURLHost);
        NSURL *URL = [NSURL URLWithString:kFoursquareClientURLHost];
        sharedClient = [[FoursquareAPIClient alloc] initWithBaseURL:URL];
    });
    return sharedClient;
}


@end
