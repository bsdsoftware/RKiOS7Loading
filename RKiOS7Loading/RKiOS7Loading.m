//
//  RKiOS7Loading.m
//  iOS7StyleLoading
//
//  Created by raj on 15/12/13.
//  Copyright (c) 2013 iPhone. All rights reserved.
//

//We are going to see how easy is to display and hide the  indicator with just single line of code in your ViewControllers.
#import "RKiOS7Loading.h"

@interface RKiOS7Loading()
@property (nonatomic, strong) CAShapeLayer *progressBackgroundLayer;
@property (nonatomic, assign) BOOL isSpinning;
@property (nonatomic, strong) UIImageView *logoImageView;
@end

@implementation RKiOS7Loading

// To add the iOS7 Loading on to screen
+ (RKiOS7Loading *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    RKiOS7Loading *hud = [[RKiOS7Loading alloc] initWithFrame:CGRectMake(40, 40, 60, 60)];
  	hud.hidden = NO;
    [hud startSpinProgressBackgroundLayer];
    [view addSubview:hud];
    float height = view.bounds.size.height;
    float width = view.bounds.size.width;
    CGPoint center = CGPointMake(width/2, height/2);
    hud.center = center;
	return hud;
}

// To hide the iOS7 Loading 
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
	RKiOS7Loading *hud = [RKiOS7Loading HUDForView:view];
    [hud stopSpinProgressBackgroundLayer];
	if (hud != nil) {
		//hud.hidden =YES;
        [hud removeFromSuperview];
		return YES;
	}
	return NO;
}

// Method to search for the visible iOS7 loading and hide it
+ (RKiOS7Loading *)HUDForView:(UIView *)view {
	RKiOS7Loading *hud = nil;
	NSArray *subviews = view.subviews;
	Class hudClass = [RKiOS7Loading class];
	for (UIView *aView in subviews) {
		if ([aView isKindOfClass:hudClass]) {
			hud = (RKiOS7Loading *)aView;
		}
	}
	return hud;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setLogoImageName:(NSString *)logoImageName {
	_logoImageName = logoImageName;
	self.logoImageView.image = [UIImage imageNamed:_logoImageName];
}

- (void)setTintColor:(UIColor *)tintColor {
	if (!tintColor) {
		tintColor = [UIColor ios7TrueBlue];
	}
	_tintColor = tintColor;
	_progressBackgroundLayer.strokeColor = _tintColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
	_lineWidth = lineWidth;
	_progressBackgroundLayer.lineWidth = _lineWidth;
}

- (void)setup
{
	self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
	self.logoImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self addSubview:self.logoImageView];
	
    // To set the background color of the UIView and default is clear color
    // Add more color if you wish to have 
    self.backgroundColor = [UIColor clearColor];
	
    // Customise the Width of the cirle line and get the max of two
    _lineWidth = fmaxf(self.frame.size.width * 0.025, 1.f);
    
    // Set the tint color of the circle
    _tintColor = [UIColor ios7TrueBlue];
    
    //Round progress View
    self.progressBackgroundLayer = [CAShapeLayer layer];
    _progressBackgroundLayer.strokeColor = _tintColor.CGColor;
    _progressBackgroundLayer.fillColor = self.backgroundColor.CGColor;
    _progressBackgroundLayer.lineCap = kCALineCapRound;
    _progressBackgroundLayer.lineWidth = _lineWidth;
    [self.layer addSublayer:_progressBackgroundLayer];
    
}

- (void)hideHUD
{
	[self stopSpinProgressBackgroundLayer];
	[self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect
{
    // Make sure the layers cover the whole view
    _progressBackgroundLayer.frame = self.bounds;
    
}

#pragma mark -
#pragma mark Drawing

- (void) drawBackgroundCircle:(BOOL) partial {
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - _lineWidth)/2;
    
    // Draw background
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = _lineWidth;
    
    // Recompute the end angle to make it at 90% of the progress
    if (partial) {
        endAngle = (1.8F * (float)M_PI) + startAngle;
    }
    
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _progressBackgroundLayer.path = processBackgroundPath.CGPath;
}

- (void) startSpinProgressBackgroundLayer {
    self.isSpinning = YES;
    [self drawBackgroundCircle:YES];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    [_progressBackgroundLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void) stopSpinProgressBackgroundLayer {
    [self drawBackgroundCircle:NO];
    [_progressBackgroundLayer removeAllAnimations];
    self.isSpinning = NO;
}


@end
