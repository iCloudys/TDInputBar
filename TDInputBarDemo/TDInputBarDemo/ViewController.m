//
//  ViewController.m
//  TDInputBarDemo
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 RUIPENG. All rights reserved.
//

#import "ViewController.h"
#import "IMViewController.h"

typedef NSString * NSCellKey;

static NSCellKey const CellText = @"CellText";
static NSCellKey const CellClass = @"CellClass";

@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSCellKey,id>*>* dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.rowHeight = 50;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11,*)) {safeAreaInsets = self.view.safeAreaInsets;}
    self.tableView.frame = UIEdgeInsetsInsetRect(self.view.bounds, safeAreaInsets);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row][CellText];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = self.dataSource[indexPath.row][CellClass];
    UIViewController* detail = [[class alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSArray<NSDictionary<NSCellKey,id> *> *)dataSource{
    if (!_dataSource) {
        NSMutableArray* array = [NSMutableArray array];
        
        [array addObject:@{
                           CellText:@"IM-Demo",
                           CellClass:[IMViewController class]
                           }
         ];
        
        _dataSource = array.copy;
    }
    return _dataSource;
}

@end
