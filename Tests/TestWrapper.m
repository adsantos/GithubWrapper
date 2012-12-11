//
//  TestWrapper.m
//  Wrapper
//
//  Created by Adriana Santos on 10/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "RestAPI.h"
#import "RestDefines.h"

@interface TestWrapper : GHAsyncTestCase { }
    @property (nonatomic, strong) RestAPI *api;
@end

@implementation TestWrapper
@synthesize api = _api;

// Run at start of all tests in the class
- (void)setUp {
    Credential *credential = [[Credential alloc] initWithUsername:@"github-objc" andPassword:@"passw0rd"];
    self.api = [[RestAPI alloc] initWithCredential:credential];
}

-(void)testGetAllReposForUser {
    
    __block int errorCode = -1;
    [self prepare];
    [self.api getAllReposForUser:@"github-objc" withReposPerPage:1 onSuccess:^(AFHTTPRequestOperation *operation, id response, BOOL isFinished) {
        if (isFinished) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUser)];
        }
     
    } onFailure:^(NSError *error) {
        errorCode = error.code;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUser)];
        
    }];
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:60.0];
    GHAssertTrue(errorCode == -1, @"The request should had succeeded, unless there was a network connection problem or the username/password was invalid.");
}

-(void)testGetAllReposForUserWithInvalidPerPage {
    
    __block int errorCode = -1;
    [self prepare];
    [self.api getAllReposForUser:@"github-objc" withReposPerPage:10 onSuccess:^(AFHTTPRequestOperation *operation, id response, BOOL isFinished) {
        if (isFinished) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUser)];
        }
        
    } onFailure:^(NSError *error) {
        errorCode = error.code;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUser)];
        
    }];
    // Wait for block to finish or timeout, before doing assertions
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:60.0];
    GHAssertTrue(errorCode == INVALID_PER_PAGE_INPUT, @"Setting the per_page to 0 should fail in the validations before executing the request");
}

-(void)testGetAllReposForEmptyUser {
    
    __block int errorCode = -1;
    [self prepare];
    [self.api getAllReposForUser:@"" withReposPerPage:10 onSuccess:^(AFHTTPRequestOperation *operation, id response, BOOL isFinished) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForEmptyUser)];
    } onFailure:^(NSError *error) {
        errorCode = error.code;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForEmptyUser)];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:4.0];
    GHAssertTrue(errorCode == EMPTY_INPUT, @"The user should not be found");
}

-(void)testGetAllReposForUserWithInvalidPassword {
    
    __block int errorCode = -1;
    Credential *credential = [[Credential alloc] initWithUsername:@"github-objc" andPassword:@"wrongPassword"];
    [self.api setCredential:credential];
    
    [self prepare];
    [self.api getAllReposForUser:@"carvil" withReposPerPage:10 onSuccess:^(AFHTTPRequestOperation *operation, id response, BOOL isFinished) {
        if (isFinished) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUserWithInvalidPassword)];
        }
        
    } onFailure:^(NSError *error) {
        errorCode = error.code;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testGetAllReposForUserWithInvalidPassword)];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:60.0];
    GHAssertTrue(errorCode == NSURLErrorBadServerResponse, @"The password should be invalid");
}

@end
