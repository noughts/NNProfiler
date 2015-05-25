//
//  NNProfiler.h
//  NNProfiler
//
//  Created by noughts on 2014/05/24.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, NNProfilerLogLevel) {
	NNProfilerLogLevelVerbose,
	NNProfilerLogLevelDebug,
	NNProfilerLogLevelInfo
};



@interface NNProfiler : NSObject



+(void)start:(NSString*)label;
+(void)end:(NSString*)label;
+(void)end;
+(void)endWithLogLevel:(NNProfilerLogLevel)logLevel;

@end
