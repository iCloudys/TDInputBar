//
//  TDInputBarItem.h
//  test
//
//  Created by Mac on 2017/11/22.
//

#import <UIKit/UIKit.h>

@interface TDInputBarItem : UIControl

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;



- (instancetype)initWithTarget:(id)target action:(SEL)action NS_DESIGNATED_INITIALIZER;


@property (nonatomic, strong) UIImage* image;

@property (nonatomic, copy) NSString* title;

@property (nonatomic, strong) UIFont* titleFont;

@property (nonatomic, strong) UIColor* titleColor;


@property (nonatomic, assign) UIOffset titleOffset;

@property (nonatomic, assign) UIOffset imageOffset;

@end
