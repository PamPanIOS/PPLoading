//
//  ViewController.m
//  testShapeLayer
//
//  Created by MacBook on 16/3/25.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController
{
    CAShapeLayer *layer;
    NSTimer *timer;
    
    int start;
    int end;
    
    BOOL b;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    _btn.hidden =YES;

    [self draw];
}
- (void)draw
{

    
    start = 0;
    end = 0;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    if (layer)
    {
        [layer removeFromSuperlayer];
        layer = nil;
    }
    layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, 200, 200);
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.path = circlePath.CGPath;
    layer.lineWidth = 1.0;
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.position = self.view.center;
    layer.strokeStart = start/10.0;
    layer.strokeEnd = end/10.0;
    [self.view.layer addSublayer:layer];

    
}

- (void)updateLayer
{
    if (start == 0 && end < 10)
    {
        end +=1;
    }
    else if (start < 10  && end == 10)
    {
        
        start +=1;

    }
    else
    {
//        start = end = 0;
        [timer invalidate];
        [self draw];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                 target:self
                                               selector:@selector(updateLayer)
                                               userInfo:nil
                                                repeats:YES];
        return;
    }

    layer.strokeStart = start/10.0;
    layer.strokeEnd = end/10.0;
}


- (IBAction)clickForShake:(id)sender
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[@0,@10,@0,@-10,@0,@10,@0];
    animation.keyTimes = @[@0,@(1/6.0),@(2/6.0),@(3/6.0),@(4/6.0),@(5/6.0),@1];
    animation.duration = 0.5;
    animation.additive = YES;
    [_btn.layer addAnimation:animation forKey:@"shake"];
    
    
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                 target:self
                                               selector:@selector(updateLayer)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
