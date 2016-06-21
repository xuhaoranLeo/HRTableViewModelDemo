//
//  ViewController.m
//  HRTableViewModelDemo
//
//  Created by xuhaoran on 16/6/17.
//  Copyright © 2016年 house365. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerDataSource.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionModelArray;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HRTableViewModel *model = self.sectionModelArray[section];
    return model.cellModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HRTableViewModel *model = self.sectionModelArray[indexPath.section];
    HRTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
    return cellModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HRTableViewModel *model = self.sectionModelArray[indexPath.section];
    HRTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
    return cellModel.configCellBlock(indexPath, tableView);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HRTableViewModel *model = self.sectionModelArray[indexPath.section];
    HRTableViewCellModel *cellModel = model.cellModelArray[indexPath.row];
    cellModel.selectCellBlock(indexPath, tableView);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    HRTableViewModel *model = self.sectionModelArray[section];
    return model.headerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HRTableViewModel *model = self.sectionModelArray[section];
    return model.headerViewBlock(section, tableView);
}

#pragma mark - event response
- (void)buttonAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"This is ViewController Method!!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了！" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HRTableViewModel *model = self.sectionModelArray[section];
    return model.headerHeight;
}

#pragma mark - getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (NSArray *)sectionModelArray {
    if (_sectionModelArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"plist"];
        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:path];
        ViewControllerDataSource *dataSource = [[ViewControllerDataSource alloc] init];
        dataSource.delegate = self;
        _sectionModelArray = [dataSource reformDataToSectionModelArray:data];
    }
    return _sectionModelArray;
}

@end
