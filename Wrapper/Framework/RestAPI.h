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
-(void)validUsername:(NSString *)username andPassword:(NSString *)password onSuccess:(Success)success onFailure:(FailureBlock)failure;
-(void)getAllReposForUser:(NSString *)username withReposPerPage:(NSInteger)reposPerPage onSuccess:(GetAllReposForUserSuccessBlock)success onFailure:(FailureBlock)failure;

@end
