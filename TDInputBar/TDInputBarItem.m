//
//  TDInputBarAction.m
//  test
//
//  Created by Mac on 2017/11/22.
//

#import "TDInputBarItem.h"

@interface TDInputBarItem()

@property (nonatomic, strong) UIImageView* imageView;

@property (nonatomic, strong) UILabel* titleLabel;

@end

@implementation TDInputBarItem

- (instancetype)initWithTarget:(id)target action:(SEL)action{
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.title) {
        self.imageView.frame = self.bounds;
    }
    
    if (!self.image) {
        self.titleLabel.frame = self.bounds;
    }
    
    if (self.image && self.title) {
        
        CGFloat w = CGRectGetWidth(self.bounds);
        CGFloat h = CGRectGetHeight(self.bounds);
        CGFloat space = 4;
        CGSize lbSize = [self.title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        
        CGFloat ivH = MIN(self.image.size.height,h - lbSize.height);
        CGFloat ivW = MIN(self.image.size.width, w);
        CGFloat ivX = CGRectGetMidX(self.bounds) - ivW / 2 + self.imageOffset.horizontal;
        CGFloat ivY = CGRectGetMidY(self.bounds) - ivH / 2 + self.imageOffset.vertical;
        
        self.imageView.frame = CGRectMake(ivX, ivY, ivW, ivH);

        CGFloat lbH = lbSize.height;
        CGFloat lbW = lbSize.width;
        CGFloat lbX = CGRectGetMidX(self.bounds) - lbW / 2 + self.titleOffset.horizontal;
        CGFloat lbY = CGRectGetMaxY(self.imageView.frame) + self.titleOffset.vertical + space;

        self.titleLabel.frame = CGRectMake(lbX, lbY, lbW, lbH);
        
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

@end
