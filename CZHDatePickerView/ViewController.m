//
//  ViewController.m
//  CZHDatePickerView
//
//  Created by 程召华 on 2017/11/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "ViewController.h"
#import "CZHDatePickerView.h"
#import "DatePickerHeader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *haveDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *noDateLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (IBAction)haveDateClick:(id)sender {
    CZHWeakSelf(self);
    [CZHDatePickerView sharePickerViewWithCurrentDate:self.haveDateLabel.text DateBlock:^(NSString *dateString) {
        CZHStrongSelf(self);
        self.haveDateLabel.text = dateString;
    }];
    
}

- (IBAction)noDateClick:(id)sender {
    CZHWeakSelf(self);
    [CZHDatePickerView sharePickerViewWithCurrentDate:@"" DateBlock:^(NSString *dateString) {
        CZHStrongSelf(self);
        self.noDateLabel.text = dateString;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
