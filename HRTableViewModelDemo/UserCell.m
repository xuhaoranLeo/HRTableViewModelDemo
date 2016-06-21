//
//  UserCell.m
//  HRTableViewModelDemo
//
//  Created by xuhaoran on 16/6/21.
//  Copyright © 2016年 house365. All rights reserved.
//

#import "UserCell.h"

@interface UserCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation UserCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)configCellWithDic:(NSDictionary *)dic {
    self.nameLabel.text = dic[@"name"];
    self.ageLabel.text = dic[@"age"];
    self.heightLabel.text = dic[@"height"];
    self.descLabel.text = dic[@"desc"];
    CGRect rect = self.contentView.frame;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    self.contentView.frame = rect;
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.cellHeight = CGRectGetMaxY(self.descLabel.frame)+8;
}

@end
