//
//  NNProfiler.m
//  NNProfiler
//
//  Created by noughts on 2014/05/24.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "NNProfiler.h"

static NSMutableDictionary* data;

@implementation NNProfiler

+(void)start:(NSString*)label{
	if( !data ){
		data = [[NSMutableDictionary alloc] init];
	}
	data[label] = [NSDate date];
}

+(void)end:(NSString*)label{
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
		NSLog( @"%@", log );
		return;
	}
	
	NSDate* currentDate = [NSDate date];
	float gap = [currentDate timeIntervalSinceDate:startDate] * 1000;
	NSString* log = [NSString stringWithFormat:@"[%@][%@(%@) %@] %@ %f ms.", frameworkName, callerClassName, callerLineNumber, callerFunctionsName, label, gap];
	NSLog( @"%@", log );
	[data removeObjectForKey:label];
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

@end
