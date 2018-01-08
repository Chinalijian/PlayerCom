//
//  PCDefine.h
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#ifndef PCDefine_h
#define PCDefine_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((((rgbValue) & 0xFF0000) >> 16))/255.f \
green:((((rgbValue) & 0xFF00) >> 8))/255.f \
blue:(((rgbValue) & 0xFF))/255.f alpha:1.0]

#define DMColorWithRGBA(red,green,blue,alpha) [UIColor colorWithR:red g:green b:blue a:alpha]

#endif /* PCDefine_h */
