//
//  NSDate+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface NSDate (MarXTools)

@end


@interface NSDate (lw_format)


/**
 某个date的n天后

 @param n 几天后
 @param d 某个date
 @param f 返回的时间格式
 @return 返回结果
 */
+ (NSString *)lw_getNday:(NSInteger)n compareData:(NSDate*)d resultFormat:(NSString *)f;


/**
 毫秒时间戳->NSDate

 @param timestamp 时间戳，是毫秒为单位
 @return NSDate
 */
+ (NSDate *)lw_longTimestamp_to_date:(long)timestamp;
+ (NSDate *)lw_longTimestampString_to_date:(NSString *)timestamp;

/**
 时间戳->NSDate
 
 @param timestamp 时间戳，是秒为单位
 @return NSDate
 */
+ (NSDate *)lw_timestamp_to_date:(long)timestamp;
+ (NSDate *)lw_timestampString_to_date:(NSString *)timestamp;

/**
 当前NSDate->时间戳
 
 @return 时间戳
 */
+ (NSString*)lw_currentDate_to_timeStamp;

/**
 NSDate->时间戳
 
 @return 时间戳,是初始化后的NSDate调用这个方法
 */
- (NSString *)lw_nsdate_to_timestamp;


/**
 正常时间->时间戳
 正常时间格式应该为：yyyy-MM-dd HH:mm:ss
 @param time 正常时间
 @return 时间戳
 */
+ (NSString *)lw_normalTime_to_timeStamp:(NSString *)time;


/**
 正常时间->NSDate
 正常时间格式应该为：yyyy-MM-dd HH:mm:ss
 @param time 正常时间
 @return NSDate
 */
+ (NSDate *)lw_normalTime_to_nsdate:(NSString *)time;


/**
 毫秒时间戳->正常的时间
 yyyy-MM-dd HH:mm:ss
 @param timestamp 时间戳，以毫秒为单位
 @param format 格式
 @return 格式化后的时间
 */
+ (NSString *)lw_longTimestamp_to_normalTime:(long)timestamp format:(NSString *)format;
+ (NSString *)lw_longTimestampString_to_normalTime:(NSString *)timestampString format:(NSString *)format;

/**
 时间戳->正常的时间
 yyyy-MM-dd HH:mm:ss
 @param timestamp 时间戳，以秒为单位
 @param format 格式
 @return 格式化后的时间
 */
+ (NSString *)lw_timestamp_to_normalTime:(long)timestamp format:(NSString *)format;
+ (NSString *)lw_timestampString_to_normalTime:(NSString *)timestampString format:(NSString *)format;

/**
 当前NSDate->正常的时间

 @param format 格式
 @return 格式化后的时间
 */
+ (NSString *)lw_currentDate_to_noramlTimeWithFormat:(NSString *)format;

/**
 NSDate->正常的时间

 @param format 格式
 @return 格式化后的时间
 */
- (NSString *)lw_nsdate_to_normalTimeWithFormat:(NSString *)format;


/**
 获取当前时间NSDate

 @param format 返回时间的格式 {YYYY-MM-dd 、YYYY年MM月、HH:mm}
 @return 返回的时间
 */
+ (NSString *)lw_currentTimeWithFormat:(NSString *)format;
@end


#define D_MINUTE      60
#define D_HOUR        3600
#define D_DAY         86400
#define D_WEEK        604800
#define D_YEAR        31556926
@interface NSDate (lw_caendar)
+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) lastYear;
+ (NSDate *) nextYear;
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Short string utilities
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;


/**
 判断是否为白天 {早上6点到晚上6点}

 @return bool值
 */
- (BOOL) isDayTime;


/**
 判断是否为深夜 {晚上11点到早上5点}

 @return bool值
 */
- (BOOL) isMidnight;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;


/**
 *  距离当前时间的第几天算
 *
 *  @param day 天数
 */
- (NSDate *)aimDay:(NSInteger)day;
/**
 *  距离当前多少小时
 *
 *  @return 新时间
 */
- (NSDate *)aimHour:(CGFloat)hours;
// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

/**
 比较两个时间差

 @param sDate 开始时间
 @param eDate 结束时间
 @return 时间差
 */
+ (NSString *)compareTwoDate_NoSecond:(NSDate *)sDate endTime:(NSDate *)eDate;

+ (NSString *)compareTwoDate:(NSDate *)sDate endTime:(NSDate *)eDate;

+ (NSTimeInterval)lw_comparesDate:(NSDate *)sDate edate:(NSDate *)eDate;

+ (NSString *)lw_compareTwoDateMaohao:(NSDate *)sDate endTime:(NSDate *)eDate;
    
/**
 比较两个时间差
 
 @param sDate 开始时间
 @param eDate 结束时间
 @return 天数
 */
+ (NSInteger )compareTwoDateBackDays:(NSDate *)sDate endTime:(NSDate *)eDate;

/**
 时间戳->星期几

 @param timeStamp 时间戳
 @return 星期几
 */
+ (NSString*)weekFromTimeStamp:(long )timeStamp;

/**
 NSDate->星期几

 @param date NSDate
 @return 星期几
 */
+ (NSString*)weekFromDate:(NSDate*)date;
@end
