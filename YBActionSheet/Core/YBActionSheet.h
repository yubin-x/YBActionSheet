//
//  YBActionSheet.h
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//


/**
 
 YBActionSheet 是 ActionSheet 的功能的核心，他是一个框架。可以支持高度定制的ActionSheet。ActionSheet中的列表是由UITableView来实现的，每一行都是一个UITableViewCell或其子类。所以你只需要自定义自己需要的Cell的样式就可以自定义各种各样的ActionSheet
 */



#import <UIKit/UIKit.h>

@interface YBActionSheet : UIView
/**
 ActionSheet的最大高度与屏幕高度的比例 [0.4,1.0],默认0.8
 */
@property (nonatomic,assign) CGFloat maxHeightRatio;
/**
 ActionSheet的布局边缘留白，只使用到了左右两边的留白，默认UIEdgeInsetsZero
 */
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
/**
 取消按钮标题，为nil时取消按钮不显示
 */
@property (nonatomic,copy)   NSString *cancelTitle;
/**
 标题，为nil时标题视图不显示
 */
@property (nonatomic,copy)   NSString *title;
/**
 消息，为nil时消息视图不显示
 */
@property (nonatomic,copy)   NSString *message;
/**
 选中之后隐藏视图，点击ActionSheet列表中的某一行是否隐藏ActionSheet，默认YES
 */
@property (nonatomic,assign) BOOL hideWhenSelectCell;
/**
 点击背景隐藏视图，点击ActionSheet背景是否隐藏ActionSheet，默认YES
 */
@property (nonatomic,assign) BOOL hideWhenTapBackView;
/**
 视图圆角，ActionSheet的圆角，默认0
 */
@property (nonatomic, assign) CGFloat cornerRadius;


/**
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 */
@property (nonatomic, copy) NSInteger (^numberOfRowsInSection)(UITableView *tableView,NSInteger section);
/**
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy) UITableViewCell* (^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
/**
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy) void(^didSelectRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);
/**
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 */
@property (nonatomic, copy) CGFloat (^heightForRowAtIndexPath)(UITableView *tableView,NSIndexPath *indexPath);

/**
 使用显示列表数据初始化

 @param items 列表数据
 @return 返回实例
 */
- (instancetype)initWithItems:(NSArray *)items;

/**
 使用标题，消息，显示列表数据，取消按钮标题初始化

 @param title 标题，为nil时标题视图不显示
 @param message 消息，为nil时消息视图不显示
 @param items 列表数据
 @param cancelTitle 取消按钮标题，为nil时取消按钮不显示
 @return 返回实例
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items cancelTitle:(NSString *)cancelTitle;

/**
 刷新视图，当初始化之后再设置ActionSheet的属性时要在最后调用此方法来将设置的属性渲染到视图上
 */
- (void)refreshView;

/**
 显示ActionSheet

 @param controller 要显示ActionSheet的视图控制器
 @param animated 是否启用动画
 */
- (void)showInController:(UIViewController *)controller animated:(BOOL)animated;


@end
