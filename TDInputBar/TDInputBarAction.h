//
//  TDInputBarAction.h
//  test
//
//  Created by Mac on 2017/11/19.
//

#import <UIKit/UIKit.h>
#import "TDInputBarOption.h"

typedef NS_ENUM(NSUInteger, TDInputBarActionType) {
    TDInputBarActionTypeInput,
    TDInputBarActionTypeMore,
    TDInputBarActionTypeRecord,
};

@interface TDInputBarAction : UIControl

- (instancetype)initWithType:(TDInputBarActionType)type
                      target:(id)target
                      action:(SEL)action;

@property (nonatomic, assign, readonly) TDInputBarActionType type;

@property (nonatomic, strong) TDInputBarOption* option;

////TDInputBarItemTypeInput
//- (BOOL)becomeFirstResponder;
//- (BOOL)resignFirstResponder;
//- (BOOL)isFirstResponder;

@end
