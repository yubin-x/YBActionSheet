//
//  TActionSheet.m
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import "TActionSheet.h"
#import "YBActionSheet.h"


@interface TActionSheet ()



@end

@implementation TActionSheet

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items cancelTitle:(NSString *)cancelTitle
{
    if (self = [super init]) {
        self.actionSheet = [[YBActionSheet alloc] initWithTitle:title message:message items:items cancelTitle:cancelTitle];
        self.actionSheet.numberOfRowsInSection = ^NSInteger(UITableView *tableView, NSInteger section) {
            return items.count;
        };
        self.actionSheet.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            }
            cell.textLabel.text = items[indexPath.row];
            return cell;
        };
        __weak typeof(self) weakSelf = self;
        self.actionSheet.didSelectRowAtIndexPath = ^(UITableView *tableView, NSIndexPath *indexPath) {
            weakSelf.selectdIndex ? weakSelf.selectdIndex(indexPath.row,items[indexPath.row]) : nil;
        };
        self.actionSheet.heightForRowAtIndexPath = ^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 80.0;
        };
//        self.actionSheet.maxHeightRatio = 0.9;
//        self.actionSheet.hideWhenSelectCell = YES;
//        self.actionSheet.hideWhenTapBackView = YES;
//        self.actionSheet.cornerRadius = 10;
//        self.actionSheet.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        
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
