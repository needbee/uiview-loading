//
//  UIView+Loading.m
//  Scriptive
//
//  Created by Josh Justice on 3/1/14.
//  Copyright (c) 2014 Scriptive. All rights reserved.
//

#import "UIView+Loading.h"
#import <objc/runtime.h>

#define DATA_LOADER_KEY @"dataLoader"
#define RELOAD_VIEW_KEY @"reloadView"
#define MESSAGE_LABEL_KEY @"messageLabel"
#define LOADING_VIEW_KEY @"loadingView"
#define ACTIVITY_KEY @"activityKey"

@implementation UIView (Loading)

-(void)loadDataFromLoader:(DataLoader)dataLoader
{

    objc_setAssociatedObject(self, DATA_LOADER_KEY, dataLoader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self loadData];
}

-(void)loadDataInner
{
    DataLoader loader = (DataLoader)objc_getAssociatedObject(self, DATA_LOADER_KEY);
    loader();
}

-(void)loadData
{
    NSLog(@"showing loading view");
    [self addSubview:[self loadingCoverView]];
    
//    if( LOAD_DELAY ) {
//        [self performSelector:@selector(loadDataInner)
//                   withObject:nil
//                   afterDelay:1.0];
//    } else {
        [self loadDataInner];
//    }
}

-(void)reloadTap
{
    NSLog(@"hiding reload view");
    UIView *coverView = (UIView *)objc_getAssociatedObject(self, RELOAD_VIEW_KEY);
    [coverView removeFromSuperview];
    [self loadData];
}

-(void)hideLoadingPrompt
{
    NSLog(@"hiding loading view");
    UIView *coverView = (UIView *)objc_getAssociatedObject(self, LOADING_VIEW_KEY);
    [coverView removeFromSuperview];
}

-(void)displayReloadPrompt
{
    [self hideLoadingPrompt];
    NSLog(@"showing reload view");
    [self addSubview:[self reloadCoverView]];
}

-(UIView *)reloadCoverView {
    UIView *coverView = (UIView *)objc_getAssociatedObject(self, RELOAD_VIEW_KEY);
    if( !coverView ) {
        coverView = [[UIView alloc] initWithFrame:self.bounds];
        coverView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        UILabel *messageLabel = [self reloadMessageLabel];
        [messageLabel sizeToFit];
        float centerX = coverView.bounds.size.width / 2;
        float centerY = coverView.bounds.size.height / 2;
        messageLabel.center = CGPointMake(centerX, centerY);
        [coverView addSubview:messageLabel];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(reloadTap)];
        [coverView addGestureRecognizer:tapGesture];
        
        objc_setAssociatedObject(self, RELOAD_VIEW_KEY, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return coverView;
}

-(UILabel *)reloadMessageLabel {
    UILabel *messageLabel = (UILabel *)objc_getAssociatedObject(self, MESSAGE_LABEL_KEY);
    if( !messageLabel ) {
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 40.0)];
        messageLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.text = @"An error occurred.\nTap to retry.";
        messageLabel.numberOfLines = 0; // unlimited
        
        objc_setAssociatedObject(self, MESSAGE_LABEL_KEY, messageLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return messageLabel;
}

-(UIView *)loadingCoverView {
    UIView *coverView = (UIView *)objc_getAssociatedObject(self, LOADING_VIEW_KEY);
    if( !coverView ) {
        coverView = [[UIView alloc] initWithFrame:self.bounds];
        coverView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        UIActivityIndicatorView *indicator = [self loadingIndicator];
        float centerX = coverView.bounds.size.width / 2;
        float centerY = coverView.bounds.size.height / 2;
        indicator.center = CGPointMake(centerX, centerY);
        [indicator startAnimating];
        [coverView addSubview:indicator];
        
        objc_setAssociatedObject(self, LOADING_VIEW_KEY, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return coverView;
}

-(UIActivityIndicatorView *)loadingIndicator {
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, ACTIVITY_KEY);
    if( !indicator ) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        
        objc_setAssociatedObject(self, ACTIVITY_KEY, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return indicator;
}

@end
