//
//  SHDefine.h
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#ifndef SHDefine_h
#define SHDefine_h
//获取storyboard 上的VC
#define GetStoryBoardWithViewControllerName(ControllerName)    \
        [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:ControllerName]

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define ScreenHeight  [UIScreen mainScreen].bounds.size.height;

#define RGBColor(red,green,blue) [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:blue/255.0f alpha:alpha]
//常用绿色
#define GreenColor RGBColor(36,213,195,1)
//常用灰色
#define LightGrayColor RGBColor(189,189,189,1)
//常用黑色
#define BlackColor RGBColor(119,119,119,1)
//常用白色
#define WhiteColor [UIColor whiteColor]
//常用深灰色背景色
#define BackgroundColor RGBColor(45,49,58,1)
//常用浅灰色背景色
#define TableBackgroundColor RGBColor(248,248,248,1)


#endif /* SHDefine_h */
