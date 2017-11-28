//
//  TDInputBarField.m
//  test
//
//  Created by Mac on 2017/11/17.
//

#import "TDInputBarField.h"

@implementation TDInputBarField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderWidth = 0.5;
        
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor colorWithRed:248/255.
                                               green:248/255.
                                                blue:248/255.
                                               alpha:1];
        
        self.layer.borderColor = [UIColor colorWithRed:236/255.
                                                 green:236/255.
                                                  blue:236/255.
                                                 alpha:1].CGColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2;
}

- (CGRect)borderRectForBounds:(CGRect)bounds{
    return [self contentForBounds:bounds];
}
- (CGRect)textRectForBounds:(CGRect)bounds;{
    return [self contentForBounds:bounds];
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    return [self contentForBounds:bounds];
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return [self contentForBounds:bounds];
}

- (CGRect)contentForBounds:(CGRect)bounds{
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 5));
}

- (void)insertText:(NSString *)text{
    
    UITextRange* selectedTextRange = self.selectedTextRange;
    
    [self replaceRange:selectedTextRange withText:text];
    
    UITextPosition* start = [self positionFromPosition:selectedTextRange.start offset:text.length];
    
    UITextPosition* end = [self positionFromPosition:selectedTextRange.end offset:text.length];
    
    self.selectedTextRange = [self textRangeFromPosition:start toPosition:end];
}

- (NSString *)deleteForPrefix:(NSString*)prefix suffix:(NSString*)suffix{
    
    //prefix 或者suffix 长度不为1，不进行匹配
    if ((prefix.length != 1) && (suffix.length != 1)) {
        
        [self deleteBackward];
    
        return nil;
    }
    
    
    UITextRange* selectedTextRange = self.selectedTextRange;
    
    UITextPosition* beginning = self.beginningOfDocument;
    
    //当前有选择字符串，不进行匹配
    if (!selectedTextRange.isEmpty) {
        
        [self deleteBackward];
        
        return nil;
    }
    
    NSUInteger local = [self offsetFromPosition:beginning toPosition:selectedTextRange.start];
    
    NSString* text = [self.text substringToIndex:local];
    
    //字符串不是suffix结尾，不进行匹配
    if (![text hasSuffix:suffix]) {
        
        [self deleteBackward];
        
        return nil;
    }
    
    NSRange range = [text rangeOfString:prefix options:NSBackwardsSearch];
    
    //虽然是suffix结尾，但是没有找到prefix开头，不进行匹配
    if (range.location == NSNotFound) {
        
        [self deleteBackward];
        
        return nil;
    }
    
    //删除指定字符串
    NSString* delString = [text substringFromIndex:range.location];
    
    UITextPosition* fromPosition = [self positionFromPosition:selectedTextRange.start offset: - delString.length];
    
    UITextRange* newSelectedRange = [self textRangeFromPosition:fromPosition toPosition:selectedTextRange.end];
    
    [self replaceRange:newSelectedRange withText:@""];
    
    //剔除前后缀，并返回
    delString = [delString stringByReplacingOccurrencesOfString:prefix withString:@""];
    
    delString = [delString stringByReplacingOccurrencesOfString:suffix withString:@""];
    
    return delString;
}

@end
