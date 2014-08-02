//
//  UIView+Loading.h
//  Scriptive
//
//  Created by Josh Justice on 3/1/14.
//  Copyright (c) 2014 Scriptive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DataLoader)();

@interface UIView (Loading)

-(void)loadDataFromLoader:(DataLoader)dataLoader;
-(void)loadData;
-(void)reloadTap;
-(void)displayReloadPrompt;
-(void)hideLoadingPrompt;

-(UIView *)reloadCoverView;
-(UILabel *)reloadMessageLabel;

-(UIView *)loadingCoverView;
-(UIActivityIndicatorView *)loadingIndicator;


@end
