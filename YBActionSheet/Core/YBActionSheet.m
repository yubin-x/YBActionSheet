//
//  ActionSheet.m
//  ActionSheet
//
//  Created by Caad on 2017/8/16.
//  Copyright © 2017年 Caad. All rights reserved.
//

#import "YBActionSheet.h"


#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define DEFAULT_CELL_HEIGHT 50

@interface UIView (YBFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat midX;
@property (nonatomic, assign) CGFloat midY;
@end

@implementation UIView (YBFrame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setW:(CGFloat)w
{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (void)setH:(CGFloat)h
{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}


- (void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - self.frame.size.width;
    self.frame = frame;
}

-(void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - self.frame.size.height;
    self.frame = frame;
}

-(void)setMidX:(CGFloat)midX
{
    CGRect frame = self.frame;
    frame.origin.x = midX - self.frame.size.width/2;
    self.frame = frame;
}


-(void)setMidY:(CGFloat)midY
{
    CGRect frame = self.frame;
    frame.origin.y = midY - self.frame.size.height/2;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

-(CGFloat)h
{
    return self.frame.size.height;
}

-(CGFloat)maxX
{
    return self.frame.size.width+self.frame.origin.x;
}

-(CGFloat)maxY
{
    return self.frame.size.height+self.frame.origin.y;
}

-(CGFloat)midX
{
    return self.frame.size.width/2+self.frame.origin.x;
}

-(CGFloat)midY
{
    return self.frame.size.height/2+self.frame.origin.y;
}

@end


@interface YBActionSheet ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) BOOL animated;

@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGFloat maxTableViewHeight;
@property (nonatomic, assign) CGFloat tableViewHeight;

@property (nonatomic, strong) UIView *customBgView;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIView *titleAndMessageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation YBActionSheet


- (instancetype)initWithItems:(NSArray *)items
{
    return [self initWithTitle:nil message:nil items:items cancelTitle:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items cancelTitle:(NSString *)cancelTitle;
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]]) {
        self.title = title;
        self.message = message;
        self.dataSource = items;
        self.cancelTitle = cancelTitle;
        [self setDefaultValue];
        [self setViewContent];
    }
    return self;
}


/**
 设置默认值
 */
- (void)setDefaultValue
{
    self.hideWhenSelectCell = YES;
    self.hideWhenTapBackView = YES;
    self.edgeInsets = UIEdgeInsetsZero;
    self.cornerRadius = 0;
    self.maxHeightRatio = 0.8;
}

#pragma mark - getter
- (UIView *)customBgView
{
    if (!_customBgView) {
        _customBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _customBgView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        [self addSubview:_customBgView];
    }
    return _customBgView;
}

- (UIView *)contentBgView
{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentBgView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.0];
        _contentBgView.layer.cornerRadius = self.cornerRadius;
        [self.customBgView addSubview:_contentBgView];
    }
    return _contentBgView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.contentBgView addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)titleAndMessageView
{
    if (!_titleAndMessageView) {
        _titleAndMessageView = [[UIView alloc] initWithFrame:CGRectZero];
        _titleAndMessageView.backgroundColor = [UIColor whiteColor];
        [self.contentBgView addSubview:_titleAndMessageView];
    }
    return _titleAndMessageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self.titleAndMessageView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.numberOfLines = 0;
        [self.titleAndMessageView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.cornerRadius = self.cornerRadius;
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.customBgView addSubview:_cancelButton];
    }
    return _cancelButton;
}

#pragma mark - button action

- (void)cancelButtonAction
{
    [self hideAnimated:self.animated];
}

#pragma mark - setter
-(void)setMaxHeightRatio:(CGFloat)maxHeightRatio
{
    _maxHeightRatio = maxHeightRatio;
//    [self setViewContent];
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
//    [self setViewContent];
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    _cancelTitle = cancelTitle;
//    [self setViewContent];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
//    [self setViewContent];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
//    [self setViewContent];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
//    [self setViewContent];
}

#pragma mark - set view
- (void)setViewContent
{
    self.customBgView.frame = CGRectMake(self.edgeInsets.left, 0, SCREEN_WIDTH - self.edgeInsets.left - self.edgeInsets.right, 0);
    
    CGFloat titleHeight = 0.0,messageHeight = 0.0;
    // 标题
    if (self.title && self.title.length > 0)
    {
        self.titleLabel.frame = CGRectMake(0, 10, self.customBgView.w, 30);
        self.titleLabel.text = self.title;
        titleHeight = 50;
    }
    else
    {
        self.titleLabel.frame = CGRectMake(0, 0, self.customBgView.w, 0);
        titleHeight = 0;
    }
    
    // 消息
    if (self.message && self.message.length > 0)
    {
        CGFloat textHeight = [self heightOfText:self.message withWidth:self.customBgView.w-20 fontSize:13];
        
        self.messageLabel.frame = CGRectMake(10, self.titleLabel.maxY + 10, self.customBgView.w - 20, textHeight);
        self.messageLabel.text = self.message;
        messageHeight = textHeight + 20;
    }
    else
    {
        self.messageLabel.frame = CGRectMake(10, self.titleLabel.maxY + 10, self.customBgView.w - 20, 0);
        messageHeight = 0;
    }
    
    self.titleAndMessageView.frame = CGRectMake(0, 0, self.customBgView.w, titleHeight + messageHeight);
    
    self.customBgView.h = self.titleAndMessageView.h;
    
    // tableView
    self.tableView.frame = CGRectMake(0, self.titleAndMessageView.maxY, self.customBgView.w, 0);
    
    // 如果设置的actionsheet的高度小于0.1倍的屏幕高度，默认使用0.8倍的屏幕高度。如果大于屏幕的高度则使用屏幕的高度
    self.maxHeight = SCREEN_HEIGHT *(self.maxHeightRatio > 0.4 ? (self.maxHeightRatio > 1.0 ? 1.0 : self.maxHeightRatio) : 0.8);
    
    // tableView的最大高度
    self.maxTableViewHeight = self.maxHeight - self.titleAndMessageView.h;
    
    // 有取消按钮时候tableView的最大高度要减去取消按钮占用的空间
    if (self.cancelTitle && self.cancelTitle.length > 0)
    {
        self.maxTableViewHeight -= 70;
    }
    
    // 获取Cell的高度
    CGFloat cellHeight = DEFAULT_CELL_HEIGHT;
    if (self.heightForRowAtIndexPath)
    {
        cellHeight = self.heightForRowAtIndexPath(self.tableView,[NSIndexPath indexPathForRow:0 inSection:0]);
    }
    
    // 根据数据数量和最大tableView的高度的限制来确定tableView的高度
    if (self.dataSource.count * cellHeight > self.maxTableViewHeight)
    {
        self.tableViewHeight = self.maxTableViewHeight;
        self.tableView.scrollEnabled = YES;
    }
    else
    {
        self.tableViewHeight = self.dataSource.count * cellHeight;
        self.tableView.scrollEnabled = NO;
    }
    
    self.tableView.h = self.tableViewHeight;
    self.customBgView.h += self.tableViewHeight;
    
    self.contentBgView.frame = CGRectMake(0, 0, self.customBgView.w, self.titleAndMessageView.h + self.tableView.h);
    
    if (self.cancelTitle && self.cancelTitle.length > 0)
    {
        self.cancelButton.frame = CGRectMake(0, self.contentBgView.maxY + 10,  self.customBgView.w, 50);
        [self.cancelButton setTitle:self.cancelTitle forState:UIControlStateNormal];
        self.customBgView.h += 70;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

/**
 设置完所有属性之后再刷新一遍视图，让设置的属性生效
 */
- (void)refreshView
{
    [self setViewContent];
}

/**
 指定可以响应触摸事件的视图
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]])
    {
        return YES;
    }
    return NO;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    if (self.hideWhenTapBackView)
    {
        [self hideAnimated:self.animated];
    }
}

- (void)showInController:(UIViewController *)controller animated:(BOOL)animated
{
    if (controller)
    {
        [controller.view addSubview:self];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    }
    
    self.customBgView.y = SCREEN_HEIGHT;
    self.animated = animated;
    [self showAnimated:animated];
}

- (void)showAnimated:(BOOL)animated
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.customBgView.alpha = 0;
    
    CGFloat duration = animated ? 0.3 : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.customBgView.alpha = 1;
        
        CGRect frame = self.customBgView.frame;
        frame.origin.y = SCREEN_HEIGHT - frame.size.height;
        self.customBgView.frame = frame;
        [self.tableView reloadData];
    }];
}

- (void)hideAnimated:(BOOL)animated
{
    CGFloat duration = animated ? 0.2 : 0.0;
    
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.customBgView.alpha = 0;
        CGRect frame = self.customBgView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        self.customBgView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRowsInSection ? self.numberOfRowsInSection(tableView,section) : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    return self.cellForRowAtIndexPath ? self.cellForRowAtIndexPath(tableView,indexPath) : cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelectRowAtIndexPath ? self.didSelectRowAtIndexPath(tableView,indexPath) : nil;
    
    if (self.hideWhenSelectCell) {
        [self hideAnimated:self.animated];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heightForRowAtIndexPath ? self.heightForRowAtIndexPath(tableView,indexPath) : 0.0;
}

-(void)layoutSubviews
{
    CALayer *bottomLayer = [[CALayer alloc] init];
    bottomLayer.frame = CGRectMake(0, _titleAndMessageView.h - 0.5, _titleAndMessageView.w, 0.5);
    bottomLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [_titleAndMessageView.layer addSublayer:bottomLayer];
    
    _cancelButton.layer.cornerRadius = self.cornerRadius;
    _contentBgView.layer.cornerRadius = self.cornerRadius;
    _contentBgView.clipsToBounds = YES;
}


/**
 计算文本的高度

 @param str 文本
 @param width 指定的宽度
 @param fontSize 字体大小
 @return 返回高度
 */
- (CGFloat)heightOfText:(NSString *)str withWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect r = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return r.size.height;
}


@end
