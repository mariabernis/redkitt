//
//  UIColor+TrackMyRadars.h
//  TrackMyRadars
//
//  Created by Maria Bernis on 03/12/14.
//  Copyright (c) 2014 mariabernis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RedKitt)

+ (UIColor *)redboothColor;
+ (UIColor *)redboothColorDarken;

// Examples methods we can implement when we know the colors
+ (UIColor *)rkMainColor;
+ (UIColor *)rkMainColorDarker;
+ (UIColor *)rkMainColorLighter;
+ (UIColor *)rkMainColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)rkWhiteColor;
+ (UIColor *)rkTintColor;
+ (UIColor *)rkDisabledColor;

@end
