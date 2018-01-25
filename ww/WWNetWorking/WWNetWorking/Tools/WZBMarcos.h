//
//  WZBMarcos.h
//  Wzbao
//
//  Created by WangWei on 15/10/12.
//  Copyright © 2015年 WZBaoWW. All rights reserved.
//

#ifndef WZBMarcos_h
#define WZBMarcos_h

#define kNSString(dictionary,string) [NSString stringWithFormat:@"%@",dictionary[string]];

//block的weakself
#define WZBweakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// rgb颜色转换（16进制->10进制）
#define KHexColor(hexValue) [UIColor \
                            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                            green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define Kcolor(a,b) [UIColor colorWithWhite:a alpha:b]


#define KGroundGeneral [UIColor \
colorWithRed:((float)((0xFAFAFA & 0xFF0000) >> 16))/255.0 \
green:((float)((0xFAFAFA & 0xFF00) >> 8))/255.0 \
blue:((float)(0xFAFAFA & 0xFF))/255.0 alpha:1]

#define KDarkGround [UIColor \
colorWithRed:((float)((0xefefef & 0xFF0000) >> 16))/255.0 \
green:((float)((0xefefef & 0xFF00) >> 8))/255.0 \
blue:((float)(0xefefef & 0xFF))/255.0 alpha:1]

#define Kback [UIColor \
colorWithRed:((float)((0xF04B38 & 0xFF0000) >> 16))/255.0 \
green:((float)((0xF04B38 & 0xFF00) >> 8))/255.0 \
blue:((float)(0xF04B38 & 0xFF))/255.0 alpha:1]

#define Kniv [UIColor \
colorWithRed:((float)((0x333333 & 0xFF0000) >> 16))/255.0 \
green:((float)((0x333333 & 0xFF00) >> 8))/255.0 \
blue:((float)(0x333333 & 0xFF))/255.0 alpha:1]

#define KLabelSecurity [UIColor \
colorWithRed:((float)((0x999999 & 0xFF0000) >> 16))/255.0 \
green:((float)((0x999999 & 0xFF00) >> 8))/255.0 \
blue:((float)(0x999999 & 0xFF))/255.0 alpha:1]

#define KViewLine [UIColor \
colorWithRed:((float)((0xDDDDDD & 0xFF0000) >> 16))/255.0 \
green:((float)((0xDDDDDD & 0xFF00) >> 8))/255.0 \
blue:((float)(0xDDDDDD & 0xFF))/255.0 alpha:1]

#define kBoldFont(size) [UIFont boldSystemFontOfSize:size]
#define kFont(size) [UIFont systemFontOfSize:size]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 屏幕宽度
#define kScreenRect   [[UIScreen mainScreen] bounds]

//LOAD LOCAL IMAGE FILE     读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//设备的判断
#define kIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
//DEFINE IMAGE      定义UIImage对象//    imgView.image = IMAGE(@"Default.png");

#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//DEFINE IMAGE      定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

#define kUserDefaults     [NSUserDefaults standardUserDefaults]

#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
#define PLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"] //edit the plist
//----------------------ABOUT COLOR 颜色相关 ----------------------------

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define kClearColor [UIColor clearColor]
#define kWhiteColor [UIColor whiteColor]

#define UIColorFromRGB(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_BLUE_             UIColorFromRGB(0x41CEF2)
#define COLOR_GRAY_             UIColorFromRGB(0xababab) //171
#define COLOR_333               UIColorFromRGB(0x333333) //51
#define COLOR_666               UIColorFromRGB(0x666666) //102
#define COLOR_888               UIColorFromRGB(0x888888) //136
#define COLOR_999               UIColorFromRGB(0x999999) //153
#define COLOR_PLACEHOLD_        UIColorFromRGB(0xc5c5c5) //197
#define COLOR_RED_              UIColorFromRGB(0xff5400) //红色
#define COLOR_GREEN_            UIColorFromRGB(0x31d8ab)//绿色
#define COLOR_YELLOW_           UIColorFromRGB(0xffa200)//黄色
#define COLOR_SEPARATE_LINE     UIColorFromRGB(0xC8C8C8)//200
#define COLOR_LIGHTGRAY         COLOR(200, 200, 200, 0.2)//淡灰色
//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone X 分辨率，像素2436x1125  (iphone x)，@3x */
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* WZBMarcos_h */
