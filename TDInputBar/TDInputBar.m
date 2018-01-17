//
//  TDInputBar.m
//  test
//
//  Created by Mac on 2017/11/17.
//

#import "TDInputBar.h"
#import "TDInputBarField.h"
#import "TDInputBarField.h"

@interface TDInputBar()
<UITextFieldDelegate,
UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton* moreAction;

@property (nonatomic, strong) TDInputBarField* textField;

@property (nonatomic, strong) TDInputBarItemContent* itemsContent;

@end

@implementation TDInputBar

- (TDInputBarOption *)option{
    if (!_option) {
        _option = [[TDInputBarOption alloc] init];
    }
    return _option;
}

- (instancetype)initWithSuperview:(UIView *)superview{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [superview addSubview:self];
        
        self.translucent = NO;
        
        [self setupSubviews];
        
    }
    return self;
}

- (void)setupSubviews{
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.textField = [[TDInputBarField alloc] init];
        
        weakSelf.textField.delegate = weakSelf;
        
        weakSelf.textField.placeholder = weakSelf.option.placeholder;
        
        weakSelf.textField.font = weakSelf.option.textFont;
        
        weakSelf.textField.textColor = weakSelf.option.textColor;
        
        weakSelf.textField.returnKeyType = weakSelf.option.returnKeyType;
        
        [weakSelf.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [weakSelf addSubview:weakSelf.textField];
        
        if (weakSelf.option.types & TDInputBarTypeMore) {
            
            weakSelf.moreAction = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [weakSelf.moreAction addTarget:weakSelf action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.moreAction setImage:[weakSelf imageNamed:@"inputbar_more_action_normal"] forState:UIControlStateNormal];
            
            [weakSelf addSubview:weakSelf.moreAction];
            
            weakSelf.itemsContent = [[TDInputBarItemContent alloc] init];
            
            weakSelf.itemsContent.hidden = YES;
            
            weakSelf.itemsContent.items = weakSelf.option.items;
            
            weakSelf.itemsContent.option = weakSelf.option;
            
            [weakSelf addSubview:weakSelf.itemsContent];
        }
        
    });
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self removeNotifation];
    }
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (self.superview) {
        [self registerNotifation];
    }
}

- (void)registerNotifation{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotifation:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotifation:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditingNotifation:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditingNotifation:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
}

- (void)removeNotifation{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidEndEditingNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidBeginEditingNotification
                                                  object:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self adjustSelfFrame];
    
    [self adjustSubviewFrame];
}

//调整在父视图中的frame 返回yes为修改成功
- (BOOL)adjustSelfFrame{
    
    CGRect newFrame = self.frame;
    
    UIEdgeInsets safeAreaInset = UIEdgeInsetsZero;
    
    CGRect superviewBounds = self.superview.bounds;
    
    if (CGRectEqualToRect(superviewBounds, CGRectZero)) {return NO;}
    
    if (@available(iOS 11,*)) { safeAreaInset = self.superview.safeAreaInsets;}
    
    switch (self.option.position) {
        case TDInputBarPositionBottom:
        {
            CGFloat selfX = 0;
            CGFloat selfY = CGRectGetHeight(superviewBounds) - self.option.height - safeAreaInset.bottom;
            CGFloat selfW = CGRectGetWidth(superviewBounds);
            CGFloat selfH = self.option.height;
            newFrame = CGRectMake(selfX,selfY,selfW,selfH);
        }
            break;
            
        default:
            break;
    }
    
    if (CGRectEqualToRect(self.frame, newFrame)) {return NO;}
    
    if (!CGAffineTransformIsIdentity(self.transform)) {return NO;}
    
    self.frame = newFrame;
    
    return YES;
}

//调整子视图frame
- (void)adjustSubviewFrame{
    
    CGFloat _insetMargin = 14;
    CGFloat _maxPosition = CGRectGetWidth(self.bounds);
    UIEdgeInsets _safeAreaInset = UIEdgeInsetsZero;
    
    if (@available(iOS 11,*)) {_safeAreaInset = self.safeAreaInsets;}
    
    if (self.moreAction) {
        CGFloat moreH = CGRectGetHeight(self.bounds);
        CGFloat moreW = moreH;
        CGFloat moreY = 0;
        CGFloat moreX = _maxPosition - moreW - _insetMargin - _safeAreaInset.left - _safeAreaInset.right;
        self.moreAction.frame = CGRectMake(moreX, moreY, moreW, moreH);
        _maxPosition = CGRectGetMinX(self.moreAction.frame);
    }
    
    if (self.textField) {
        CGFloat fieldX = _insetMargin + _safeAreaInset.left;
        CGFloat fieldY = 9;
        CGFloat fieldH = CGRectGetHeight(self.bounds) - fieldY * 2;
        CGFloat fieldW = _maxPosition - fieldX - _insetMargin;
        self.textField.frame = CGRectMake(fieldX, fieldY, fieldW, fieldH);
    }
    
    if (self.itemsContent) {
        CGFloat contentX = 0;
        CGFloat contentY = CGRectGetHeight(self.bounds);
        CGFloat contentH = self.option.itemsContentHeight;
        CGFloat contentW = CGRectGetWidth(self.bounds);
        self.itemsContent.frame = CGRectMake(contentX, contentY, contentW, contentH);
    }
}

//返回NO 则传递给下一层，返回YES自己处理事件

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if ([self pointInView:point]) {
        return YES;
    }
    if (self.option.shouldResignOnTouchOutside && self.isFirstResponder) {
        [self resignFirstResponder];
    }
    return [super pointInside:point withEvent:event];
}


- (BOOL)pointInView:(CGPoint)point{
    
    if (CGRectContainsPoint(self.bounds, point)){return YES;}
    
    if (self.itemsContent) {
        CGRect rect = [self.itemsContent convertRect:self.itemsContent.bounds toView:self];
        
        if (CGRectContainsPoint(rect, point)) {return YES;}
    }
    
    return NO;
}

- (void)keyboardWillShowNotifation:(NSNotification*)notifation{
    
    if (!self.isFirstResponder) { return;}
    
    CGRect keyboardFrame = [[notifation userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets safeAreaInset = UIEdgeInsetsZero;
    if (@available(iOS 11, *)) {safeAreaInset = self.superview.safeAreaInsets;}
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height + safeAreaInset.bottom);
    
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    info[TDInputAnimatedDurationKey] = [notifation userInfo][TDInputAnimatedDurationKey];
    info[TDInputAnimatedOptionsKey] = [notifation userInfo][TDInputAnimatedOptionsKey];
    info[TDInputAnimatedTransformKey] = [NSValue valueWithCGAffineTransform:transform];
    
    __weak typeof(self) weakSelf = self;
    [self animateWithInfo:info completion:^(BOOL finished) {
        if (weakSelf.itemsContent) {
            weakSelf.itemsContent.hidden = YES;
        }
    }];
}

- (void)keyboardWillHideNotifation:(NSNotification*)notifation{
    
    if (!self.isFirstResponder) { return;}
    
    if (self.itemsContent && self.itemsContent.hidden == NO) {return;}
    
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    info[TDInputAnimatedDurationKey] = [notifation userInfo][TDInputAnimatedDurationKey];
    info[TDInputAnimatedOptionsKey] = [notifation userInfo][TDInputAnimatedOptionsKey];
    info[TDInputAnimatedTransformKey] = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
    
    __weak typeof(self) weakSelf = self;
    [self animateWithInfo:info completion:^(BOOL finished) {
        if (weakSelf.itemsContent) {
            weakSelf.itemsContent.hidden = YES;
        }
    }];
}


- (void)moreAction:(UIButton*)sender{
    
    if (self.itemsContent.hidden == NO) {
        [self.textField becomeFirstResponder];
        return;
    }
    
    self.itemsContent.hidden = NO;
    
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.itemsContent.bounds));
    
    NSMutableDictionary* info = [NSMutableDictionary dictionary];
    info[TDInputAnimatedDurationKey] = @(0.25);
    info[TDInputAnimatedOptionsKey] = @(7);
    info[TDInputAnimatedTransformKey] = [NSValue valueWithCGAffineTransform:transform];
    [self animateWithInfo:info completion:NULL];
}

- (void)animateWithInfo:(NSDictionary<TDInputAnimatedKey, __kindof NSValue*>*)info
             completion:(void (^)(BOOL finished))completion{
    
    id<TDInputBarDelegate> delegate = self.option.delegate;
    if (delegate && [delegate respondsToSelector:@selector(inputBar:beginAnimated:)]) {
        [delegate inputBar:self beginAnimated:info];
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:[info[TDInputAnimatedDurationKey] doubleValue]
                          delay:0
                        options:[info[TDInputAnimatedOptionsKey] unsignedIntegerValue]
                     animations:^{
                         weakSelf.transform = [info[TDInputAnimatedTransformKey] CGAffineTransformValue];
                     } completion:completion];
}


//MARK:- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(TDInputBarField *)textField{
    
    id<TDInputBarDelegate> delegate = self.option.delegate;
    
    if (delegate && [delegate respondsToSelector:@selector(inputBar:textField:didPressReturn:)]) {
        [delegate inputBar:self textField:textField didPressReturn:textField.text];
    }
    
    textField.text = nil;
    
    if (delegate && [delegate respondsToSelector:@selector(inputBar:editingChanged:)]) {
        [delegate inputBar:self editingChanged:textField];
    }
    
    return YES;
}

- (BOOL)textField:(TDInputBarField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    id<TDInputBarDelegate> delegate = self.option.delegate;
    
    if (delegate) {
        
        if (string.length == 0 && [delegate respondsToSelector:@selector(inputBar:textField:shouldDeleteInRange:)]) {
            return [delegate inputBar:self textField:textField shouldDeleteInRange:range];
        }
        
        if (string.length == 1 && [delegate respondsToSelector:@selector(inputBar:textField:shouldInputCharacter:inRange:)]) {
            unichar character = [string characterAtIndex:0];
            
            if ([self.option.characterSet characterIsMember:character]) {
                return [delegate inputBar:self textField:textField shouldInputCharacter:character inRange:range];
            }
        }
    }
    
    return YES;
}

- (void)textFieldEditingChanged:(TDInputBarField*)textField{
    id<TDInputBarDelegate> delegate = self.option.delegate;
    
    if (delegate && [delegate respondsToSelector:@selector(inputBar:editingChanged:)]) {
        [delegate inputBar:self editingChanged:textField];
    }
}

- (void)textFieldDidBeginEditingNotifation:(NSNotification*)notifation{
    UITextField* textField = notifation.object;
    if (textField != self.textField) {
        [self resignFirstResponder];
    }
}

- (void)textFieldDidEndEditingNotifation:(NSNotification*)notifation{
    
}

- (void)insertText:(NSString *)text{
    [self.textField insertText:text];
}

- (void)setText:(NSString *)text{
    self.textField.text = text;
}

- (NSString*)text{
    return self.textField.text;
}

- (void)clear{
    self.textField.text = nil;
}

- (BOOL)isFirstResponder{
    return [self.textField isFirstResponder] || (!CGAffineTransformIsIdentity(self.transform));
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    
    if (self.textField.isFirstResponder) {
        return [self.textField resignFirstResponder];
    }
    if (!CGAffineTransformIsIdentity(self.transform)) {
        NSMutableDictionary* info = [NSMutableDictionary dictionary];
        info[TDInputAnimatedDurationKey] = @(0.25);
        info[TDInputAnimatedOptionsKey] = @(7);
        info[TDInputAnimatedTransformKey] = [NSValue valueWithCGAffineTransform:CGAffineTransformIdentity];
        
        __weak typeof(self) weakSelf = self;
        [self animateWithInfo:info completion:^(BOOL finished) {
            if (weakSelf.itemsContent) {
                weakSelf.itemsContent.hidden = YES;
            }
        }];
        return YES;
    }
    return NO;
}

- (BOOL)becomeFirstResponder{
    [super becomeFirstResponder];
    
    return [self.textField becomeFirstResponder];
}

- (UIImage*)imageNamed:(NSString*)name{
    NSBundle* mainBundle = [NSBundle bundleForClass:[TDInputBar class]];
    
    NSBundle* resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"TDInputBar" ofType:@"bundle"]];
    
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    
    UIImage* image = [UIImage imageNamed:name inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    
    return image;
}
@end

