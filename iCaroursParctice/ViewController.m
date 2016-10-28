//
//  ViewController.m
//  iCaroursParctice
//
//  Created by shengli on 2016/10/16.
//  Copyright © 2016年 shenglishengli. All rights reserved.
//

#import "ViewController.h"
#import <iCarousel.h>

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic) iCarousel *carousel;
@property (nonatomic) CGSize itemSize;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat itemWidth = kScreenWidth * 5.0 / 7.0;
    self.itemSize = CGSizeMake(itemWidth, itemWidth * 16.0/9.0);
    
    self.carousel = [[iCarousel alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.carousel];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeCustom;
    self.carousel.backgroundColor = [UIColor grayColor];
    self.carousel.bounceDistance = 0.1;
    self.carousel.pagingEnabled = NO;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 8;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.itemSize.width, self.itemSize.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.itemSize.width, self.itemSize.height)];
        label.text = [@(index) stringValue];
        label.font = [UIFont systemFontOfSize:50];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        [view addSubview:label];
    }
    return view;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    NSLog(@"offset>>>%f",offset);
    CGFloat scale = [self calcScaleWithOffset:offset];
    CGFloat translation = [self calcTranslationWithOffset:offset];
    return CATransform3DScale(CATransform3DTranslate(transform, translation * self.itemSize.width, 0, offset), scale, scale, 0);
}

// 计算缩放
- (CGFloat)calcScaleWithOffset:(CGFloat)offset {
    return offset * 0.02 + 1.0;
}

// 计算位移
- (CGFloat)calcTranslationWithOffset:(CGFloat)offset {
    CGFloat a = 5.0/4.0;
    CGFloat b = 5.0/8.0;
    
    // 移除屏幕
    if (offset >= a/b) {
        return 2.0;
    }
    
    return 1/(a-b*offset) - 1/a;
}

//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
//{
//    if (option == iCarouselOptionWrap) {
//        return YES;
//    }
//    return value;
//}

@end
