//
//  TDInputBarOption.m
//  test
//
//  Created by Mac on 2017/11/19.
//

#import "TDInputBarOption.h"

@implementation TDInputBarOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.height = 49;
        
        self.types = TDInputBarTypeText;
        
        self.shouldResignOnTouchOutside = YES;
        
        self.placeholder = @"请输入...";
        
        self.returnKeyType = UIReturnKeySend;
        
        self.itemsContentBackground = [UIColor whiteColor];
        
        self.itemsContentHeight = 200;
        
    }
    return self;
}
@end

TDInputAnimatedKey const TDInputAnimatedDurationKey     = @"UIKeyboardAnimationDurationUserInfoKey";
TDInputAnimatedKey const TDInputAnimatedOptionsKey      = @"UIKeyboardAnimationCurveUserInfoKey";
TDInputAnimatedKey const TDInputAnimatedTransformKey    = @"TDInputAnimatedTransformKey";
