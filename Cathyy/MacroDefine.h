//
//  MacroDefine.h
//  xuexi
//
//  Created by 鸣人 on 2017/12/2.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h
#import <UIKit/UIKit.h>

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#ifdef DEBUG
#if (logon ==1)
# define CLog(format, ...) NSLog((@"<%@:(%d)> <%s>" format), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __FUNCTION__, ##__VA_ARGS__);
#elif(logon ==0)
# define CLog(...)
#endif
#else
# define CLog(...)
# define NSLog(...)
#endif

#define KeyWindow  [UIApplication sharedApplication].keyWindow
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define CGEmpty(string) string?string:@""
#define LZImage(string) [UIImage imageNamed:string]
#define LZFont(size) [UIFont systemFontOfSize:size]
#define LZBoldFont(size) [UIFont boldSystemFontOfSize:size]

static NSString *lastToastString = nil;
static NSTimeInterval lastTi = 0;
#define CGToast(string)  {\
NSTimeInterval ti =[NSDate date].timeIntervalSince1970;\
BOOL show = ti - lastTi >=5;\
if (![lastToastString isEqualToString:string]||show){\
lastToastString = string;\
lastTi = ti;\
[[UIApplication sharedApplication].keyWindow  makeToast:string duration:2 position:CSToastPositionCenter];}\
}

#endif /* MacroDefine_h */
