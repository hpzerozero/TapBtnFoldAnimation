//
//  ViewController.m
//  AnimationTest
//
//  Created by hp on 16/6/30.
//  Copyright © 2016年 FrSky. All rights reserved.
//
#import "ViewController.h"
#import "TapBtnView.h"
#import "UIView+Frame.h"

NS_ENUM(NSInteger, RemDataSetting) {
    sys,
    mol,
    tele
};
@interface ViewController ()
@property (strong, nonatomic) TapBtnView *mainBtn;
@property (strong, nonatomic) TapBtnView *sysBtn;
@property (strong, nonatomic) TapBtnView *molBtn;
@property (strong, nonatomic) TapBtnView *teleBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainBtn];
}


#pragma mark -
- (TapBtnView *)mainBtn
{
    if (!_mainBtn) {
        CGPoint point = CGPointMake(self.view.cx, self.view.cy+H(20));
        _mainBtn = [[TapBtnView alloc] initWithRadius:W(50) center:point];
        [_mainBtn addTarget:self action:@selector(showTapButton)];
        _mainBtn.title = @"Tap Me";
    }
    return _mainBtn;
}

- (TapBtnView *)sysBtn
{
    if (!_sysBtn) {
        _sysBtn = [[TapBtnView alloc] initWithRadius:self.mainBtn.radius center:self.mainBtn.center];
        _sysBtn.tag = sys;
        [_sysBtn addTarget:self action:@selector(showVCWithSender:)];
        _sysBtn.title = @"SYS";
        _sysBtn.tapBtnColor = [UIColor redColor];
    }
    return _sysBtn;
}

- (TapBtnView *)molBtn
{
    if (!_molBtn) {
        _molBtn = [[TapBtnView alloc] initWithRadius:self.mainBtn.radius center:self.mainBtn.center];
        _molBtn.tag = mol;
        [_molBtn addTarget:self action:@selector(showVCWithSender:)];
        _molBtn.tapBtnColor = [UIColor blueColor];
        _molBtn.title = @"MOL";
    }
    return _molBtn;
}

- (TapBtnView *)teleBtn
{
    if (!_teleBtn) {
        _teleBtn = [[TapBtnView alloc] initWithRadius:self.mainBtn.radius center:self.mainBtn.center];
        [_teleBtn addTarget:self action:@selector(showVCWithSender:)];
        _teleBtn.tapBtnColor = [UIColor magentaColor];
        _teleBtn.title = @"TELE";
    }
    return _teleBtn;
}

#pragma mark -
- (void)showTapButton
{
    
    self.mainBtn.tap = !self.mainBtn.tap;
    if (self.mainBtn.tap) {
        [TapBtnView animateWithDuration:ANIMATEDURATION_FOLD delay:0 options:UIViewAnimationOptionTransitionNone animationPrevious:^{
            
            [self.view addSubview:self.sysBtn];
            [self.view addSubview:self.molBtn];
            [self.view addSubview:self.teleBtn];
        } animations:^{
            CGFloat delta = 10;
            CGFloat distance = (delta +2 *self.mainBtn.radius);
            CGFloat dx = distance * cosf(M_PI/6);
            CGFloat dy = distance * sinf(M_PI/6);
            self.sysBtn.center = CGPointMake(self.mainBtn.cx, self.mainBtn.cy-distance);
            self.molBtn.center = CGPointMake(self.mainBtn.cx-dx, self.mainBtn.cy+dy);
            self.teleBtn.center = CGPointMake(self.mainBtn.cx+dx, self.mainBtn.cy+dy);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        [TapBtnView animateWithDuration:ANIMATEDURATION_UNFOLD delay:0 options:UIViewAnimationOptionTransitionNone animationPrevious:nil animations:^{
            
            self.sysBtn.center = self.mainBtn.center;
            self.molBtn.center = self.mainBtn.center;
            self.teleBtn.center = self.mainBtn.center;
            
        } completion:^(BOOL finished) {
            
            [self.sysBtn removeFromSuperview];
            [self.molBtn removeFromSuperview];
            [self.teleBtn removeFromSuperview];
            
        }];
    }
}

- (void)showVCWithSender:(id)sender
{
    TapBtnView *btn = sender;
    UIViewController *vc = nil;
    switch (btn.tag) {
        case sys:
            
            vc = [[UIViewController alloc] init];
            vc.title = @"SYSTEM";
            vc.view.backgroundColor = [UIColor redColor];
            break;
        case mol:
            
            vc = [[UIViewController alloc] init];
            vc.title = @"MODEL";
            vc.view.backgroundColor = [UIColor blueColor];
            break;
        case tele:
            
            vc = [[UIViewController alloc] init];
            vc.title = @"TELEMETRY";
            vc.view.backgroundColor = [UIColor magentaColor];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
