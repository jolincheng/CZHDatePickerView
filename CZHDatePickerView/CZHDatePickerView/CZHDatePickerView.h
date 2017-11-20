//
//  CZHDatePickerView.h
//  CZHDatePickerView
//
//  Created by 程召华 on 2017/11/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZHDatePickerView : UIView

/**
 * 创建时间选择器
 * currentDate：传入的时间为默认时间,如果传空，取当前时间
 * dateBlock：时间选择回调
 */
+ (instancetype)sharePickerViewWithCurrentDate:(NSString *)currentDate DateBlock:(void(^)(NSString *dateString))dateBlock;

@end
