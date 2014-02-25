//
//  RKiOS7Loading.h
//  iOS7StyleLoading
//
//  Created by raj on 15/12/13.
//  Copyright (c) 2013 iPhone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIColor+iOS7.h"

@interface RKiOS7Loading : UIView

/**
 * The picture to display in the center of the hud
 */
@property (nonatomic, strong) NSString *logoImageName UI_APPEARANCE_SELECTOR;

/**
 * The width of the line used to draw the indicator view.
 */
@property (nonatomic, assign) CGFloat lineWidth UI_APPEARANCE_SELECTOR;

/**
 * The color of the indicator view
 */
@property (nonatomic, strong) UIColor *tintColor UI_APPEARANCE_SELECTOR;

/**
 * Make the background layer to spin around its center. This should be called in the main thread.
 */
- (void) startSpinProgressBackgroundLayer;

/**
 * Stop the spinning of the background layer. This should be called in the main thread.
 * WARN: This implementation remove all animations from background layer.
 **/
- (void) stopSpinProgressBackgroundLayer;

/**
 * Hide the hud
 **/
- (void) hideHUD;

// To show the indicator in the View
+ (RKiOS7Loading *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

// To Hide the indicator in the View
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

@end
