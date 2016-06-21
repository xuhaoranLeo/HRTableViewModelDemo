//
//  ViewControllerDataSource.m
//  HRTableViewModelDemo
//
//  Created by xuhaoran on 16/6/17.
//  Copyright © 2016年 house365. All rights reserved.
//

#import "ViewControllerDataSource.h"
#import "UserCell.h"
#import "ViewController.h"

#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)

typedef NS_ENUM(NSUInteger, ViewControllerSectionType) {
    ViewControllerSectionTypeUser,
    ViewControllerSectionTypeSport,
    ViewControllerSectionTypeFavortiteFood,
};

@interface ViewControllerDataSource ()
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSArray *sectionTypeArray;
@property (nonatomic, strong) NSMutableArray <HRTableViewModel *> *sectionModelArray;
@end

@implementation ViewControllerDataSource

#pragma mark - Config CellModelArray
- (NSArray <HRTableViewCellModel *> *)reformDataToSectionModelArray:(id)data {
    [self.sectionModelArray removeAllObjects];
    self.dataDic = (NSDictionary *)data;
    for (NSNumber *type in self.sectionTypeArray) {
        switch (type.integerValue) {
            case ViewControllerSectionTypeUser: {
                [self configUserCellModel];
            }
                break;
            case ViewControllerSectionTypeSport: {
                [self configSportCellModel];
            }
                break;
            case ViewControllerSectionTypeFavortiteFood: {
                [self configFavoriteFoodCellModel];
            }
                break;
            default:
                break;
        }
    }
    return [self.sectionModelArray copy];
}

#pragma mark UserCellModel
- (void)configUserCellModel {
    HRTableViewModel *sectionModel = [[HRTableViewModel alloc] init];
    [sectionModel setHeaderTitle:@"用户信息"];
    [self.sectionModelArray addObject:sectionModel];
    HRTableViewCellModel *cellModel = [[HRTableViewCellModel alloc] init];
    [cellModel setConfigCellBlock:^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        __weak typeof(&*self) weakSelf = self;
        UserCell *cell = (UserCell *)[weakSelf configUserCell:tableView indexPath:indexPath];
        return cell;
    }];
    [cellModel setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
        __weak typeof(&*self) weakSelf = self;
        ViewController *vc = [[ViewController alloc] init];
        [((ViewController *)weakSelf.delegate).navigationController pushViewController:vc animated:YES];
    }];
    [sectionModel.cellModelArray addObject:cellModel];
}

- (UITableViewCell *)configUserCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:nil options:nil].firstObject;
    }
    [cell configCellWithDic:self.dataDic[@"UserInfo"]];
    HRTableViewModel *model = self.sectionModelArray[indexPath.section];
    HRTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
    cellModel.cellHeight = cell.cellHeight;
    return cell;
}

#pragma mark SportCellModel
- (void)configSportCellModel {
    HRTableViewModel *sectionModel = [[HRTableViewModel alloc] init];
    [sectionModel setHeaderViewBlock:^UIView *(NSInteger section, UITableView *tableView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 150, 30)];
        label.text = @"喜好运动";
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        return view;
    }];
    sectionModel.headerHeight = 30;
    [self.sectionModelArray addObject:sectionModel];
    HRTableViewCellModel *cellModel;
    for (NSString *sportName in self.dataDic[@"SportList"]) {
        cellModel = [[HRTableViewCellModel alloc] init];
        cellModel.cellHeight = 40;
        [cellModel setConfigCellBlock:^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SportCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SportCell"];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%li. %@", indexPath.row+1, sportName];
            return cell;
        }];
        [cellModel setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
            NSLog(@"%@", sportName);
        }];
        [sectionModel.cellModelArray addObject:cellModel];
    }
}

#pragma mark FavoriteFoodCellModel
- (void)configFavoriteFoodCellModel {
    HRTableViewModel *sectionModel = [[HRTableViewModel alloc] init];
    [sectionModel setHeaderViewBlock:^UIView *(NSInteger section, UITableView *tableView) {
        __weak typeof(&*self) weakSelf = self;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 150, 30)];
        label.text = @"喜爱食物";
        label.textColor = [UIColor orangeColor];
        [view addSubview:label];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100-12, 0, 100, 30);
        [button setTitle:@"点我点我！" forState:UIControlStateNormal];
        [button addTarget:weakSelf.delegate action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;
    }];
    sectionModel.headerHeight = 30;
    [self.sectionModelArray addObject:sectionModel];
    HRTableViewCellModel *cellModel;
    for (NSString *FavoriteFoodName in self.dataDic[@"FavoriteFoodList"]) {
        cellModel = [[HRTableViewCellModel alloc] init];
        cellModel.cellHeight = 40;
        [cellModel setConfigCellBlock:^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteFoodCell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FavoriteFoodCell"];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%li. %@", indexPath.row+1, FavoriteFoodName];
            return cell;
        }];
        [cellModel setSelectCellBlock:^(NSIndexPath *indexPath, UITableView *tableView) {
            NSLog(@"%@", FavoriteFoodName);
        }];
        [sectionModel.cellModelArray addObject:cellModel];
    }
}

- (void)buttonAction {
    NSLog(@"data source");
}


#pragma mark - getter 
- (NSArray *)sectionTypeArray {
    if (_sectionTypeArray == nil) {
        _sectionTypeArray = @[@(ViewControllerSectionTypeUser),
                              @(ViewControllerSectionTypeSport),
                              @(ViewControllerSectionTypeFavortiteFood)];
    }
    return _sectionTypeArray;
}

- (NSMutableArray<HRTableViewModel *> *)sectionModelArray {
    if (_sectionModelArray == nil) {
        _sectionModelArray = [NSMutableArray array];
    }
    return _sectionModelArray;
}
@end
