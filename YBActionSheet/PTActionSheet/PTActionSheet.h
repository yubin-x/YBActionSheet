//
//  PTActionSheet.h
//  YBActionSheet
//
//  Created by Yubin on 2017/8/16.
//  Copyright © 2017年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - PTModel
@interface PTModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *text;

@end

#pragma mark - PTActionSheet
@class YBActionSheet;
@interface PTActionSheet : NSObject

@property (nonatomic, strong) YBActionSheet *actionSheet;
@property (nonatomic, copy)void(^selectdIndex)(NSInteger index,PTModel *model);

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message models:(NSArray<PTModel *>*)models cancelTitle:(NSString *)cancelTitle;
- (void)showInController:(UIViewController *)controller animated:(BOOL)animated;

@end



