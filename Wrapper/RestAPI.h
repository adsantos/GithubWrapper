//
//  RestAPI.h
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestDefines.h"
#import "Credential.h"

@interface RestAPI : NSObject
@property (nonatomic, strong) Credential *credential;

-(RestAPI *)initWithCredential:(Credential *)credential;
-(void)getAllReposForUser:(NSString *)username onSuccess:(GetAllReposForUserSuccessBlock)success onFailure:(FailureBlock)failure;

@end
