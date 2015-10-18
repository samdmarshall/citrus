//
//  CitrusPlugin.m
//  CitrusPlugin
//
//  Created by Samantha Marshall on 10/18/15.
//  Copyright © 2015 Samantha Marshall. All rights reserved.
//

#import "CitrusPlugin.h"

@interface CitrusPlugin() {
	NSBundle *_bundle;
}
@end

@implementation CitrusPlugin

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
	self = [super init];
    if (self != nil) {
        // reference to plugin's bundle, for resource access
        _bundle = plugin;
		dispatch_async(dispatch_get_main_queue(), ^{
			NSLog(@"Loaded CitrusPlugin v%@ (%@)", [plugin objectForInfoDictionaryKey:@"CFBundleShortVersionString"], [plugin objectForInfoDictionaryKey:@"CFBundleVersion"]);
		});
    }
    return self;
}

@end
