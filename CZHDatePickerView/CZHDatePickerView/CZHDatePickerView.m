//
//  CZHDatePickerView.m
//  CZHDatePickerView
//
//  Created by 程召华 on 2017/11/20.
//  Copyright © 2017年 程召华. All rights reserved.
//
#import "DatePickerHeader.h"
#import "CZHDatePickerView.h"
#import "UIButton+CZHExtension.h"



#define TOOLBAR_BUTTON_WIDTH CZH_ScaleWidth(65)
#define FORMAT @"yyyy-MM-dd"
typedef NS_ENUM(NSInteger, CZHDatePickerViewButtonType) {
    CZHDatePickerViewButtonTypeCancle,
    CZHDatePickerViewButtonTypeSure
};

#import "CZHDatePickerView.h"

@interface CZHDatePickerView ()
///容器view
@property (nonatomic, weak) UIView *containView;
///pickerView
@property (nonatomic, weak) UIDatePicker *datePickerView;
///时间回调
@property (nonatomic, copy) void (^dateBlock)(NSString *dateString);
//传进来的时间
@property (nonatomic, strong) NSString *currentDate;
@end

static CZHDatePickerView *_view = nil;
@implementation CZHDatePickerView


+ (instancetype)sharePickerViewWithCurrentDate:(NSString *)currentDate DateBlock:(void (^)(NSString *))dateBlock {
    
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    _view = [[CZHDatePickerView alloc] init];
    //    });
    _view.dateBlock = dateBlock;
    _view.currentDate = currentDate;
    //设置时间
    [_view czh_setDate];
    //显示view
    [_view czh_showView];
    return _view;
}


- (instancetype)init {
    if (self = [super init]) {
        
        [self czh_setView];
        
    }
    return self;
}


- (void)czh_setView {
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, CZH_ScaleHeight(270));
    [self addSubview:containView];
    self.containView = containView;
    
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, CZH_ScaleHeight(55));
    toolBar.backgroundColor = CZHColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancleButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHColor(0x666666) titleFont:CZHGlobelNormalFont(18) title:@"取消"];
    cancleButton.tag = CZHDatePickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    UIButton *sureButton = [UIButton czh_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.czh_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.czh_height) titleColor:CZHThemeColor titleFont:CZHGlobelNormalFont(18) title:@"确定"];
    sureButton.tag = CZHDatePickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
    datePickerView.backgroundColor = CZHColor(0xffffff);
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.frame = CGRectMake(0, toolBar.czh_bottom, ScreenWidth, containView.czh_height - toolBar.czh_height);
    [datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [containView addSubview:datePickerView];
    self.datePickerView = datePickerView;
    
}

- (void)czh_setDate {
    
    NSDate *maxDate = [NSDate date];
    self.datePickerView.maximumDate = maxDate;
    
    if (self.currentDate.length <=0 || [self.currentDate containsString:@"00"]) {//如果没有初始时间用当前时间
        self.datePickerView.date = maxDate;
    } else {//用传入的时间代替
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:FORMAT];
        NSDate *date = [dateFormatter dateFromString:self.currentDate];
        self.datePickerView.date = date;
    }
}

- (void)dateChanged:(UIDatePicker *)pickerView {
    NSLog(@"===%@", pickerView.date);
}

- (void)buttonClick:(UIButton *)sender {
    
    [self czh_hideView];
    
    if (sender.tag == CZHDatePickerViewButtonTypeSure) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:FORMAT];
        NSString *strDate = [dateFormatter stringFromDate:self.datePickerView.date];
        
        if (_dateBlock) {
            _dateBlock(strDate);
        }
    }
}

//显示
- (void)czh_showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = CZHRGBColor(0x000000, 0.3);
        self.containView.czh_bottom = ScreenHeight;
    }];
}

//隐藏
- (void)czh_hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.czh_y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
