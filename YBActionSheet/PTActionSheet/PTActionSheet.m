//
//  PTActionSheet.m
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import "PTActionSheet.h"
#import "YBActionSheet.h"



#pragma mark - PTActionSheetCell
@interface PTActionSheetCell : UITableViewCell
@property (strong, nonatomic) UIImageView *selectFlag;
@property (strong, nonatomic) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation PTActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setContentView];
    }
    return self;
}

- (void)setContentView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.selectFlag = [[UIImageView alloc] init];
    self.selectFlag.frame = CGRectMake(0, 0, self.frame.size.height,self.frame.size.height );
    self.selectFlag.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.selectFlag];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width - 2*self.frame.size.height, self.frame.size.height)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor     = [UIColor darkGrayColor];
    self.titleLabel.font          = [UIFont systemFontOfSize:15.f];
    [self.contentView addSubview:self.titleLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.selectFlag.frame = CGRectMake(0, 0, self.frame.size.height,self.frame.size.height);
    self.titleLabel.frame = CGRectMake(self.frame.size.height, 0, self.frame.size.width - 2*self.frame.size.height, self.frame.size.height);
}

@end

#pragma mark - PTModel ---------------------------------
@implementation PTModel
@end


#pragma mark - PTActionSheet ---------------------------

@implementation PTActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message models:(NSArray<PTModel *>*)models cancelTitle:(NSString *)cancelTitle
{
    if (self = [super init]) {
        
        
        self.actionSheet = [[YBActionSheet alloc] initWithTitle:title message:message items:models cancelTitle:cancelTitle];
        
        self.actionSheet.numberOfRowsInSection = ^NSInteger(UITableView *tableView, NSInteger section) {
            return models.count;
        };
        self.actionSheet.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            PTActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTActionSheetCell"];
            if (!cell) {
                cell = [[PTActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PTActionSheetCell"];
            }
            
            PTModel *model = models[indexPath.row];
            
            cell.titleLabel.text = model.text;
            cell.selectFlag.image = model.image;
            return cell;
        };
        
        __weak typeof(self) weakSelf = self;
        self.actionSheet.didSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
            weakSelf.selectdIndex ? weakSelf.selectdIndex(indexPath.row, models[indexPath.row]) : nil;
        };
        
        self.actionSheet.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 50.0;
        };
        
//        self.actionSheet.maxHeightRatio = 0.8;
//        self.actionSheet.hideWhenTapBackView = YES;
//        self.actionSheet.hideWhenSelectCell = YES;
//        self.actionSheet.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
//        self.actionSheet.cornerRadius = 10;
//        [self.actionSheet refreshView];
    }
    return self;
}
- (void)showInController:(UIViewController *)controller animated:(BOOL)animated
{
    [self.actionSheet refreshView];
    [self.actionSheet showInController:controller animated:YES];
}

@end




