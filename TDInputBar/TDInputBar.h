//
//  TDInputBar.h
//  test
//
//  Created by Mac on 2017/11/17.
//

#import <UIKit/UIKit.h>
#import "TDInputBarOption.h"
#import "TDInputBarField.h"
#import "TDInputBarItem.h"
#import "TDInputBarItemContent.h"

@interface TDInputBar : UIToolbar
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (instancetype)initWithSuperview:(UIView*)superview NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) TDInputBarOption* option;

- (void)insertText:(NSString*)text;

@end
