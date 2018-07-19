//
//  JRJLargePlateMovementController.m
//  FounderscDemo
//  QQ:583019812
//  Created by jrj on 2018/6/15.
//  Copyright © 2018年 JRJ. All rights reserved.
//

#import "JRJLargePlateMovementController.h"
#import "JRJIndexPlateExchangeCell.h"
#import "Enumeration.h"
#import "JRJTransactionLineView.h"
#import "MJRefresh.h"

@interface JRJLargePlateMovementController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *moveArray;  //异动数组
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) JRJTransactionLineView *lineView; //异动图

@end

@implementation JRJLargePlateMovementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    UINib *nib = [UINib nibWithNibName:@"JRJIndexPlateExchangeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"JRJIndexPlateExchangeCell"];
    [self.view addSubview:_tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.lineView = [[JRJTransactionLineView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 280)];
    self.tableView.tableHeaderView = self.lineView;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderAction)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

- (void)refreshHeaderAction {
    [self.lineView setNeedsDisplay];
    [self fetchTranstionView];
}

- (void)creteTime {
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector(fetchTranstionView)
                                                userInfo:nil
                                                 repeats:YES]; //可根据网络环境 是否交易日 来判断刷新频率
    [self.timer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.timer == nil) {
        [self creteTime];
    }
    [self.tableView reloadData];
}

- (void)fetchTranstionView {
    WeakSelf;
    NSString *strUrl = [NSString stringWithFormat:@"https://sslapi.jrj.com.cn/zxhq/sapi/plat/yd?maxId=0"];
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            if (!data) {
                return;
            }
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSInteger retCode = [[dict objectForKey:@"retcode"] integerValue];
            if (retCode == 0) {
                NSDictionary *data = [dict objectForKey:@"data"];
                NSMutableArray *arr = [NSMutableArray arrayWithArray:data[@"items"]];
                if ([arr isKindOfClass:[NSMutableArray class]] && arr.count) {
                    if (arr.count != weakSelf.moveArray.count) {
                        weakSelf.moveArray = [NSMutableArray arrayWithArray:data[@"items"]];
                        [weakSelf.tableView reloadData];
                        weakSelf.lineView.transtionArray = weakSelf.moveArray;
                        [weakSelf.lineView setNeedsDisplay];
                    }
                }
            }
        });
    }];
    [task resume];
}


#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moveArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.moveArray[indexPath.row];
    NSArray *stockInfos = dic[@"stockInfos"];
    if (stockInfos.count >2) {
        return 120;
    } else {
        return 80;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.moveArray[indexPath.row];
    JRJIndexPlateExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JRJIndexPlateExchangeCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell configCellWithDic:dic isTop:YES];
    } else {
        [cell configCellWithDic:dic isTop:NO];
    }
    cell.pushBlock = ^(NSString *stockCode) {
//        [weakSelf showStockInfoMainController:stockCode andStockDic:nil];
    };
    cell.pushPlateBlock = ^(NSDictionary *dic) {
//        [weakSelf pushPlateVC:dic];
    };
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, APPScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
