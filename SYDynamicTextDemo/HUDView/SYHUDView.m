//
//  SYHUDView.m
//  SYTipsDemo
//
//  Created by Sauchye on 8/12/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//  https://github.com/sauchye/SYTipsDemo
//

#import "SYHUDView.h"

@interface SYHUDView ()

@end
@implementation SYHUDView

#define kHudDetailFontSize 14.0
#define kHudFontSize 15.0
#define kHudFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define Image(imageName) [UIImage imageNamed:imageName]
#define kSYHUDViewAnimationTime 1.6
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//加载框+文字提示
+ (SYHUDView *)showToView:(UIView *)view{
    SYHUDView *hud = [SYHUDView showHUDAddedTo:view animated:YES];
    hud.labelFont = kHudFont(kHudDetailFontSize);
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeIndeterminate;
    return hud;
}

//中间纯文字提示
+ (SYHUDView *)showToView:(UIView *)view text:(NSString *)text hide:(NSTimeInterval)time{
    SYHUDView *hud = [SYHUDView showHUDAddedTo:view animated:YES];
    hud.labelFont = kHudFont(kHudDetailFontSize);
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud hide:YES afterDelay:time];
    return hud;
}

//底部纯文字提示
+ (SYHUDView *)showToBottomView:(UIView *)view text:(NSString *)text hide:(NSTimeInterval)time{
    SYHUDView *hud = [SYHUDView showHUDAddedTo:view animated:YES];
    hud.labelFont = kHudFont(kHudDetailFontSize);
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.0f;
    CGFloat bottomSpaceY = 0.0;
    if (SCREEN_HEIGHT == 480) {
        bottomSpaceY = 150.0f;
    }else if(SCREEN_HEIGHT == 568){
        bottomSpaceY = 180.0f;
    }else{
        bottomSpaceY = 200.0f;
    }
    hud.yOffset = bottomSpaceY;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hide:YES afterDelay:time];
    return hud;
}


//图片显示是否加载成功+文字提示
+ (SYHUDView *)showToView:(UIView *)view
                  isSuccess:(BOOL)isSuccess
                     text:(NSString *)text
                     hide:(NSTimeInterval)time{
    
    SYHUDView *hud = [[SYHUDView alloc] initWithView:view];
    [view addSubview:hud];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    hud.alpha = 0.5;
    hud.labelFont = kHudFont(kHudFontSize);
    if (isSuccess) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
        
    }
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    return hud;
}

//自定义图片显示+文字提示
+ (SYHUDView *)showToView:(UIView *)view
              customImage:(UIImage *)image
                     text:(NSString *)text
                     hide:(NSTimeInterval)time{
    
    SYHUDView *hud = [[SYHUDView alloc] initWithView:view];
    [view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.labelFont = kHudFont(kHudFontSize);
    hud.labelText = text;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];

    return hud;
}

@end
