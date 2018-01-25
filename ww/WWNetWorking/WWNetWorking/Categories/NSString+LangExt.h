//
//  NSString+LangExt.h
//  Wzbao
//
//  Created by wangwei on 15/10/22.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isEmptyString(NSString * str);

BOOL isNullString(NSString * str);

BOOL isEqualString(NSString *str1, NSString *str2);

@interface NSString (LangExt)

//- (CGSize)calculateTextSize:(CGSize)maxSize andFont:(UIFont *)font;
// 是否为空
+ (BOOL) isEmptyOrNull:(NSString*) string;
// 不为空
+ (BOOL) notEmptyOrNull:(NSString*) string;
/***************************************
 *  编码
 **************************************/

//- (NSString *)URLEncodedString;
//
//- (NSString *)URLDecodedString;

/***************************************
 *  检验
 **************************************/

/**
 *  验证手机号有效性
 *
 *  @return
 */
- (BOOL)isValidChinesePhoneNumber;

/**
 *  验证用户名有效性，4-30位数字、字母
 *
 *  @return
 */
- (BOOL)validUsername;

/**
 *  验证密码有效性，6-16数字和字母组合
 *
 *  @return
 */
- (BOOL)validPassword;

/**
 *  验证是否有效中文姓名
 *
 *  @return
 */
- (BOOL)validChineseName;


/**
 *  验证邮箱有效性
 *
 *  @return
 */
- (BOOL)validEmail;

/**
 *  验证字符串是否全数字
 *
 *  @return
 */
- (BOOL)isDigital;

/**
 *  验证身份证号码有效性，18位
 *
 *  身份证合法性校验
 *  15位身份证号码：第7、8位为出生年份(两位数)，第9、10位为出生月份，
 *  第11、12位代表出生日期，第15位代表性别，奇数为男，偶数为女。
 *  -------
 *  -------
 *  18位身份证号码：第7、8、9、10位为出生年份(四位数)，第11、第12位为出生月份，
 *  第13、14位代表出生日期，第17位代表性别，奇数为男，偶数为女。
 *  -------
 *  - 省，直辖市代码表
 *  -------
 *  11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
 *  21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
 *  33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",
 *  42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",
 *  51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",
 *  63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"
 *
 * 判断18位身份证的合法性
 * ============================================
 * 根据〖中华人民共和国国家标准GB11643-1999〗中有关公民身份号码的规定，公民身份号码是特征组合码，由十七位数字本体码和一位数字校验码组成。
 * ======================
 * 排列顺序从左至右依次为：六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
 * 顺序码: 表示在同一地址码所标识的区域范围内，对同年、同月、同 日出生的人编定的顺序号，顺序码的奇数分配给男性，偶数分配 给女性。
 * ============================================
 * 1.前1、2位数字表示：所在省份的代码；
 * 2.第3、4位数字表示：所在城市的代码；
 * 3.第5、6位数字表示：所在区县的代码；
 * 4.第7~14位数字表示：出生年、月、日；
 * 5.第15、16位数字表示：所在地的派出所的代码；
 * 6.第17位数字表示性别：奇数表示男性，偶数表示女性；
 * 7.第18位数字是校检码：也有的说是个人信息码，一般是随计算机的随机产生，用来检验身份证的正确性。校检码可以是0~9的数字，有时也用x表示。
 * ============================================
 * 第十八位数字(校验码)的计算方法为：
 * 1.将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
 * 2.将这17位数字和系数相乘的结果相加。
 * 3.用加出来和除以11，看余数是多少？
 * 4.余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。
 * 5.通过上面得知如果余数是2，就会在身份证的第18位数字上出现罗马数字的Ⅹ。如果余数是10，身份证的最后一位号码就是2。
 *
 *  @return
 */
- (BOOL)validIDCard;

/**
 *  遮掩名字
 *
 *  @return
 */
- (NSString *)maskRealname;

/**
 *  遮掩身份证号码
 *
 *  @return
 */
- (NSString *)maskIdNumber;

/**
 *  遮掩邮箱账号
 *
 *  @return
 */
- (NSString *)maskEmail;

/**
 *  遮掩手机号码
 *
 *  @return
 */
- (NSString *)maskChinesePhoneNumber;


/***************************************
 *  字符串转日期
 **************************************/

- (NSDate *)dateFromDateFormatString:(NSString *)formatString;

// 签名
+ (NSString *)signString:(NSArray*)array;

- (NSString *)isPhone;//移动联通dianxin
- (NSString *)getStrDate:(NSString *)dateStr getControlDate:(NSString *)conStr;

+ (NSString *)ConvertStrToTime:(NSString *)timeStr;
+ (NSString *)dayConversionMonth:(NSString *)day;

//通知的封装
+ (void)WZBNotifinity:(NSString *)nameStr notifityDic:(NSDictionary *)dic;
//字符串的
+ (NSMutableAttributedString *)sendAndReceiveColor:(NSString *)initStr;
+ (BOOL)getIsIpad;//判断是不是ipad

- (NSString *)maskBankCardNumber;//遮挡银行卡号

+ (NSString *)base64encryption:(NSString *)encryption;//加密
+ (NSString *)base64encryptionTwo:(NSString *)encryption;//加密2边
//系统当前时间
- (NSString *)nowDate:(NSString *)formatter;
+ (BOOL)getSex:(NSString *)idCard;//获取男女

//时间戳转化为时间NSDate
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+(NSString*)getCurrentTimes;//获取当前系统时间
//控制提现
+ (BOOL)controlTimewithdraw:(NSInteger)night endTime:(NSInteger)morning;

+ (NSString *)rateHikeIntercept:(NSString *)intercept;//加息的截取
+ (NSString *)interceptName:(NSString *)intercept;//加息的截取 标底名称
@end
