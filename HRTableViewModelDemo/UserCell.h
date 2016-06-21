//
//  UserCell.h
//  HRTableViewModelDemo
//
//  Created by xuhaoran on 16/6/21.
//  Copyright © 2016年 house365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell
@property (nonatomic, assign) CGFloat cellHeight;
+ (instancetype)createCellWithTableView:(UITableView *)tableView;
- (void)configCellWithDic:(NSDictionary *)dic;
@end
