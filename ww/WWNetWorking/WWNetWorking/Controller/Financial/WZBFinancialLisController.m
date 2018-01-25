//
//  WZBFinancialLisController.m
//  WWNetWorking
//
//  Created by wangwei on 2018/1/25.
//  Copyright © 2018年 wangwei-WW. All rights reserved.
//


#import "WZBFinancialLisController.h"
#import <MJRefresh/MJRefresh.h>
#import "WZBFinanceListAPIManager.h"
#import "WZBFinancialListTableViewCell.h"
#import "WZBFinancialListRepaymentCell.h"

NSString * const kWZBFinancialCellReuseIdentifier = @"kWZBFinancialCellReuseIdentifier";
NSString * const kWZBFinancialCellReuseIdentifier1 = @"kWZBFinancialCellReuseIdentifier1";

@interface WZBFinancialLisController ()<AZAPIManagerParamSourceDelegate, AZAPIManagerAPICallBackDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) WZBFinanceListAPIManager *financialListAPIManager;

@property (nonatomic, strong) NSMutableArray *wzbList;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isLoadMore;

@end

@implementation WZBFinancialLisController

//- (instancetype)init {
//    self = [super init];
//
//    if (self) {
//        self.title = @"理财产品";//BZ_tabbar_licai
//        [self configImagesWithTabBarItem:@"BZ_tabbar_financial"];
//    }
//
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initViewConfigurations];
    
}
- (void)initViews {//初始化的一些东西
    [self.view addSubview:self.tableView];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.view = nil;
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)fresh {
    [self.financialListAPIManager loadNewData];//请求理财产品的接口
}
//
#pragma mark - actions
- (void)fetchFinancialList {
    self.isLoadMore = NO;
    [self showHUD];
    
    [self.financialListAPIManager loadNewData];
}
- (void)fetchMoreMessageList {
    self.isLoadMore = YES;
    [self showHUD];
    [self.financialListAPIManager loadNextPage];
}
#pragma mark - private
- (void)configTableFooterView {
    if (!self.tableView.footer) {
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchMoreMessageList)];
    }
}
- (void)initViewConfigurations {
    self.view.backgroundColor = KGroundGeneral;
    self.tableView.backgroundColor = KGroundGeneral;
    WZBMyTitleView *title = [self createTitle:17 color:Kniv titileStr:@"理财产品"];
    self.navigationItem.titleView = title;
    
    [self fetchFinancialList];//网络请求
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wzbList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {//cell的配置
    if(self.wzbList.count >0) {
        NSDictionary *dic = self.wzbList[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"Zt"]];
        if ([str isEqualToString:@"2"]) {
            WZBFinancialListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWZBFinancialCellReuseIdentifier forIndexPath:indexPath];
            // 设置cell的选中时的背景视图
            UIView *purpleView = [[UIView alloc] init]; //选中时作为背景会铺满cell
            purpleView.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = purpleView;
            NSDictionary *record = self.wzbList[indexPath.row];
            [cell configData:record];
            
            return cell;
        }  else {
            WZBFinancialListRepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:kWZBFinancialCellReuseIdentifier1 forIndexPath:indexPath];
            NSDictionary *record = self.wzbList[indexPath.row];
            [cell configData:record];
            
            return cell;
        }
    }else {
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.wzbList.count >0) {
        NSDictionary *dic = self.wzbList[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"Zt"]];
        if ([str isEqualToString:@"2"]) {
            return 220.0;
        } else {
            return 150.0;
        }
    } else {
        return 44.4;
    }
}
#pragma mark - AZAPIManagerParamSourceDelegate

- (NSDictionary *)paramsForAPI:(AZAPIBaseManager *)manager {
    return @{@"userid": @"", @"ticket": @""};
}

#pragma mark - AZAPIManagerAPICallBackDelegate
- (void)managerCallAPIDidFailed:(AZAPIBaseManager *)manager {
    [self hideHUD];
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

- (void)managerCallAPIDidSuccess:(AZAPIBaseManager *)manager {
    [self hideHUD];
    if (manager == self.financialListAPIManager) {
        NSDictionary *data = [manager fetchDataWithReformer:nil];
        NSArray *list = data[@"List"];
        if (!self.isLoadMore) {
            [self.wzbList removeAllObjects];
            [self.tableView reloadData];
        }
        if ([list isKindOfClass:[NSArray class]] && list.count > 0) {
            [self.wzbList addObjectsFromArray:list];
        }
        if (self.wzbList.count >= 10) {
            [self configTableFooterView];
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (self.wzbList.count>0) {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - getter
- (WZBFinanceListAPIManager *)financialListAPIManager {
    if (!_financialListAPIManager) {
        _financialListAPIManager = [[WZBFinanceListAPIManager alloc] init];
        _financialListAPIManager.paramSource = self;
        _financialListAPIManager.delegate = self;
    }
    
    return _financialListAPIManager;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT-64-49-10) style:UITableViewStylePlain];
        _tableView.backgroundColor = KGroundGeneral;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WZBFinancialListTableViewCell class] forCellReuseIdentifier:kWZBFinancialCellReuseIdentifier];
        [_tableView registerClass:[WZBFinancialListRepaymentCell class] forCellReuseIdentifier:kWZBFinancialCellReuseIdentifier1];
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchFinancialList)];
    }
    return _tableView;
}
- (NSMutableArray *)wzbList {
    if(!_wzbList) {
        _wzbList = [NSMutableArray array];
    }
    return _wzbList;//储存数据的数组
}
@end
