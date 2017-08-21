//
//  PActionSheet.m
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import "PActionSheet.h"
#import "YBActionSheet.h"


@interface PActionSheetCell : UITableViewCell

@property (strong, nonatomic) UIImageView *contentImageView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation PActionSheetCell

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
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.separatorInset = UIEdgeInsetsZero;
    
    self.contentImageView = [[UIImageView alloc] init];
    self.contentImageView.frame = CGRectMake(5, 5, self.frame.size.width-10,self.frame.size.height-10);
    self.contentImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.contentImageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.contentImageView.frame = CGRectMake(5, 5, self.frame.size.width-10,self.frame.size.height-10);
}

@end


@interface PActionSheet ()

@end

@implementation PActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message images:(NSArray *)images cancelTitle:(NSString *)cancelTitle
{
    if (self = [super init]) {
        
        self.actionSheet = [[YBActionSheet alloc] initWithTitle:title message:message items:images cancelTitle:cancelTitle];
        
        self.actionSheet.numberOfRowsInSection = ^NSInteger(UITableView *tableView, NSInteger section) {
            return images.count;
        };
        self.actionSheet.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            
            PActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PActionSheetCell"];
            if (!cell) {
                cell = [[PActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PActionSheetCell"];
            }
            cell.contentImageView.image = images[indexPath.row];
            return cell;
        };
        
        __weak typeof(self) weakSelf = self;
        self.actionSheet.didSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
            weakSelf.selectdIndex ? weakSelf.selectdIndex(indexPath.row,images[indexPath.row]) : nil;
        };
        
        self.actionSheet.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 80.0;
        };
//        self.actionSheet.maxHeightRatio = 0.9;
//        self.actionSheet.hideWhenSelectCell = YES;
//        self.actionSheet.hideWhenTapBackView = YES;
//        self.actionSheet.cornerRadius = 10;
//        self.actionSheet.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
//        
//        [self.actionSheet refreshView];
    }
    return self;
}

- (void)showInController:(UIViewController *)controller animated:(BOOL)animated
{
    [self.actionSheet refreshView];
    [self.actionSheet showInController:controller animated:animated];
}
@end
