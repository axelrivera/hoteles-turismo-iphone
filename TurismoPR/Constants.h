//
//  Constants.h
//  Turismo
//
//  Created by Axel Rivera on 6/6/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

typedef void (^CompletionBlock)(BOOL succedded, NSError *error);
typedef void (^FailureBlock)(NSError *error);
typedef void (^ObjectsBlock)(NSArray *objects);

typedef void (^FetchHotelsBlock)(NSArray *hotels);
typedef void (^FetchVenuesBlock)(NSArray *venues, NSNumber *latitude, NSNumber *longitude);

#define kTurismoClientURLHost @"http://hoteles-turismo.herokuapp.com/"

#define kErrorDomain @"com.riveralabs.error"
#define kErrorCode 0

// Hotel URLs

#define kHotelsURLPath @"hotels.json"
#define kTouristZonesURLPath @"tourist-zones.json"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || thing == [NSNull null]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}