//
//  ADFileLoggerFormatter.m
//  ADUtils
//
//  Created by Pierre Felgines on 13/06/16.
//
//

#import "ADFileLoggerFormatter.h"
#import <CocoaLumberJack/CocoaLumberJack.h>
#import <libkern/OSAtomic.h>

static NSString *const ADMethodLogFormatterCalendarKey = @"ADMethodLogFormatterCalendarKey";

NS_INLINE const char *ADLogFlagToCString(int logFlag) {
    switch (logFlag) {
        case DDLogFlagError:
            return "ERR";
        case DDLogFlagWarning:
            return "WRN";
        case DDLogFlagInfo:
            return "INF";
        case DDLogFlagDebug:
            return "DBG";
        case DDLogFlagVerbose:
            return "VRB";
        default:
            return "";
    }
}

@interface ADFileLoggerFormatter () {
    int32_t _atomicLoggerCount;
    NSCalendar * _threadUnsafeCalendar;
}
- (NSCalendar *)_threadSafeCalendar;
@end

@implementation ADFileLoggerFormatter

#pragma mark - DDLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {

    NSCalendarUnit units = (NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents * components = [[self _threadSafeCalendar] components:units
                                                                  fromDate:logMessage->_timestamp];
    NSTimeInterval epoch = [logMessage->_timestamp timeIntervalSinceReferenceDate];
    int milliseconds = (int)((epoch - floor(epoch)) * 1000);

    NSString *formattedMsg = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld:%03d [%s] %@:%lu (%@): %@",
                              (long)components.year,
                              (long)components.month,
                              (long)components.day,
                              (long)components.hour,
                              (long)components.minute,
                              (long)components.second,
                              milliseconds,
                              ADLogFlagToCString(logMessage->_flag),
                              [logMessage->_file lastPathComponent],
                              (unsigned long)logMessage->_line,
                              logMessage->_function ?: @"",
                              logMessage->_message];

    return formattedMsg;
}

- (void)didAddToLogger:(id<DDLogger>)logger {
    OSAtomicIncrement32(&_atomicLoggerCount);
}

- (void)willRemoveFromLogger:(id<DDLogger>)logger {
    OSAtomicDecrement32(&_atomicLoggerCount);
}

#pragma mark - Private

- (NSCalendar *)_threadSafeCalendar {
    int32_t loggerCount = OSAtomicAdd32(0, &_atomicLoggerCount);
    if (loggerCount <= 1) {
        // Single threaded
        if (!_threadUnsafeCalendar) {
            _threadUnsafeCalendar = [NSCalendar autoupdatingCurrentCalendar];
        }
        return _threadUnsafeCalendar;
    } else {
        NSMutableDictionary * threadDictionary = [[NSThread currentThread] threadDictionary];
        NSCalendar * threadCalendar = threadDictionary[ADMethodLogFormatterCalendarKey];
        if (!threadCalendar) {
            threadCalendar = [NSCalendar autoupdatingCurrentCalendar];
            threadDictionary[ADMethodLogFormatterCalendarKey] = threadCalendar;
        }
        return threadCalendar;
    }
}

@end

