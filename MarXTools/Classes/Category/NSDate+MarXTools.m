//
//  NSDate+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "NSDate+MarXTools.h"

@implementation NSDate (MarXTools)

@end


@implementation NSDate (lw_format)

+ (NSString *)lw_getNday:(NSInteger)n compareData:(NSDate*)d resultFormat:(NSString *)f
{
    NSTimeInterval time = 24*60*60*1*n;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:f];
    NSDate * result = [d dateByAddingTimeInterval:time];
    NSString * r = [dateFormatter stringFromDate:result];
    return r;
}

+ (NSDateFormatter *)lw_finalTimestamp:(long)ftimestamp toFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setDateFormat:format];
    
    return dateFormatter;
}

+ (NSDate *)lw_longTimestampString_to_date:(NSString *)timestamp
{
    return [self lw_longTimestamp_to_date:[timestamp longLongValue]];
}

+ (NSDate *)lw_longTimestamp_to_date:(long)timestamp
{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    
    return timeData;
}

+ (NSDate *)lw_timestampString_to_date:(NSString *)timestamp
{
    return [self lw_timestamp_to_date:[timestamp longLongValue]];
}

+ (NSDate *)lw_timestamp_to_date:(long)timestamp
{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return timeData;
}

+ (NSString *)lw_longTimestampString_to_normalTime:(NSString *)timestampString format:(NSString *)format
{
    return [self lw_longTimestamp_to_normalTime:[timestampString longLongValue] format:format];
}

+ (NSString *)lw_longTimestamp_to_normalTime:(long)timestamp format:(NSString *)format
{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    
    return [[self lw_finalTimestamp:timestamp/1000 toFormat:format] stringFromDate:timeData];
}

+ (NSString *)lw_timestampString_to_normalTime:(NSString *)timestampString format:(NSString *)format
{
   return [self lw_timestamp_to_normalTime:[timestampString longLongValue] format:format];
}


+ (NSString *)lw_timestamp_to_normalTime:(long)timestamp format:(NSString *)format
{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [[self lw_finalTimestamp:timestamp toFormat:format] stringFromDate:timeData];
}

- (NSString *)lw_nsdate_to_timestamp
{
    NSTimeInterval a= [self timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

+ (NSString *)lw_currentDate_to_timeStamp
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a= [date timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

+ (NSDate *)lw_normalTime_to_nsdate:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:time];
    return date;
}

+ (NSString *)lw_normalTime_to_timeStamp:(NSString *)time
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* dateTodo = [formatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    
    return timeSp;
}

+ (NSString *)lw_currentDate_to_noramlTimeWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    
    return [formatter stringFromDate:datenow];
}

- (NSString *)lw_nsdate_to_normalTimeWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:format];

    return [formatter stringFromDate:self];
}

+ (NSString *)lw_currentTimeWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate date];
    return [formatter stringFromDate:datenow];
}

@end


static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
@implementation NSDate (lw_caendar)

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)lastYear
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_YEAR * (-1);
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)nextYear
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_YEAR * 1;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (BOOL) isDayTime
{
    BOOL daytime = NO;
    NSString *hourstring = [self stringWithFormat:@"HH"];
    NSInteger hour = [hourstring integerValue];
    //晚上6点到早上6点
    if (hour>=18 || hour<= 6) {
        daytime = NO;
    }else
    {
        daytime = YES;
    }
    return daytime;
}

- (BOOL)isMidnight
{
    BOOL midnight = NO;
    NSString *hourstring = [self stringWithFormat:@"HH"];
    NSInteger hour = [hourstring integerValue];
    //晚上6点到早上6点
    if (hour>=23 || hour<= 5) {
        midnight = YES;
    }else
    {
        midnight = NO;
    }
    return midnight;
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *) dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

- (NSDate *)aimDay:(NSInteger)day{
    
    NSDate*nowDate = self;
    NSDate* theDate;
    
    if(day!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay * day ];
        //or
        //   theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay * day ];
        //  theDate = [nowDate initWithTimeIntervalSinceReferenceDate:oneDay * day];
        theDate = [nowDate initWithTimeInterval: + oneDay * day sinceDate:self];
    }
    else
    {
        theDate = nowDate;
    }
    
    return theDate;
}

- (NSDate *)aimHour:(CGFloat)hours{
    
    NSDate*nowDate = self;
    NSDate* theDate;
    
    if(hours!=0)
    {
        NSTimeInterval  oneHour = 60*60; //一个小时时间
        
        theDate = [nowDate initWithTimeInterval:oneHour * hours sinceDate:self];
        
    }
    else
    {
        theDate = nowDate;
    }
    
    return theDate;
    
}

+ (NSTimeInterval)lw_comparesDate:(NSDate *)sDate edate:(NSDate *)eDate
{
    NSTimeInterval time = [eDate timeIntervalSinceDate:sDate];
    return time;
}

+ (NSString *)compareTwoDate_NoSecond:(NSDate *)sDate endTime:(NSDate *)eDate
{
    NSString *stringTimeInterval;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:sDate toDate:eDate options:0];
    if (cmps.year != 0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld年%ld月%ld天%ld小时%ld分",cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute];
    }else if (cmps.year==0 && cmps.month != 0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld月%ld天%ld小时%ld分",cmps.month,cmps.day,cmps.hour,cmps.minute];
    }else if (cmps.year==0 && cmps.month == 0 && cmps.day!=0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld天%ld小时%ld分",cmps.day,cmps.hour,cmps.minute];
    }else if(cmps.year==0 && cmps.month == 0 && cmps.day==0 && cmps.hour!=0){
        stringTimeInterval = [NSString stringWithFormat:@"%ld小时%ld分",cmps.hour,cmps.minute];
    }else if(cmps.year==0 && cmps.month == 0 && cmps.day==0 && cmps.hour==0&& cmps.minute!=0){
        stringTimeInterval = [NSString stringWithFormat:@"%ld分",cmps.minute];
    }
    
    // 输出结果
    //NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return stringTimeInterval;
}

+ (NSString *)compareTwoDate:(NSDate *)sDate endTime:(NSDate *)eDate
{
    NSString *stringTimeInterval;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:sDate toDate:eDate options:0];
    if (cmps.year != 0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld年%ld月%ld天%ld小时%ld分%ld秒",cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second];
    }else if (cmps.year==0 && cmps.month != 0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld月%ld天%ld小时%ld分%ld秒",cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second];
    }else if (cmps.year==0 && cmps.month == 0 && cmps.day!=0) {
        stringTimeInterval = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",cmps.day,cmps.hour,cmps.minute,cmps.second];
    }else if(cmps.year==0 && cmps.month == 0 && cmps.day==0 && cmps.hour!=0){
        stringTimeInterval = [NSString stringWithFormat:@"%ld小时%ld分%ld秒",cmps.hour,cmps.minute,cmps.second];
    }else if(cmps.year==0 && cmps.month == 0 && cmps.day==0 && cmps.hour==0&& cmps.minute!=0){
        stringTimeInterval = [NSString stringWithFormat:@"%ld分%ld秒",cmps.minute,cmps.second];
    }else{
        stringTimeInterval = [NSString stringWithFormat:@"%ld秒",cmps.second];
    }
    
    // 输出结果
    //NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return stringTimeInterval;
}

#pragma mark - 比较两个时间，返回天数
+ (NSInteger )compareTwoDateBackDays:(NSDate *)sDate endTime:(NSDate *)eDate
{
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type =   NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:type fromDate:sDate toDate:eDate options:0];
    return cmps.day;
}

+ (NSString *)lw_compareTwoDateMaohao:(NSDate *)sDate endTime:(NSDate *)eDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:sDate toDate:eDate options:0];
    return [NSString stringWithFormat:@"%ld:%ld:%ld",cmps.hour,cmps.minute,cmps.second];
}

- (NSString *)difftime
{
    NSDate *nowTime = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:nowTime];
    NSDate *localeDate = [nowTime  dateByAddingTimeInterval: interval];
    nowTime = localeDate;
    
    BOOL isToday = nowTime.year == self.year && nowTime.month == self.month && nowTime.day == self.day;
    
    
    //判断时间差
    NSInteger hourSecGap =  [nowTime timeIntervalSinceDate:self];
    
    //判断是不是今天
    if(isToday){
        //相差是不是超过一个小时
        NSInteger hourGap = nowTime.hour - self.hour;
        
        if ( hourSecGap > 60  * 60){
            return [NSString stringWithFormat:@"%ld小时前",hourGap];
        }
        else{//在一个小时之内
            //NSInteger minuteGap = nowTime.minute - self.minute;
            if (hourSecGap < 60){
                NSInteger secondGap = nowTime.seconds - self.seconds;
                if (secondGap < 0)
                    secondGap *= -1;
                return [NSString stringWithFormat:@"%ld秒前",secondGap];
            }else{
                return [NSString stringWithFormat:@"%ld分钟前",(long)(hourSecGap / 60)];
            }
        }
    }
    else{
        if (self.year){//同一年
            
            //月份差距
            NSInteger month = nowTime.month - self.month;
            
            if (month == 0){
                NSInteger dayGap = nowTime.day - self.day;
                
                //没有超过一个星期
                if (dayGap < 7){
                    return [NSString stringWithFormat:@"%ld天前",dayGap];
                }
            }
        }
    }
    
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dft setTimeZone:GTMzone];
    [dft setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dft stringFromDate:self];
}

+ (NSString*)weekFromTimeStamp:(long )timeStamp
{
    return [self weekFromDate:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
}

+ (NSString*)weekFromDate:(NSDate*)date
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
