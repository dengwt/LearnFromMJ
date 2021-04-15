//
//  FollowViewController.m
//  LearnFromMJ
//
//  Created by LIANDI on 2018/08/29.
//  Copyright © 2018年 LIANDI. All rights reserved.
//

#import "FollowViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "CategoryCell.h"
#import <MJExtension/MJExtension.h>
#import "UserCell.h"
#import "MJRefresh.h"

#define SelectedCategory self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row]

@interface FollowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *categoryArray;
@property (strong, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) IBOutlet UITableView *userTableView;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (weak, nonatomic) NSMutableDictionary *params;
@end

@implementation FollowViewController

static NSString * const CategoryIdentifier = @"CategoryCell";
static NSString * const UserIdentifier = @"UserCell";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setup];
    
    [self setRefresh];
    
    [self loadCategory];
}

- (void)setup
{
    self.title = @"推荐关注";
    self.view.backgroundColor = GlobalBg;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryCell class]) bundle:nil] forCellReuseIdentifier:@"CategoryCell"];
    self.categoryTableView.tableFooterView = [[UIView alloc] init];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserCell class]) bundle:nil] forCellReuseIdentifier:@"UserCell"];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    self.userTableView.contentInset = self.categoryTableView.contentInset;
//    self.userTableView.rowHeight = 70;
}

- (void)setRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadNewUsers
{
    CategoryModel *um = SelectedCategory;
    um.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(um.id);
    params[@"page"] = @(um.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = [UserModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        // remove all data when load new data
        [um.users removeAllObjects];
        
        // store api data
        [um.users addObjectsFromArray:data];
        
        // total
        um.total = [responseObject[@"total"] integerValue];
        
        // clear unuse http
        if (self.params != params) return;
        
        // reload user tableview
        [self.userTableView reloadData];
        
        // end load
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // clear unuse http
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"load data failed !"];
        
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    CategoryModel *cm = SelectedCategory;
    
    // send request
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(cm.id);
    params[@"page"] = @(++cm.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // response
        NSArray *users = [CategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [cm.users addObjectsFromArray:users];
        
        if (self.params != params) return ;
        
        // reload data
        [self.userTableView reloadData];
        
        [self checkFootStatus];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        [SVProgressHUD showErrorWithStatus:@"load data failed !"];
        
        [self.userTableView.mj_footer endRefreshing];
    }];
}

- (void)loadCategory
{
    // show indicator
    [SVProgressHUD show];
    
    // send request
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categoryArray = [CategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // reload data
        [self.categoryTableView reloadData];
        
        // select 1st category
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // begin load data
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"load data failured !"];
    }];
}

- (void)checkFootStatus
{
    CategoryModel *cm = SelectedCategory;
    self.userTableView.mj_footer.hidden = (cm.users.count == 0);
    
    if (cm.users.count == cm.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryIdentifier];
//            if (!cell) {
//                cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryIdentifier];
//            }
        cell.categoryModel = self.categoryArray[indexPath.row];
        return cell;
    } else {
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:UserIdentifier];
        cell.userModel = [SelectedCategory users][indexPath.row];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categoryArray.count;
    } else {
        [self checkFootStatus];
        
        return [SelectedCategory users].count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    CategoryModel *cm = self.categoryArray[indexPath.row];
    
    // if data exist, not http
    if (cm.users.count) {
        [self.userTableView reloadData];
    } else {
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - clear
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
