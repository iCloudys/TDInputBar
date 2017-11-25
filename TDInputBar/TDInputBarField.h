//
//  TDInputBarField.h
//  test
//
//  Created by Mac on 2017/11/17.
//

#import <UIKit/UIKit.h>

@interface TDInputBarField : UITextField


/**
 在当前位置插入text

 @param text 字符串
 */
- (void)insertText:(NSString *)text;

/**
 在当前位置向前删除区域字符串，成功返回删除字符串，否则返回Nil

 @param prefix 仅支持单个字符
 @param suffix 仅支持单个字符
 @return 默认删除 返回Nil。 成功删除匹配字符串，返回删除的字符串
 */
- (NSString*)deleteForPrefix:(NSString*)prefix suffix:(NSString*)suffix;

@end
