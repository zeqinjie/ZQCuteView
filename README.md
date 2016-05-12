
###ZQCuteView
基于UITextView，增加placeholder功能，增加限制text的输入字数功能

如何使用：

使用CocoaPods:

platform :ios, '7.0'
pod 'ZQCuteView'
***
<pre>
导入头文件：
#import "ZQCuteView.h"
申明变量：

@property (nonatomic, strong) ZQCuteView *zqCuteView;
根据需求实现对应功能：

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView{
    self.zqCuteView = [[ZQCuteView alloc]initWithPoint: CGPointMake(self.view.frame.size.width - 70, self.view.frame.size.height - 70) superView:self.view bubbleWidth:55 pic:[UIImage imageNamed:@"icon_Close_off_110"]color:[UIColor yellowColor]];
    [self.zqCuteView setZqCuteViewAlpha:0.9];
    self.zqCuteView.isOpenStickAnm = YES;
    self.zqCuteView.isShowShakeAnmation = YES;
    self.zqCuteView.tapCallBack = ^(void){
        NSLog(@"hello zzq");
    };
}
</pre>
***
###协议（Licenses）

ZQCuteView 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。
