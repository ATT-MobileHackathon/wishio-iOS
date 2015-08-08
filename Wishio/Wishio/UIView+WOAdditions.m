//
//  UIView+WOAdditions.m
//  Wishio
//
//  Created by Andrew on 8/8/15.
//  Copyright (c) 2015 Wishio. All rights reserved.
//

#import "UIView+WOAdditions.h"

@implementation UIView (WOAdditions)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)alignRightWithMargin:(CGFloat)margin {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.origin.x = CGRectGetWidth(self.superview.frame) - CGRectGetWidth(self.frame) - margin;
        self.frame = frame;
    }
}

- (void)alignBottomWithMargin:(CGFloat)margin {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetHeight(self.superview.frame) - CGRectGetHeight(self.frame) - margin;
        self.frame = frame;
    }
}

@end
