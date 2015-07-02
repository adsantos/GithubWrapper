//
//  RestHTTPClient.m
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RestHTTPClient.h"
#import "RestDefines.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@implementation RestHTTPClient
@synthesize isReachable = _isReachable;
@synthesize credential = _credential;

+(RestHTTPClient *)sharedInstance {
    static RestHTTPClient *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
        
        //AFNetworking will call the block with the status whenever the network connection changes
        [sharedInstance setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
                [sharedInstance setIsReachable:FALSE];
            }
            else {
                [sharedInstance setIsReachable:TRUE];
            }
        }];

        [sharedInstance setIsReachable:TRUE];
    });
    return sharedInstance;
}

-(id)mutableCopyWithZone:(NSZone *)_zone {
    RestHTTPClient *client = [[RestHTTPClient allocWithZone: _zone] init];
    client = [client initWithBaseURL:[self baseURL]];
    [client setIsReachable:[self isReachable]];
    [client setCredential:[self credential]];
    
    return client;
}

-(void)setCredential:(Credential *)credential {
    _credential = credential;
    [self setAuthorizationHeaderWithUsername:self.credential.username password:self.credential.password];
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self == FALSE) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setParameterEncoding:AFJSONParameterEncoding];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
//    [self setAuthorizationHeaderWithUsername:self.credential.username password:self.credential.password];
    return self;
}

@end
