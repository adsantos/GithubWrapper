//
//  Credential.h
//  Wrapper
//
//  Created by Adriana Santos on 10/12/2012.
//  Copyright (c) 2012 Adriana Santos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Credential : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

-(Credential *)initWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
