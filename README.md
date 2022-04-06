# CZHDatePickerView



![QQ20171120-172055-HD.gif](http://upload-images.jianshu.io/upload_images/6709174-3c504e0da33200a9.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###使用方法很简单，如下就行了

```
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *haveDateLabel;
@end
```

```
- (IBAction)haveDateClick:(id)sender {
    CZHWeakSelf(self);
    [CZHDatePickerView sharePickerViewWithCurrentDate:self.haveDateLabel.text DateBlock:^(NSString *dateString) {
        CZHStrongSelf(self);
        self.haveDateLabel.text = dateString;
    }];
    
}
```


[更多查看blog](http://blog.csdn.net/HurryUpCheng)
