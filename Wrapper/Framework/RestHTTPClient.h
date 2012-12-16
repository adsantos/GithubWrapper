//
//  RestHTTPClient.h
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "RestDefines.h"
#import "Credential.h"

@interface RestHTTPClient : AFHTTPClient

@property (atomic) BOOL isReachable;
@property (nonatomic, strong) Credential *credential;

+(RestHTTPClient *)sharedInstance;
-(id)mutableCopyWithZone:(NSZone *)_zone;

@end
