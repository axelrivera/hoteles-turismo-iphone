//
//  TurismoAPIClient.h
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "AFHTTPClient.h"

@interface TurismoAPIClient : AFHTTPClient

- (void)fetchHotelsWithSuccess:(FetchHotelsBlock)success failure:(FailureBlock)failure;

+ (TurismoAPIClient *)sharedClient;

@end
