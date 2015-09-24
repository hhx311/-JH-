//
//  JHStatus.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatus.h"
#import "JHUser.h"
#import "MJExtension.h"
#import "JHPhoto.h"

@implementation JHStatus

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [JHPhoto class]};
}

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */

/**
*  设置微博时间显示样式
*/
- (NSString *)created_at
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    /******** 设置日期格式(声明字符串里面每个数字和单词的含义) *********
     E:星期几
     M:月份
     d:几号(这个月的第几天)
     H:24小时制的小时
     m:分钟
     s:秒
     y:年
     **********************************************************/
    
    // 转换从新浪服务器接收的时间样式
    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 微博的创建日期
    NSDate *createDate = [dateFormatter dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            dateFormatter.dateFormat = @"昨天 HH:mm";
            return [dateFormatter stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            dateFormatter.dateFormat = @"MM-dd HH:mm";
            return [dateFormatter stringFromDate:createDate];
        }
    } else { // 非今年
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dateFormatter stringFromDate:createDate];
    }
}

/**
 *  设置来源
 */
- (void)setSource:(NSString *)source
{
    // 正则表达式 NSRegularExpression
    // 截串 NSString
    if (source.length) { // 判断来源是否有值,否则range会越界溢出
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自 %@", [source substringWithRange:range]];
    }
}

@end
