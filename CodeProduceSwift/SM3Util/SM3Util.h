//
//  SM3Util.h
//  SM3Util
//
//  Created by swxa@saas on 2018/5/30.
//  Copyright © 2018年 swxa@saas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SM3Util : NSObject


+(NSString *)getSM3Hash:(NSString *)plain;
+(NSData *)getSM3PreHash:(NSData *)plain andPublic:(NSString *)publicKey;
@end
