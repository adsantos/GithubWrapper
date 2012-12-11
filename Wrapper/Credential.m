//
//  Credential.m
//  Wrapper
//
//  Created by Adriana Santos on 10/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "Credential.h"

@implementation Credential
@synthesize username = _username;
@synthesize password = _password;

-(Credential *)initWithUsername:(NSString *)username andPassword:(NSString *)password {
    if (self = [self init]) {
        self.username = username;
        self.password = password;
    }
    return self;
}

@end
