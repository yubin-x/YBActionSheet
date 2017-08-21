//
//  TActionSheet.h
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YBActionSheet;
@interface TActionSheet : NSObject

@property (nonatomic, strong) YBActionSheet *actionSheet;
@property (nonatomic, copy)void(^selectdIndex)(NSInteger index,NSString *text);

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items cancelTitle:(NSString *)cancelTitle;
- (void)showInController:(UIViewController *)controller animated:(BOOL)animated;

@end
