//
//  LMTitlesScrollView.h
//  LMTitlesScrollview
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 migi Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LMTitlesScrollViewDelegate <NSObject>

@optional
- (void)titlesScrollViewDidClicked:(NSInteger)index;

@end
@interface LMTitlesScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)id<LMTitlesScrollViewDelegate>delegate;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)UIView       *lineView;
@property(nonatomic,strong)UIButton *currentButton;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<LMTitlesScrollViewDelegate>)delegate;

@end
