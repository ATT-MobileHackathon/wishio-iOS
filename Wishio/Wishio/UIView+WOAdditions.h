//
//  UIView+WOAdditions.h
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WOAdditions)

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)alignRightWithMargin:(CGFloat)margin;
- (void)alignBottomWithMargin:(CGFloat)margin;
- (void)fillWidth;
- (void)fillHeight;
- (void)centerHorizontally;
- (void)centerVertically;

@end
