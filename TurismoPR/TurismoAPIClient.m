//
//  TurismoAPIClient.m
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "TurismoAPIClient.h"

#import "AFJSONRequestOperation.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Hotel.h"

@implementation TurismoAPIClient

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

- (void)fetchHotelsWithSuccess:(FetchHotelsBlock)success failure:(FailureBlock)failure
{
    DLog(@"Fetching Hotels with URL Action: %@", kHotelsURLPath);
    [self getPath:kHotelsURLPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Got Hotels Response: %@", responseObject);
        
        NSArray *hotelsRaw = responseObject[@"hotels"];
        if (hotelsRaw == nil) {
            NSError *error = [NSError errorWithDomain:kErrorDomain code:kErrorCode userInfo:nil];
            if (failure) {
                failure(error);
            }
            return;
        }
        
        NSMutableArray *hotels = [@[] mutableCopy];
        for (NSDictionary *dictionary in hotelsRaw) {
            Hotel *hotel = [[Hotel alloc] initWithDictionary:dictionary];
            [hotels addObject:hotel];
        }
        
        if (success) {
            success(hotels);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error trying to fetch hotels: %@", error);
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - Singleton Methods

+ (TurismoAPIClient *)sharedClient
{
    static TurismoAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"Init Turismo API Client: %@", kTurismoClientURLHost);
        NSURL *URL = [NSURL URLWithString:kTurismoClientURLHost];
        sharedClient = [[TurismoAPIClient alloc] initWithBaseURL:URL];
    });
    return sharedClient;
}


@end
