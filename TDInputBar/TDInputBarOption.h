//
//  TDInputBarOption.h
//  test
//
//  Created by Mac on 2017/11/19.
//

#import <UIKit/UIKit.h>

@class TDInputBar;
@class TDInputBarField;
@class TDInputBarItem;

typedef NS_ENUM(NSUInteger, TDInputBarPosition) {
    TDInputBarPositionBottom = 0, //default， At the bottom of the super view, adjust the safe area
};


typedef NS_OPTIONS(NSUInteger, TDInputBarTypes) {
    TDInputBarTypeText = 0,    //default 输入框
    TDInputBarTypeMore = 1 << 1,    //更多按钮
    TDInputBarTypeRecord = 1 << 2,    //录音按钮(待完善)
};


typedef NSString* TDInputAnimatedKey;
UIKIT_EXTERN TDInputAnimatedKey const TDInputAnimatedDurationKey;
UIKIT_EXTERN TDInputAnimatedKey const TDInputAnimatedOptionsKey;
UIKIT_EXTERN TDInputAnimatedKey const TDInputAnimatedTransformKey;


@protocol TDInputBarDelegate <NSObject>
@optional

/**
 按下return 按钮

 @param inputBar inputBar
 @param textField 输入框
 @param string 出入框内的文字，回调此方法后，输入框文字被清空
 */
- (void)inputBar:(TDInputBar*)inputBar
       textField:(TDInputBarField*)textField
  didPressReturn:(NSString*)string;

/**
 输入特殊字符回调eg:@
 需要指定characterSet属性
 由于系统原因，可能会回调多次
 
 类似于 textField:shouldChangeCharactersInRange:replacementString:
 
 @param inputBar inputBar
 @param textField 输入框
 @param character 特殊字符
 @param range 字符在输入框中的位置
 @return 是否需要输入
 */
- (BOOL)inputBar:(TDInputBar*)inputBar
       textField:(TDInputBarField*)textField
shouldInputCharacter:(unichar)character
         inRange:(NSRange)range;

//按下删除

/**
 按下删除按钮，可以单独处理删除过程
 如果实现此方法，可以调用
 [TDInputBarField deleteForPrefix:suffix:]

 @param inputBar inputBar
 @param textField 输入框
 @param range 删除的位置
 */
- (BOOL)inputBar:(TDInputBar *)inputBar
       textField:(TDInputBarField*)textField
shouldDeleteInRange:(NSRange)range;

/**
 InputBar位置改变时候回调，

 @param inputBar inputBar
 @param animated 动画需要的参数
 */
- (void)inputBar:(TDInputBar *)inputBar
   beginAnimated:(NSDictionary<TDInputAnimatedKey,__kindof NSValue*>*)animated;


/**
 输入框输入编辑内容

 @param inputBar inputBar
 @param textField field
 */
- (void)inputBar:(TDInputBar*)inputBar
  editingChanged:(TDInputBarField*)textField;

@end


@interface TDInputBarOption : NSObject

@property (nonatomic, assign) CGFloat height;   //default 49.0

@property (nonatomic, assign) TDInputBarTypes types;

@property (nonatomic, assign) TDInputBarPosition position;

@property (nonatomic, weak) id <TDInputBarDelegate> delegate;


//TextField
@property (nonatomic, copy) NSString* placeholder;

@property (nonatomic, strong) UIFont* textFont;

@property (nonatomic, strong) UIColor* textColor;

@property (nonatomic, assign) UIReturnKeyType returnKeyType;

//输入特殊符号，回调执行[inputBar:didInputCharcter]
@property (nonatomic, strong) NSCharacterSet* characterSet;


//Action
@property (nonatomic, strong) UIColor* itemsContentBackground;

@property (nonatomic, assign) UIEdgeInsets itemsContentInsets;

@property (nonatomic, assign) CGFloat itemsContentHeight;

@property (nonatomic, strong) NSArray<TDInputBarItem*>* items;

@end
