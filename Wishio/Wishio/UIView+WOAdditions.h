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
- (void)setSize:(CGSize)size;
- (void)alignRightWithMargin:(CGFloat)margin;
- (void)alignBottomWithMargin:(CGFloat)margin;

@end
