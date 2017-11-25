//
//  TDInputBarAction.m
//  test
//
//  Created by Mac on 2017/11/19.
//

#import "TDInputBarAction.h"
#import "TDInputBarField.h"

@interface TDInputBarAction()
@property (nonatomic, strong) UIView* view;
@end

@implementation TDInputBarAction

- (instancetype)initWithType:(TDInputBarActionType)type
                      target:(id)target
                      action:(SEL)action{

    self = [super initWithFrame:CGRectZero];
    
    switch (type) {
        case TDInputBarActionTypeMore:
        {
            UIButton* more = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [more setImage:[UIImage imageNamed:@"TDInputBar.bundle/inputbar_more_action_normal"] forState:UIControlStateNormal];
            
            [more addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
            self.view = more;
        }
            break;
            
        case TDInputBarActionTypeRecord:
        {
            UIButton* record = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [record setImage:[UIImage imageNamed:@"TDInputBar.bundle/inputbar_more_action_normal"] forState:UIControlStateNormal];
            
            [record addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            
            self.view = record;
        }
            break;
            
        default:
        {
            TDInputBarField* textField = [[TDInputBarField alloc] init];
            
            textField.delegate = target;

            self.view = textField;
        }
            break;
    }
    
    if (self) {
        _type = type;
        [self addSubview:self.view];
    }
    
    return self;
}


- (void)setOption:(TDInputBarOption *)option{
    _option = option;
    
    if (self.type == TDInputBarActionTypeInput) {
        
        TDInputBarField* textField = (TDInputBarField*)self.view;
        
        textField.placeholder = option.placeholder;
        
        textField.font = option.textFont;
        
        textField.textColor = option.textColor;
        
        textField.returnKeyType = option.returnKeyType;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.view.frame = self.bounds;
}

- (BOOL)becomeFirstResponder{
    return [self.view becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    return [self.view resignFirstResponder];
}

- (BOOL)isFirstResponder{
    return [self.view isFirstResponder];
}
@end
