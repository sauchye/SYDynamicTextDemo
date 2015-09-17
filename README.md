# SYDynamicTextDemo

Dynamic text demo



### Demo

![intro git](https://github.com/sauchye/SYDynamicTextDemo/raw/master/into.gif)



``` objective-c
- (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)fontSize
{

    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};

    return ceilf([text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbute context:nil].size.height);
}
```

``` objective-c
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
    _textLbl.linkAttributes = kLinkAttributes;
    _textLbl.activeLinkAttributes = kLinkAttributesActive;

    [self.view addSubview:_textLbl];



    [_textLbl setText:content afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {

         NSRange boldRange = [[mutableAttributedString string] rangeOfString:content options:NSCaseInsensitiveSearch];

         UIFont *boldSystemFont = [UIFont systemFontOfSize:kFontSize];
         CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);

         if (font) {

             [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];

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

        [_textLbl addLinkToURL:[NSURL URLWithString:result] withRange:resultRange];   
    }
}

#pragma mark - heightForText
- (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)fontSize
{

    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};

    return ceilf([text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - padding * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbute context:nil].size.height);
}

#pragma mark - TTTAttributedLabelDelegate Method
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    SYWebViewController *webVC = [[SYWebViewController alloc] init];
    webVC.url = url;//[NSURL URLWithString:@"http://weibo.com"];
    [self.navigationController pushViewController:webVC animated:YES];
}
```



``` objective-c
static inline NSRegularExpression * isContentUrlExpression() {
    static NSRegularExpression *_isContentUrlExpression = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _isContentUrlExpression = [[NSRegularExpression alloc] initWithPattern:@"http+:[^\\s]*"  options:NSRegularExpressionCaseInsensitive error:nil];
    });

    return _isContentUrlExpression;
}
```

### Libraries

<a href="https://github.com/jdg/MBProgressHUD">MBProgressHUD</a>

<a href="https://github.com/TTTAttributedLabel/TTTAttributedLabel">TTTAttributedLabel</a>