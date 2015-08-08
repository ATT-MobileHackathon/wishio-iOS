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

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
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

- (void)fillWidth {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.size.width = CGRectGetWidth(self.superview.frame) - CGRectGetMinX(self.frame);
        self.frame = frame;
    }
}

- (void)fillWidthWithMargin:(CGFloat)margin {
    if (self.superview) {
        [self fillWidth];
        [self setWidth:CGRectGetWidth(self.frame) - margin];
    }
}

- (void)fillHeight {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.size.height = CGRectGetHeight(self.superview.frame) - CGRectGetMinY(self.frame);
        self.frame = frame;
    }
}

- (void)fillHeightWithMargin:(CGFloat)margin {
    if (self.superview) {
        [self fillHeight];
        [self setHeight:CGRectGetHeight(self.frame) - margin];
    }
}

- (void)centerHorizontally {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.origin.x = CGRectGetWidth(self.superview.frame)/2 - CGRectGetWidth(self.frame)/2;
        self.frame = frame;
    }
}

- (void)centerVertically {
    if (self.superview) {
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetHeight(self.superview.frame)/2 - CGRectGetHeight(self.frame)/2;
        self.frame = frame;
    }
}

@end
