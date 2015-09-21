//
//  ViewController.m
//  SYDynamicTextDemo
//
//  Created by Saucheong Ye on 9/16/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kTITLE_COLOR [UIColor colorWithRed:0/255.0 green:180/255.0f blue:234/255.0f alpha:1]


#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[UIColor orangeColor].CGColor}

#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[kTITLE_COLOR CGColor]}
#define kFontSize ((SCREEN_WIDTH>320?18.0:16.0))

#import "ViewController.h"
#import "SYHUDView.h"
#import "UITTTAttributedLabel.h"
#import "SYWebViewController.h"

static CGFloat const padding = 10.0;

static inline NSRegularExpression * isContentUrlExpression() {
    static NSRegularExpression *_isContentUrlExpression = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _isContentUrlExpression = [[NSRegularExpression alloc] initWithPattern:@"http+:[^\\s]*" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    
    return _isContentUrlExpression;
}

@interface ViewController () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) UITTTAttributedLabel *textLbl;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dynamic text demo";
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longPressCopyMessage) name:@"LongPressCopyMessage" object:nil];
    [self setup];
}

- (void)longPressCopyMessage
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _textLbl.text;
    
}

- (void)setup
{
   static NSString * const content = @"I am an iOS developer live in Shenzhen city of Guangdong Provice ,China and  constantly improving myself of iOS skill hope to become a top iOSer, So i am crazy star of Github, learn lastest iOS skill. \n😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄\nWelcome to communicate with me \n Blog http://sauchye.com \n GitHub https://github.com/sauchye \n Twitter http://twitter.com/sauchye \n  Weibo http://weibo.com/315526661";
    
    CGFloat textHeight = [self heightForText:content fontSize:kFontSize];
    
    _textLbl = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(padding, 10, SCREEN_WIDTH - 2 * padding, textHeight)];
    
    _textLbl.numberOfLines = 0;
    _textLbl.lineBreakMode = NSLineBreakByCharWrapping;
    _textLbl.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    
    
    _textLbl.delegate = self;
    _textLbl.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    _textLbl.textColor = [UIColor darkGrayColor];
    _textLbl.font = [UIFont systemFontOfSize:kFontSize];
    _textLbl.text = content;

    [_textLbl addLongPressForCopy];
    //显示url的颜色
    _textLbl.linkAttributes = kLinkAttributes;
    //点击后显示的颜色
    _textLbl.activeLinkAttributes = kLinkAttributesActive;

    [self.view addSubview:_textLbl];


    
    [_textLbl setText:content afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         
         //设置可点击文字的范围
         NSRange boldRange = [[mutableAttributedString string] rangeOfString:content options:NSCaseInsensitiveSearch];
         
         //设定可点击文字的的大小
         UIFont *boldSystemFont = [UIFont systemFontOfSize:kFontSize];
         CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
         
         if (font) {
             
             //设置可点击文本的大小
             [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
             
             //设置可点击文本的颜色
             [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor darkGrayColor] CGColor] range:boldRange];
             
             CFRelease(font);
             
         }
         return mutableAttributedString;
     }];
    
    
    NSRegularExpression *regexpURL = isContentUrlExpression();
    NSTextCheckingResult *matchURL = [regexpURL firstMatchInString:content options:0 range:NSMakeRange(0, [content length])];
    
    if (matchURL) {
        
        NSRange resultRange = [matchURL rangeAtIndex:0];
        
        NSString *result=[content substringWithRange:resultRange];
        
        NSLog(@"%@",result);
        //设置链接的url
        [_textLbl addLinkToURL:[NSURL URLWithString:result] withRange:resultRange];
        
    }
    
    
    //url 添加下划线
    //    _textLbl.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    
    //检测手机号码
    //    _textLbl.enabledTextCheckingTypes = NSTextCheckingTypePhoneNumber;
}



#pragma mark - heightForText
- (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)fontSize
{
    
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    return ceilf([text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - padding * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbute context:nil].size.height);
}


#pragma mark - TTTAttributedLabelDelegate Method
- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithPhoneNumber:(NSString *)phoneNumber atPoint:(CGPoint)point
{
    
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    SYWebViewController *webVC = [[SYWebViewController alloc] init];
    webVC.url = url;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
