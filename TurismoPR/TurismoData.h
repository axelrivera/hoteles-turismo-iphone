//
//  TurismoData.h
//  TurismoPR
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TurismoData : NSObject

@property (strong, nonatomic) NSArray *hotels;
@property (strong, nonatomic) NSArray *venues;

- (void)reloadHotelsWithCompletion:(CompletionBlock)completion;

+ (TurismoData *)sharedData;

@end
