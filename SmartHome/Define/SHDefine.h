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

#define RGBColor(r,g,b,a) \
[UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:b/255.0f alpha:a]
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
//常用选中深灰色背景色
#define SelectBackgroundColor RGBColor(50,56,54,1)
//常用浅灰色背景色
#define TableBackgroundColor RGBColor(248,248,248,1)


#endif /* SHDefine_h */
