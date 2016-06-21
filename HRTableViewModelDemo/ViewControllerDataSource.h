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
- (NSArray <HRTableViewModel *> *)reformDataToSectionModelArray:(id)data;
@property (nonatomic, weak) id delegate;
@end
