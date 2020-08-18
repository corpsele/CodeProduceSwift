//
//  SM4Util.h
//  zshg_ios
//
//  Created by 闫颖 on 2019/12/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SM4Util : NSObject

+(unsigned char*)hexEnc:(NSString*)strInput;//加密
+(unsigned char*)hexDec:(NSString*)strInput;//解密


//加密
+ (NSString*)hg_encryptSM4:(NSString*)strInput;
//解密
+ (NSString *)hg_decryptSM4:(NSString*)strInput;


@end

NS_ASSUME_NONNULL_END
