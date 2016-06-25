//
//  ViewControllerDataSource.h
//  HRTableViewModelDemo
//
//  Created by xuhaoran on 16/6/17.
//  Copyright © 2016年 house365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRTableViewModel.h"

@interface ViewControllerDataSource : NSObject
/**
 *  数据转换TableView模型数组
 *
 *  @param data     数据源
 *  @param delegate VC
 *
 *  @return TableView可用的数组
 */
+ (NSArray <HRTableViewModel *> *)reformDataToSectionModelArray:(id)data delegate:(id)delegate;
@end
