//
//  CPAPIToken.h
//  Catchpoint
//
//  Created by Matias on 6/17/15.
//  Copyright (c) 2015 Catchpoint Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPAPIToken : NSObject

@property (nonatomic, weak, readonly) NSString *token;

+ (NSString *)token;

@end
