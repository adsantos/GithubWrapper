//
//  RestDefines.m
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RestDefines.h"

@implementation RestDefines

NSString * const BASE_URL_STRING = @"https://api.github.com";
NSString * const ERROR_DOMAIN = @"com.me.githubWrapper";
NSString * const searchReposForUser = @"/users/{user}/repos?per_page={per_page}";

@end
