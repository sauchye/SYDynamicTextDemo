# SYDynamicTextDemo

Dynamic text demo

``` objective-c
- (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)fontSize
{
    
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    return ceilf([text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbute context:nil].size.height);
}
```

