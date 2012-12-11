//
//  RestAPI.m
//  githubWrapper
//
//  Created by Adriana Santos on 09/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import "RestAPI.h"
#import "RestHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "NSString+Helper.h"

@implementation RestAPI
@synthesize credential = _credential;

-(void)setCredential:(Credential *)credential {
    _credential.username = credential.username;
    _credential.password = credential.password;
    [[RestHTTPClient sharedInstance] setCredential:credential];
}

-(RestAPI *)initWithCredential:(Credential *)credential {
    
    if(credential == nil || self != [self init]) {
        return nil;
    }
    
    self.credential = credential;
    
    return self;
}

-(void)fetchNextPageUntilLastWithURL:(NSString *)urlString onSuccess:(GetAllReposForUserSuccessBlock)success onFailure:(FailureBlock)failure {
    if(FALSE == [[RestHTTPClient sharedInstance] isReachable]) {
        if(failure) {
            NSDictionary *userInfo = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:NSLocalizedString(@"Failed to connect to the network", @"")] forKeys:[NSArray arrayWithObject:NSLocalizedDescriptionKey]];
            NSError *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:NSURLErrorNotConnectedToInternet userInfo:userInfo];
            failure(error);
        }
        return;
    }
    
    [[RestHTTPClient sharedInstance] getPath:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        
        NSLog(@"response: %@", response);
        NSLog(@"headers: %@", [[operation response] allHeaderFields]);
        NSLog(@"links: %@", [[[operation response] allHeaderFields] objectForKey:@"Link"]);
        
        BOOL isFinished = YES;
        
        NSString *link = [[[operation response] allHeaderFields] objectForKey:@"Link"];
        if (link) {
            NSString *nextPage = [NSString stringBetweenString:@"<" andString:@">; rel=\"next\"" onString:link];
            
            if (nextPage) {
                isFinished = NO;
                [self fetchNextPageUntilLastWithURL:nextPage onSuccess:success onFailure:failure];
            }
        }
        
        if (success) {
            success(operation, response, isFinished);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)fetchNextPageWithURL:(NSString *)urlString onSuccess:(RestHTTPClientSuccessBlock)success onFailure:(FailureBlock)failure {
    if(FALSE == [[RestHTTPClient sharedInstance] isReachable]) {
        if(failure) {
            NSDictionary *userInfo = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:NSLocalizedString(@"Failed to connect to the network", @"")] forKeys:[NSArray arrayWithObject:NSLocalizedDescriptionKey]];
            NSError *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:NSURLErrorNotConnectedToInternet userInfo:userInfo];
            failure(error);
        }
        return;
    }
    
    [[RestHTTPClient sharedInstance] getPath:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        
        if (success) {
            success(operation, response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)getAllReposForUser:(NSString *)username withReposPerPage:(NSInteger)reposPerPage onSuccess:(GetAllReposForUserSuccessBlock)success onFailure:(FailureBlock)failure {
    
    if ([username length] == 0) {
        if(failure) {
            NSDictionary *userInfo = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:NSLocalizedString(@"The username cannot be blank", @"")] forKeys:[NSArray arrayWithObject:NSLocalizedDescriptionKey]];
            NSError *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:EMPTY_INPUT userInfo:userInfo];
            failure(error);
        }
        return;
    }
    
    if (reposPerPage < 1 || reposPerPage > 100) {
        if(failure) {
            NSDictionary *userInfo = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObject:NSLocalizedString(@"The number of repositories per page has to be between 1 and 100", @"")] forKeys:[NSArray arrayWithObject:NSLocalizedDescriptionKey]];
            NSError *error = [[NSError alloc] initWithDomain:ERROR_DOMAIN code:INVALID_PER_PAGE_INPUT userInfo:userInfo];
            failure(error);
        }
        return;
    }
    
    NSString *reposPerPageString = [NSString stringWithFormat:@"%d", reposPerPage];
    [self fetchNextPageUntilLastWithURL:[[searchReposForUser stringByReplacingOccurrencesOfString:@"{user}" withString:[username stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]] stringByReplacingOccurrencesOfString:@"{per_page}" withString:reposPerPageString] onSuccess:^(AFHTTPRequestOperation *operation, id response, BOOL isFinished) {
        if (success) {
            success(operation, response, isFinished);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
