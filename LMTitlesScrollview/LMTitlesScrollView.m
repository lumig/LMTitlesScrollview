//
//  LMTitlesScrollView.m
//  LMTitlesScrollview
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 migi Lu. All rights reserved.
//

#import "LMTitlesScrollView.h"

#define kButtonWidth 80


#define COLOR_TINT_BG [UIColor colorWithRed:(0.49f) green:(0.73f) blue:(0.21f) alpha:(1)]


@implementation LMTitlesScrollView

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<LMTitlesScrollViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.userInteractionEnabled = YES;
        _titles = titles;
        self.delegate = delegate;
        _currentIndex = 0;
        
        [self setupSubView];
    }
    return self;
}


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    UIButton *button = (UIButton *)[self.scrollView viewWithTag:_currentIndex + 10];
    
    if (button)
    {
        [self buttonChange:button];
    }
}


- (void)setupSubView
{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView];
    
    for (int i = 0; i < [_titles count]; i++)
    {
        [self addButtonWithTitle:_titles[i] tag:i];
    }
    
    self.scrollView.contentSize = CGSizeMake([_titles count] * kButtonWidth, self.frame.size.height);
}

- (void)addButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(tag * kButtonWidth, 0, kButtonWidth, self.frame.size.height);
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.tag = tag + 10;
    
    button.highlighted = NO;
    
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    if (tag  == _currentIndex)
    {
        [button setTitleColor:COLOR_TINT_BG forState:UIControlStateNormal];
        _currentButton = button;
    }
    else
    {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button];
}


- (void)buttonClick:(UIButton *)button
{
    if (_currentButton == button) {
        return;
    }
    
    [self buttonChange:button];
    
    if ([self.delegate respondsToSelector:@selector(titlesScrollViewDidClicked:)])
    {
        [self.delegate titlesScrollViewDidClicked:_currentIndex];
    }
}


- (void)buttonChange:(UIButton *)button
{
    [_currentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitleColor:COLOR_TINT_BG forState:UIControlStateNormal];
    
    _currentButton = button;
    
    _currentIndex = button.tag - 10;
    
    CGRect rect = self.lineView.frame;
    
    rect.origin.x = _currentIndex * kButtonWidth;
    
    CGFloat offX = 0;
    
    if (_currentIndex * kButtonWidth > 0 && _currentIndex * kButtonWidth < self.scrollView.contentSize.width)
    {
        offX = _currentIndex * kButtonWidth - kButtonWidth;
    }
    
    if (offX + self.frame.size.width > self.scrollView.contentSize.width)
    {
        offX = self.scrollView.contentSize.width - self.frame.size.width;
    }
    
    
    [self.scrollView setContentOffset:CGPointMake(offX, 0) animated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.frame = rect;
    }];
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        //        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 2, kButtonWidth, 2)];
        _lineView.backgroundColor = COLOR_TINT_BG;
    }
    
    return _lineView;
}



@end
