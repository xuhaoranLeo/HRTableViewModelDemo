//
//  HRTableViewModel.m
//  TaoFang
//
//  Created by xuhaoran on 16/6/2.
//  Copyright © 2016年 House365. All rights reserved.
//

#import "HRTableViewModel.h"

@implementation HRTableViewCellModel
- (instancetype)init {
    if (self = [super init]) {
        self.cellHeight = UITableViewAutomaticDimension;
        [self setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
        }];
    }
    return self;
}
@end

@implementation HRTableViewModel
- (instancetype)init {
    if (self = [super init]) {
        self.cellModelArray = [NSMutableArray array];
        self.headerHeight = UITableViewAutomaticDimension;
        self.footerHeight = UITableViewAutomaticDimension;
        [self setHeaderViewBlock:^UIView *(NSInteger section, UITableView *tableView) {
            return nil;
        }];
        [self setFooterViewBlock:^UIView *(NSInteger section, UITableView *tableView) {
            return nil;
        }];
    }
    return self;
}
@end
