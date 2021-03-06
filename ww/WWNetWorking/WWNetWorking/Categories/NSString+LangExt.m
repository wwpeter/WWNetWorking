//
//  NSString+LangExt.m
//  Wzbao
//
//  Created by wagnwei on 15/10/22.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import "NSString+LangExt.h"
#import <CocoaSecurity/Base64.h>

BOOL isEmptyString(NSString * str)
{
    return str.length == 0 || str == nil;
}
BOOL isNullString(NSString * str) {
    if ([str isEqualToString:@"<null>"]) {
        return NO;
    } else {
        return YES;
    }
}
BOOL isEqualString(NSString *str1, NSString *str2)
{
    return [str1 isEqualToString:str2];
}

@implementation NSString (LangExt)
+ (NSString *)trimString:(NSString *) str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL) isEmptyOrNull:(NSString*) string
{
    return ![self notEmptyOrNull:string];
    
}

+ (BOOL) notEmptyOrNull:(NSString*) string
{
    if([string isKindOfClass:[NSNull class]])
        return NO;
    if ([string isKindOfClass:[NSNumber class]]) {
        if (string != nil) {
            return  YES;
        }
        return NO;
    } else {
        string=[self trimString:string];
        if (string != nil && string.length > 0 && ![string isEqualToString:@"null"]&&![string isEqualToString:@"(null)"]&&![string isEqualToString:@"<null>"]&&![string isEqualToString:@" "]) {
            return  YES;
        }
        return NO;
    }
}
/**
- (CGSize)calculateTextSize:(CGSize)maxSize andFont:(UIFont *)font
{
    return [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
}*/

/***************************************
 *  编码
 **************************************/

- (NSString *)URLEncodedString
{
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)URLDecodedString
{
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

/***************************************
 * 功能：校验
 * 作者：
 **************************************/

- (BOOL)isValidChinesePhoneNumber
{
    NSString *numberRegex = @"17[0-9]{9}|13[0-9]{9}|15[0-9]{9}|18[0-9]{9}|145[0-9]{8}|147[0-9]{8}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:self];
}

- (BOOL)validUsername
{
    NSString *passCodeRegex = @"[a-zA-Z0-9_-]{4,30}";
    NSPredicate *passCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passCodeRegex];
    return [passCodeTest evaluateWithObject:self];
}

- (BOOL)validPassword
{
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

- (BOOL)validChineseName
{
    NSString *nameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:self];
}

- (BOOL)validEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isDigital
{
    if (self.length == 0 || !self)
        return NO;
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive error:NULL];
    
    return [regularExpression matchesInString:self options:0 range:NSMakeRange(0, self.length)].count > 0 ? YES : NO;
}

- (BOOL)validIDCard
{
    // 如果身份证不是18位
    if (self.length != 18)
        return NO;
    
    // 获取前17位
    NSString *idCard17 = [self substringToIndex:17];
    // 获取第18位
    NSString *idCard18Code = [self substringFromIndex:17];
    
    NSString *checkCode = @"";
    
    if ([idCard17 isDigital]) {
        NSInteger sum17 = 0;
        int power[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
        if (idCard17.length == 17) {
            for (int i = 0; i < idCard17.length; i++) {
                for (int j = 0; j <idCard17.length; j++) {
                    if (i == j) {
                        NSInteger temp = [[idCard17 substringWithRange:NSMakeRange(i, 1)] integerValue] * power[j];
                        sum17 = sum17 + temp;
                    }
                }
            }
        }
        
        checkCode = @[@"1", @"0", @"x", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"][sum17 % 11];
        
        if (![idCard18Code.uppercaseString isEqualToString:checkCode.uppercaseString])
            return NO;
    }
    
    return YES;
}

- (NSString *)maskRealname
{
    if (self.length == 2) {
        return [NSString stringWithFormat:@"%@*", [self substringToIndex:1]];
    } else {
        return [NSString stringWithFormat:@"%@*%@", [self substringToIndex:1], [self substringFromIndex:self.length - 1]];
    }
}

- (NSString *)maskIdNumber
{
    return [NSString stringWithFormat:@"%@***********%@", [self substringToIndex:3], [self substringFromIndex:self.length - 4]];
}

- (NSString *)maskChinesePhoneNumber
{
    return [NSString stringWithFormat:@"%@*******%@", [self substringToIndex:3], [self substringFromIndex:8]];
}

- (NSString *)maskEmail
{
    NSInteger indexOfAt = [self rangeOfString:@"@"].location;
    
    return [NSString stringWithFormat:@"%@***%@", [self substringToIndex:1], [self substringFromIndex:indexOfAt - 2]];
}

- (NSDate *)dateFromDateFormatString:(NSString *)formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatString;
    NSDate *date =  [dateFormatter dateFromString:self];
    
    return date;
}

+ (NSString *)signString:(NSArray*)array
{
    NSArray *newarr = [array sortedArrayUsingFunction:nickNameSort context:NULL];
    
    NSString *str = [newarr componentsJoinedByString:@""];
    str = [str lowercaseString];
    
    return str;
}
/************** A,B,C,D排序 ************************/
NSInteger nickNameSort(id user1, id user2, void *context)
{
    NSString *u1,*u2;
    //类型转换
    u1 = (NSString*)user1;
    u2 = (NSString*)user2;
    return  [u1 localizedCompare:u2];
}
- (NSString *)isPhone {
    NSString *cm = @"^((13[4-9])|(147)|(15[0-2,7-9])|(18[2-3,7-8]))\\d{8}$";
    NSString *cu = @"^((13[0-2])|(145)|(15[5-6])|(186))\\d{8}$";
    NSString *ct = @"^((133)|(153)|(18[0,9]))\\d{8}$";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cm];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cu];
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ct];
    if ([predicate1 evaluateWithObject:self]) {
        return @"移动";
    }else if ([predicate2 evaluateWithObject:self]) {
        return @"联通";
    }else if ([predicate3 evaluateWithObject:self]) {
        return @"电信";
    } else {
        return @"不知道！";
    }
}
- (NSString *)getStrDate:(NSString *)dateStr getControlDate:(NSString *)conStr {
//    if (dateStr&&conStr) {
//        NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
//        CGFloat day = [arr[2] integerValue];
//        CGFloat mouth = [arr[1] integerValue];
//        CGFloat year = [arr[0] integerValue];
//        CGFloat conDate = [conStr integerValue];
//        
//        、、CGFloat b = da/
//        
//        
//        return str;
//    }
    return nil;
}
+ (NSString *)ConvertStrToTime:(NSString *)timeStr {    
    long long time=[timeStr longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:d];
    
    return timeString;
    
}
+ (NSString *)dayConversionMonth:(NSString *)day {
    NSInteger staticday = [day integerValue];
    if (staticday<30) {
        return  [NSString stringWithFormat:@"%@天", day];
    } else {
        NSInteger day = staticday%30;
        NSInteger month = staticday/30;
        if (day==0) {
            return  [NSString stringWithFormat:@"%ld个月", month];
        } else {
            return [NSString stringWithFormat:@"%ld个月%ld天", month,day];
        }
    }
}
+ (void)WZBNotifinity:(NSString *)nameStr notifityDic:(NSDictionary *)dic {
    NSNotification * notice = [NSNotification notificationWithName:nameStr object:nil userInfo:dic];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}
+ (NSMutableAttributedString *)sendAndReceiveColor:(NSString *)initStr {
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:initStr];
    
    for (int i = 0; i < initStr.length; i ++) {
        
        //这里的小技巧，每次只截取一个字符的范围
        
        NSString *a = [initStr substringWithRange:NSMakeRange(i, 1)];
        
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        
        if ([number containsObject:a]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:13],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
}
+ (BOOL)getIsIpad {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPhone"]) {
        return NO;
    }
    
    else if([deviceType isEqualToString:@"iPod touch"]) {
        return NO;
    }
    
    else if([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    
    return NO;
    
}
- (NSString *)maskBankCardNumber {
    return [NSString stringWithFormat:@"**** **** **** %@",  [self substringFromIndex:self.length - 4]];
}
+ (NSString *)base64encryption:(NSString *)encryption {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        encryption = [[encryption base64EncodedString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        return encryption;
    } else {
        encryption = [[encryption base64EncodedString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        return encryption;
    }
}//加密
+ (NSString *)base64encryptionTwo:(NSString *)encryption {
    //encryption = [encryption base64EncodedString];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        encryption = [[[encryption base64EncodedString] base64EncodedString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        return encryption;
    } else {
        encryption = [[[encryption base64EncodedString] base64EncodedString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        return encryption;
    }
}
- (NSString *)nowDate:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]];
    
    return timestamp;
}
/*** 获取男女 ****/
+ (BOOL)getSex:(NSString *)idCard {
    NSString *sexStr = [idCard substringWithRange:NSMakeRange(idCard.length-2, 1)];
    if ([sexStr integerValue]%2) {
        return YES;
    } else {
        return NO;
    }
}
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    if (timeString) {
        // 格式化时间
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        // 毫秒值转化为秒
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
        NSString* dateString = [formatter stringFromDate:date];
        return dateString;
    }
    return @"";
}
//获取当前的时间
+(NSString*)getCurrentTimes {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"HH:mm"];//YYYY-MM-dd HH:mm:ss
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}
+ (BOOL)controlTimewithdraw:(NSInteger)night endTime:(NSInteger)morning {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];//YYYY-MM-dd HH:mm:ss
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSInteger currentTime = [currentTimeString integerValue];
    if (currentTime>=night||currentTime<morning) {
        return NO;
    } else {
        return YES;
    }
}
+ (NSString *)rateHikeIntercept:(NSString *)intercept {
    //NSString *tempStr = @"";
    if (intercept) {
        NSArray *arr = [intercept componentsSeparatedByString:@"%"];
        if (arr.count == 2) {
            NSString *tempStr1 = arr[0];
            if ([tempStr1 containsString:@"加息"]) {
                NSString *jiaxi = [tempStr1 substringFromIndex:2];
                if ([jiaxi doubleValue]>0) {
                    return jiaxi;
                } else {
                    return @"NO";
                }
            } else {
                if ([tempStr1 doubleValue]>0) {
                    return [NSString stringWithFormat:@"%@",arr[0]];
                } else {
                    return @"NO";
                }
            }
        } else {
            return @"NO";
        }
    }
    
    return @"NO";
}
+ (NSString *)interceptName:(NSString *)intercept {
    if (intercept) {
        NSArray *arr = [intercept componentsSeparatedByString:@"%"];
        if (arr.count == 2) {
            NSString *tempStr1 = arr[1];
            return [NSString stringWithFormat:@"%@",tempStr1];
        } else {
            return intercept;
        }
    }
    return intercept;
}
@end
