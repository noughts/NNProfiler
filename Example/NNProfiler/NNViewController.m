//
//  NNViewController.m
//  NNProfiler
//
//  Created by koichi yamamoto on 04/13/2015.
//  Copyright (c) 2014 koichi yamamoto. All rights reserved.
//

#import "NNViewController.h"
#import <NNProfiler.h>

@implementation NNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[NNProfiler start:@"hoge"];
	[NNProfiler end];
	[NNProfiler end];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
