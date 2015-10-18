//
//  CitrusPlugin.h
//  CitrusPlugin
//
//  Created by Samantha Marshall on 10/18/15.
//  Copyright © 2015 Samantha Marshall. All rights reserved.
//

#import <AppKit/AppKit.h>

@class CitrusPlugin;

static CitrusPlugin *sharedPlugin;

@interface CitrusPlugin : NSObject

@property (nonatomic, strong, readonly) NSBundle* bundle;

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@end