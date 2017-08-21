//
//  ViewController.m
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import "ViewController.h"
#import "PActionSheet.h"
#import "PTActionSheet.h"
#import "TActionSheet.h"
#import "YBActionSheet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTf;
@property (weak, nonatomic) IBOutlet UITextField *messageTf;
@property (weak, nonatomic) IBOutlet UITextField *cancelTitleTf;
@property (weak, nonatomic) IBOutlet UITextField *topTf;
@property (weak, nonatomic) IBOutlet UITextField *leftTf;
@property (weak, nonatomic) IBOutlet UITextField *bottomTf;
@property (weak, nonatomic) IBOutlet UITextField *rightTf;
@property (weak, nonatomic) IBOutlet UITextField *cornerRadiusTf;
@property (weak, nonatomic) IBOutlet UISlider *maxHeightRaitoslider;
@property (weak, nonatomic) IBOutlet UISwitch *hideWhenTapBg;
@property (weak, nonatomic) IBOutlet UISwitch *hideWhenSelectCell;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)PActionSheetBtnAction:(id)sender
{
    UIImage *image1 = [UIImage imageNamed:@"icon_daiban_2.png"];
    UIImage *image2 = [UIImage imageNamed:@"icon_gongzuo_2.png"];
    UIImage *image3 = [UIImage imageNamed:@"icon_wo_2.png"];
    UIImage *image4 = [UIImage imageNamed:@"icon_xiaoxi_2.png"];
    
    UIImage *image11 = [UIImage imageNamed:@"icon_daiban_2.png"];
    UIImage *image21 = [UIImage imageNamed:@"icon_gongzuo_2.png"];
    UIImage *image31 = [UIImage imageNamed:@"icon_wo_2.png"];
    UIImage *image41 = [UIImage imageNamed:@"icon_xiaoxi_2.png"];
    
    UIImage *image12 = [UIImage imageNamed:@"icon_daiban_2.png"];
    UIImage *image22 = [UIImage imageNamed:@"icon_gongzuo_2.png"];
    UIImage *image32 = [UIImage imageNamed:@"icon_wo_2.png"];
    UIImage *image42 = [UIImage imageNamed:@"icon_xiaoxi_2.png"];
    
    NSArray *images = @[image1,image2,image3,image4,image11,image21,image31,image41,image12,image22,image32,image42];
    
    PActionSheet *actionSheet = [[PActionSheet alloc] initWithTitle:nil message:nil images:images cancelTitle:nil];
    
    // 设置页面上设置的属性值
    [self setPropertiesOf:actionSheet.actionSheet];
    [actionSheet showInController:self animated:YES];

}
- (IBAction)TActionSheetBtnAction:(id)sender
{
    TActionSheet *actionSheet = [[TActionSheet alloc] initWithTitle:nil message:nil items:@[@"求真",@"极致",@"拥抱",@"必然"] cancelTitle:nil];
    
    // 设置页面上设置的属性值
    [self setPropertiesOf:actionSheet.actionSheet];
    [actionSheet showInController:self animated:YES];
}
- (IBAction)PTActionSheetBtnAction:(id)sender
{
    PTModel *model1 = [[PTModel alloc] init];
    model1.image = [UIImage imageNamed:@"icon_daiban_2.png"];
    model1.text = @"代办";
    
    PTModel *model2 = [[PTModel alloc] init];
    model2.image = [UIImage imageNamed:@"icon_gongzuo_2.png"];
    model2.text = @"工作";
    
    PTModel *model3 = [[PTModel alloc] init];
    model3.image = [UIImage imageNamed:@"icon_xiaoxi_2.png"];
    model3.text = @"消息";
    
    PTModel *model4 = [[PTModel alloc] init];
    model4.image = [UIImage imageNamed:@"icon_wo_2.png"];
    model4.text = @"我的";
    
    NSArray *models = @[model1,model2,model3,model4];
    
    PTActionSheet *actionSheet = [[PTActionSheet alloc] initWithTitle:@"图片文字" message:@"图片和文字混排" models:models cancelTitle:@"我是取消按钮"];
    
    // 设置页面上设置的属性值
    [self setPropertiesOf:actionSheet.actionSheet];
    [actionSheet showInController:self animated:YES];
}

// 总得有一个地方点击可以dimiss
- (IBAction)switchAction:(UISwitch *)sender
{
    if (sender == _hideWhenTapBg) {
        [_hideWhenSelectCell setOn:!sender.isOn animated:YES];
    }
    else
    {
        [_hideWhenTapBg setOn:!sender.isOn animated:YES];
    }
}

- (void)setPropertiesOf:(YBActionSheet *)actionSheet
{
    actionSheet.title = self.titleTf.text ? self.titleTf.text : nil;
    actionSheet.message = self.messageTf.text ? self.messageTf.text : nil;
    actionSheet.cancelTitle = self.cancelTitleTf.text ? self.cancelTitleTf.text : nil;
    actionSheet.edgeInsets = UIEdgeInsetsMake([self.topTf.text floatValue], [self.leftTf.text floatValue], [self.bottomTf.text floatValue], [self.rightTf.text floatValue]);
    actionSheet.cornerRadius = [self.cornerRadiusTf.text floatValue];
    actionSheet.maxHeightRatio = self.maxHeightRaitoslider.value;
    actionSheet.hideWhenTapBackView = self.hideWhenTapBg.isOn;
    actionSheet.hideWhenSelectCell = self.hideWhenSelectCell.isOn;
    [self resignFirstResponderOfTf];
}


- (void)resignFirstResponderOfTf
{
    NSArray *subviews = [self.bgView subviews];
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [subview resignFirstResponder];
        }
    }
}

- (IBAction)tapGestureAction:(id)sender
{
    [self resignFirstResponderOfTf];
}
@end
