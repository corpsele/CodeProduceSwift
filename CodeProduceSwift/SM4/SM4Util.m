//
//  SM4Util.m
//  zshg_ios
//
//  Created by 闫颖 on 2019/12/5.
//

#import "SM4Util.h"
#import "sm4.h"
#import "hex2str.h"

#define KEY     "1111111111111111"

//定义秘钥和iv
#define SecretKey  "0ffb8344490186b7"
#define IV         "e97200b545feba13"

typedef unsigned char Uchar;
@implementation SM4Util

//计算mac
+(unsigned char*)hexEnc:(NSString*)strInput{
    NSData* data = [strInput dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger length = data.length;
    NSUInteger plusLength;
    if(length % 16 == 0){
        plusLength = 0;
    }
    else{
        plusLength = 16 - length % 16;
    }
    NSMutableString* new_str = [[NSMutableString alloc] initWithString:strInput];
    for (int i =0;i < plusLength;i++) {
        [new_str appendString:@" "];
    }
    NSUInteger new_length = length+plusLength;
    Uchar *input = (Uchar*)malloc(sizeof(Uchar)*new_length);
    Uchar *output = (Uchar*)malloc(sizeof(Uchar)*new_length);
    Uchar key[16] = KEY;
    const char *utfChar = [new_str UTF8String];
    memset(input, 0, new_length);
    memcpy(input, utfChar, new_length);
    
    sm4_context ctx;
    sm4_setkey_enc(&ctx,key);
    sm4_crypt_ecb(&ctx,1,new_length,input,output);
    
    unsigned char* c_str = Hex2Str(output,new_length);
    
    free(input);
    free(output);
    return c_str;
}

//
+(unsigned char*)hexDec:(NSString*)strInput{
    int inputCharSize = strInput.length/2;
    Uchar* input = (Uchar*)malloc(sizeof(Uchar)*inputCharSize);
    Uchar* output = (Uchar*)malloc(sizeof(Uchar)*inputCharSize);
    for (int i = 0; i<inputCharSize; i++) {
        NSString* str = [strInput substringWithRange:NSMakeRange(i*2, 2)];
        NSString* gw = [str substringWithRange:NSMakeRange(0, 1)]
        ;
        NSString* dw = [str substringWithRange:NSMakeRange(1, 1)];
        int n_gw = [SM4Util str2Int:gw];
        int n_dw = [SM4Util str2Int:dw];
        int result = n_gw * 16 + n_dw;
        input[i] = result;
    }
    Uchar key[16] = KEY;
    
    sm4_context ctx;
    sm4_setkey_dec(&ctx,key);
    sm4_crypt_ecb(&ctx,0,inputCharSize,input,output);
//    int kgPos = 0;
    for(int i=0;i<inputCharSize;i++){
        if (output[i] == 32) {
//            kgPos = i;
            output[i] = '\0';
        }
    }
    free(input);
//    free(output);
    return output;
}

//加密字符串转为十六进制
+(int)str2Int:(NSString*)str{
    char* ch = [str UTF8String];
    int result;
    char c = ch[0];
    if (c >= '0' && c <= '9') {
        return (c - '0');
    }
    if (c == 'a') {
        return 10;
    }
    else if(c == 'b'){
        return 11;
    }
    else if(c == 'c'){
        return 12;
    }
    else if(c == 'd'){
        return 13;
    }
    else if(c == 'e'){
        return 14;
    }
    else if(c == 'f'){
        return 15;
    }
    return 0;
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
//--------------------------与Java统一SM4加解密方法--------------------------
//------------------------------------------------------------------------
//------------------------------------------------------------------------


//加密
+ (NSString*)hg_encryptSM4:(NSString*)strInput{
    
    NSData* data = [strInput dataUsingEncoding:NSUTF8StringEncoding];
    int length = [[NSString stringWithFormat:@"%lu",(unsigned long)data.length] intValue];
    int plusLength = 16 - length % 16;
    int new_length = length + plusLength;
    
    //初始化
    Uchar *input = (Uchar*)malloc(sizeof(Uchar)*new_length);
    Uchar *output = (Uchar*)malloc(sizeof(Uchar)*new_length);
    
    //补位赋值
    const char *utfChar = [strInput UTF8String];
    // 全部用需要补位的个数填充
    memset(input, plusLength, new_length);
    // 除去需要补位的部分，其余赋值为输入的数据
    memcpy(input, utfChar, length);
    
    //加密
    Uchar key[16] = SecretKey;
    Uchar iv[16] = IV;
    sm4_context ctx;
    sm4_setkey_enc(&ctx,key);
//    sm4_crypt_ecb(&ctx,1,new_length,input,output);
    sm4_crypt_cbc(&ctx,1,new_length, iv,input,output);

    //转成base64字符串，再进行URLCode
    NSData * inputData = [NSData dataWithBytes:output length:new_length];
    NSString * inputString = [inputData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    inputString = [SM4Util encodeString:inputString];

    free(input);
    free(output);
    return [NSString stringWithFormat:@"%@",inputString];
}

//解密
+ (NSString *)hg_decryptSM4:(NSString*)strInput{
 
    NSString * decodedString = [SM4Util decodeString:strInput];
    NSData * contentData = [[NSData alloc] initWithBase64EncodedString:decodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    int inputCharSize = [[NSString stringWithFormat:@"%lu",(unsigned long)contentData.length] intValue];
    
    //初始化
    Uchar* input = (Uchar*)malloc(sizeof(Uchar)*inputCharSize);
    Uchar* output = (Uchar*)malloc(sizeof(Uchar)*inputCharSize);
    
    //为输入赋值
    memset(input, 0, inputCharSize);
    memcpy(input,(Uchar*)[contentData bytes],inputCharSize);

    //解密
    Uchar key[16] = SecretKey;
    Uchar iv[16] = IV;
    sm4_context ctx;
    sm4_setkey_dec(&ctx,key);
//    sm4_crypt_ecb(&ctx,0,inputCharSize,input,output);
    sm4_crypt_cbc(&ctx,0,inputCharSize, iv,input,output);

    //去除补位信息
    Uchar p = output[inputCharSize - 1];
    int new_length = inputCharSize - p;
    if (new_length < 0) {
        new_length = 0;
    }
    
    //转字符串
    NSString * outputString = [[NSString alloc] initWithBytes:output length:new_length encoding:NSUTF8StringEncoding];
        
    free(input);
    free(output);
    return outputString;
}


//编码
+ (NSString*)encodeString:(NSString*)uncodeString{
    NSCharacterSet * charSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
    NSString * encodedString = [uncodeString stringByAddingPercentEncodingWithAllowedCharacters:charSet];
    return encodedString;
}
//解码
+ (NSString*)decodeString:(NSString*)decodeString{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)decodeString, CFSTR("")));
}

@end
