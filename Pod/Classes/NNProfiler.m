//
//  NNProfiler.m
//  NNProfiler
//
//  Created by noughts on 2014/05/24.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "NNProfiler.h"
// :: Framework ::
#import "NBULogStub.h"

static NSMutableDictionary* data;
static NSString* lastLabel;


@implementation NNProfiler

+(void)start:(NSString*)label{
	if( !data ){
		data = [[NSMutableDictionary alloc] init];
	}
	data[label] = [NSDate date];
	lastLabel = label;

}


+(void)endWithLogLevel:(NNProfilerLogLevel)logLevel{
	[self endWithLabel:lastLabel logLevel:NNProfilerLogLevelInfo];
}

+(void)end{
	[self endWithLabel:lastLabel logLevel:NNProfilerLogLevelInfo];
}


+(void)endWithLabel:(NSString*)label logLevel:(NNProfilerLogLevel)logLevel{
	if( !label ){
		NBULogWarn(@"labelを指定してください");
		return;
	}
	NSDate* startDate = data[label];
	if( !startDate ){
		NBULogWarn(@"label:%@がありません", label);
		return;
	}
	
	NSDate* currentDate = [NSDate date];
	float gap = [currentDate timeIntervalSinceDate:startDate] * 1000;
	NSString* log = [NSString stringWithFormat:@"%@ %f ms.", label, gap];
	[self logWithLogLevel:logLevel body:log];
	[data removeObjectForKey:label];
	lastLabel = nil;
}





+(void)end:(NSString*)label{
	[self endWithLabel:label logLevel:NNProfilerLogLevelVerbose];
}



+(void)logWithLogLevel:(NNProfilerLogLevel)logLevel body:(id)body{
	switch (logLevel) {
		case NNProfilerLogLevelVerbose:
			NBULogVerbose(@"%@", body);
			break;
		case NNProfilerLogLevelDebug:
			NBULogDebug(@"%@", body);
			break;
		case NNProfilerLogLevelInfo:
			NBULogInfo(@"%@",body);
			break;
	}
}


+(NSString*)safeArray:(NSArray*)array objectAtIndex:(NSInteger)index{
	if( !array ){
		return @"";
	}
	if( array.count < index ){
		return @"";
	} else {
		return array[index];
	}
}


/*
 +(void)endWithLabel:(NSString*)label logLevel:(NNProfilerLogLevel)logLevel{
 #if DEBUG
 #else
	return;// リリース時には処理しない
 #endif
	NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
	NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
	NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
	[array removeObject:@""];
	
	NSString* frameworkName = [self safeArray:array objectAtIndex:0];
	NSString* callerClassName = [self safeArray:array objectAtIndex:3];
	NSString* callerFunctionsName = [self safeArray:array objectAtIndex:4];
	NSString* callerLineNumber = [self safeArray:array objectAtIndex:5];
	
	
	NSDate* startDate = data[label];
	if( !startDate ){
 NSString* log = [NSString stringWithFormat:@"[%@][%@(%@) %@] label:%@がありません", frameworkName, callerClassName, callerLineNumber, callerFunctionsName, label];
 [self logWithLogLevel:logLevel body:log];
 return;
	}
	
	NSDate* currentDate = [NSDate date];
	float gap = [currentDate timeIntervalSinceDate:startDate] * 1000;
	NSString* log = [NSString stringWithFormat:@"[%@][%@(%@) %@] %@ %f ms.", frameworkName, callerClassName, callerLineNumber, callerFunctionsName, label, gap];
	[self logWithLogLevel:logLevel body:log];
	[data removeObjectForKey:label];
 }
 */


@end
