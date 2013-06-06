//
//  FoursquareAPIClient.h
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "AFHTTPClient.h"

@interface FoursquareAPIClient : AFHTTPClient

- (void)exploreVenuesWithOptions:(NSDictionary *)options success:(FetchVenuesBlock)success failure:(FailureBlock)failure;

+ (FoursquareAPIClient *)sharedClient;

@end
