//
//  ViewController.m
//  SYDynamicTextDemo
//
//  Created by Saucheong Ye on 9/16/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *textLbl;

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _textLbl = [[UILabel alloc] init];
    
    _textLbl.text = @"sdakjgauisdguasfduysaruydryasrd7yqrew67e4721834612431256473qwgeuysadkjguasfduafsduyafysyatsdasydfasytdasdky..\nqwigegqweigfqwufeuyqfwuefuqywe81263812835uafdhasfdyaysdfyasfdy\naskdhaiusgdigausif";
    
    
    _textLbl.numberOfLines = 0;
    
    _textLbl.lineBreakMode = NSLineBreakByCharWrapping;
    
    _textLbl.textColor = [UIColor orangeColor];
    _textLbl.font = [UIFont systemFontOfSize:15.0];
    
    
    _textLbl.backgroundColor = [UIColor grayColor];
    
    
    CGFloat textHeight = [self heightForText:_textLbl.text fontSize:15.0];
    
    _textLbl.frame = CGRectMake(10, 20, SCREEN_WIDTH-20, textHeight);
    
    
    [self.view addSubview:_textLbl];
    
}


- (CGFloat)heightForText:(NSString *)text fontSize:(CGFloat)fontSize
{
    
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    return ceilf([text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrbute context:nil].size.height);
}


@end
