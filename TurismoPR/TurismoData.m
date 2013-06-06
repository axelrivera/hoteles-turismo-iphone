//
//  TurismoData.m
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "TurismoData.h"

#import "TurismoAPIClient.h"
#import "FoursquareAPIClient.h"

@implementation TurismoData

- (id)init
{
    self = [super init];
    if (self) {
        self.hotels = @[];
    }
    return self;
}

- (void)reloadHotelsWithCompletion:(CompletionBlock)completion
{
    [[TurismoAPIClient sharedClient] fetchHotelsWithSuccess:^(NSArray *hotels) {
        self.hotels = hotels;
        completion(YES, nil);
    } failure:^(NSError *error) {
        completion(NO, error);
    }];
}

#pragma mark - Singleton Methods

+ (TurismoData *)sharedData
{
    static TurismoData *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[TurismoData alloc] init];
    });
    return sharedData;
}

@end
