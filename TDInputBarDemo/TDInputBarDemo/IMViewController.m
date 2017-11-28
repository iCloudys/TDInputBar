//
//  IMViewController.m
//  TDInputBarDemo
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 RUIPENG. All rights reserved.
//

#import "IMViewController.h"
#import "TDInputBar.h"

typedef NSString* Message;


#define TDInputAtStart  @"@"
#define TDInputAtEnd    @"\u2004"

@interface IMViewController ()<
UITableViewDataSource,
UITableViewDelegate,
TDInputBarDelegate>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, assign) CGRect tableViewFrame;

@property (nonatomic, strong) TDInputBar* inputBar;

@property (nonatomic, strong) NSMutableArray<Message>* dataSource;

@end

@implementation IMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    [self setupTableView];
    
    [self setupInputBar];
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.estimatedRowHeight = 0;
    
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView.estimatedSectionFooterHeight = 0;
    
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.tableView.frame = weakSelf.tableViewFrame;
        
        [weakSelf scrollBottom:NO];
        
    });
}

- (void)setupInputBar{
    self.inputBar = [[TDInputBar alloc] initWithSuperview:self.view];
    
    TDInputBarOption* option = [[TDInputBarOption alloc] init];
    
    option.delegate = self;
    
    option.characterSet = [NSCharacterSet characterSetWithCharactersInString:TDInputAtStart];
    
    self.inputBar.option = option;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

//键盘动画
- (void)inputBar:(TDInputBar *)inputBar beginAnimated:(NSDictionary<TDInputAnimatedKey,__kindof NSValue *> *)animated{

    CGFloat duration = [animated[TDInputAnimatedDurationKey] floatValue];
    UIViewAnimationOptions options = [animated[TDInputAnimatedOptionsKey] unsignedIntegerValue];
    CGAffineTransform transform = [animated[TDInputAnimatedTransformKey] CGAffineTransformValue];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         if (CGAffineTransformIsIdentity(transform)) {
                             weakSelf.tableView.frame = weakSelf.tableViewFrame;
                         }else{
                             CGRect frame = weakSelf.tableViewFrame;
                             frame.size.height += transform.ty;
                             weakSelf.tableView.frame = frame;
                         }
                         [weakSelf scrollBottom:NO];
                         
                     } completion:NULL];
}

//发送消息
- (void)inputBar:(TDInputBar *)inputBar textField:(TDInputBarField *)textField didPressReturn:(NSString *)string{
    if (string.length == 0) {return;}
    
    [self.dataSource addObject:string];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self scrollBottom:YES];
}

//删除按钮
- (BOOL)inputBar:(TDInputBar *)inputBar textField:(TDInputBarField *)textField shouldDeleteInRange:(NSRange)range{
    
    NSString* text = textField.text;
    NSString* lastChar = [text substringFromIndex:text.length -1];
    
    if ([lastChar isEqualToString:TDInputAtEnd]) {
        [textField deleteForPrefix:TDInputAtStart suffix:TDInputAtEnd];
        return NO;
    }
    return YES;
}

//特殊字符回调,由于系统原因，可能会回调多次 eg:@
- (BOOL)inputBar:(TDInputBar *)inputBar textField:(TDInputBarField *)textField shouldInputCharacter:(unichar)character inRange:(NSRange)range{
    
    //此处模拟选择@某人
    NSString* text = [NSString stringWithFormat:@"%@%@%@",TDInputAtStart,@"小张",TDInputAtEnd];
    
    [self.inputBar insertText:text];
    
    return NO;
}

//TableView滚动到底部
- (void)scrollBottom:(BOOL)animated{
    
    CGSize contentSize = [self.tableView sizeThatFits:CGSizeMake(CGRectGetWidth(self.tableView.frame), CGFLOAT_MAX)];
    
    CGSize tableSize = self.tableView.frame.size;
    
    CGFloat offsetY = contentSize.height - tableSize.height;
    
    if (offsetY > 0){
        
        [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:animated];
    }
}

- (CGRect)tableViewFrame{
    
    if (CGRectEqualToRect(_tableViewFrame, CGRectZero)) {
        
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        
        if (@available(iOS 11,*)) { safeAreaInsets = self.view.safeAreaInsets; }
        
        safeAreaInsets.bottom += self.inputBar.option.height;
        
        _tableViewFrame = UIEdgeInsetsInsetRect(self.view.bounds,safeAreaInsets);
        
    }
    return _tableViewFrame;
}

@end