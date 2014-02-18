//
//  RKiOS7Loading_UIWindow.m
//  RKiOS7Loading+UIWindow
//
//  Created by Simone Fantini on 18/02/14.
//  Copyright (c) 2014 BSDSoftware. All rights reserved.
//

#import "RKiOS7Loading+Window.h"

@implementation RKiOS7Loading (Window)

static UIWindow *_hudWindow;
static RKiOS7Loading *_hudInstance;

+ (void)showHUDOnTop {
	@synchronized(_hudInstance) {
		if (_hudInstance)
			return;
		
		_hudWindow = [[UIWindow alloc] initWithFrame:(CGRect){0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size}];
		_hudWindow.windowLevel = UIWindowLevelStatusBar;
		_hudWindow.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.6];
		[_hudWindow makeKeyAndVisible];
		_hudInstance = [RKiOS7Loading showHUDAddedTo:_hudWindow animated:YES];
		[_hudInstance startSpinProgressBackgroundLayer];
		
		[UIView animateWithDuration:0.3 animations:^{
			_hudWindow.frame = [UIScreen mainScreen].bounds;
		}];
	}
}

+ (void)hideHUD {
	@synchronized(_hudInstance) {
		if (_hudInstance) {
			[UIView animateWithDuration:0.3 animations:^{
				_hudWindow.frame = (CGRect){0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size};
			} completion:^(BOOL finished) {
				[_hudInstance stopSpinProgressBackgroundLayer];
				_hudInstance = nil;
				[RKiOS7Loading hideHUDForView:_hudWindow animated:NO];
				_hudWindow.hidden = YES;
				_hudWindow = nil;
			}];
		}
	}
}

@end
