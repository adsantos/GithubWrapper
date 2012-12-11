//
//  RestDefines.h
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

extern NSString * const BASE_URL_STRING;
extern NSString * const ERROR_DOMAIN;
extern NSString * const searchReposForUser;

typedef enum {
    EMPTY_INPUT,
    INVALID_PER_PAGE_INPUT
} REST_ERRORS;

@interface RestDefines : NSObject

typedef void (^RestHTTPClientSuccessBlock)(AFHTTPRequestOperation *operation, id response);
typedef void (^GetAllReposForUserSuccessBlock)(AFHTTPRequestOperation *operation, id response, BOOL isFinished);
typedef void (^FailureBlock)(NSError *);

@end
