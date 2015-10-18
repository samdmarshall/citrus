//
//  NSObject_Extension.m
//  CitrusPlugin
//
//  Created by Samantha Marshall on 10/18/15.
//  Copyright © 2015 Samantha Marshall. All rights reserved.
//


#import "NSObject_Extension.h"
#import "CitrusPlugin.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
	
	NSDictionary *bundleInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentApplicationName = [bundleInfoDictionary objectForKey:@"CFBundleName"];
	
	// this should load regardless of how xcode is launched
	BOOL isXcode = [currentApplicationName isEqualToString:@"Xcode"];
	BOOL isXcodeBuild = [currentApplicationName isEqualToString:@"xcodebuild"];
	
    if (isXcode || isXcodeBuild) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[CitrusPlugin alloc] initWithBundle:plugin];
        });
    }
}
@end
