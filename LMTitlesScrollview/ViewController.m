//
//  ViewController.m
//  LMTitlesScrollview
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 migi Lu. All rights reserved.
//

#import "ViewController.h"
#import "LMTitlesScrollView.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,LMTitlesScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)LMTitlesScrollView *titlesScrollView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)NSInteger currentIndex;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程学习";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titlesScrollView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ is %ld",_titles[_currentIndex],indexPath.row];
    return cell;
}

- (void)titlesScrollViewDidClicked:(NSInteger)index
{
    _currentIndex = index;
    [_tableView reloadData];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (LMTitlesScrollView *)titlesScrollView
{
    if (_titlesScrollView == nil) {
        _titles = @[@"全部",@"C语言",@"C++",@"C#",@"Objective C",@"swift",@"Java",@"html5",@"php",@"sql",@"汇编"];
        _titlesScrollView = [[LMTitlesScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44) titles:_titles delegate:self];
    }
    return _titlesScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
