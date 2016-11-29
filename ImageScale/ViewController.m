//
//  ViewController.m
//  ImageScale
//
//  Created by txx on 16/11/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView   *scrollView;
@property(nonatomic,strong)UIImageView    *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    
    //contentsize setting must,or can not slip,current setting img size
    _scrollView.contentSize = _imageView.frame.size ;
    
    //implement span,maximumZoomScale must big than minimumZoomScale,in this time must implement method viewForZoomingInScrollView
    _scrollView.minimumZoomScale = 0.6 ;
    _scrollView.maximumZoomScale = 3.0;
}
// implement span
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
//when image size smaller than screen size,put image in the screen center
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize originalSize = _scrollView.bounds.size ;
    CGSize contentSize = _scrollView.contentSize ;
    CGFloat offsetX=originalSize.width>contentSize.width?(originalSize.width-contentSize.width)/2:0;
    CGFloat offsetY=originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2:0;
    _imageView.center=CGPointMake(contentSize.width/2+offsetX, contentSize.height/2+offsetY);
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentMode = UIViewContentModeScaleAspectFill;
        _scrollView.delegate = self ;
        _scrollView.showsVerticalScrollIndicator = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
        
        //边距，不属于内容部分，内容坐标（0，0）指的是内容的左上角不包括边界
        //_scrollView.contentInset = UIEdgeInsetsMake(10, 20, 10, 20);
                
        //禁用弹簧效果
        _scrollView.bounces = NO;
        [_scrollView addSubview:self.imageView];
    }
    return _scrollView ;
}
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"111.jpg"]];
        _imageView.frame = [UIScreen mainScreen].bounds;
    }
    return _imageView ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
