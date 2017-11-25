//
//  TDInputBarItemContent.m
//  test
//
//  Created by Mac on 2017/11/21.
//

#import "TDInputBarItemContent.h"

#import "TDInputBarItem.h"
#import "TDInputBarOption.h"

@interface TDInputBarItemContent()

@end


@implementation TDInputBarItemContent

- (void)setItems:(NSArray<TDInputBarItem *> *)items{
    _items = items;
    
    for (TDInputBarItem* item in items) {
        [self addSubview:item];
    }
}

- (void)setOption:(TDInputBarOption *)option{
    _option = option;
    
    self.backgroundColor = option.itemsContentBackground;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIEdgeInsets edgeInset = self.option.itemsContentInsets;
    
    CGFloat itemW = (CGRectGetWidth(self.bounds) - edgeInset.left - edgeInset.right ) / 4;
    CGFloat itemH = MIN(itemW, CGRectGetHeight(self.bounds) - edgeInset.top - edgeInset.bottom);
    
    for (unsigned int i = 0; i < self.items.count; i ++) {
        TDInputBarItem* item = self.items[i];
        
        CGFloat itemX = i * itemW + edgeInset.left;
        CGFloat itemY = i / 4 * itemH + edgeInset.top;
        
        item.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
}


@end
