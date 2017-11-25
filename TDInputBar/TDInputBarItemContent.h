//
//  TDInputBarItemContent.h
//  test
//
//  Created by Mac on 2017/11/21.
//

#import <UIKit/UIKit.h>

@class TDInputBarOption;
@class TDInputBarItem;
@interface TDInputBarItemContent : UIView

@property (nonatomic, strong) NSArray<TDInputBarItem*>* items;

@property (nonatomic, strong) TDInputBarOption* option;

@end
