//
//  NBViewController.m
//  demo
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBViewController.h"
#import "UIView+Loading.h"

@interface NBViewController ()

@property (weak, nonatomic) IBOutlet UIView *container;

-(void)finishLoad;
-(void)finishLoadError;

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startLoad:(id)sender {
    [_container loadDataFromLoader:^() {
        NSLog(@"This is where you'd load data asynchronously. Simulating with a delayed performSelector");
        [self performSelector:@selector(finishLoad)
                   withObject:nil
                   afterDelay:1.0];
    }];
}

-(void)finishLoad {
    NSLog(@"This is where you'd handle the loaded data, then hide the loading prompt.");
    [_container hideLoadingPrompt];
}

- (IBAction)startLoadError:(id)sender {
    [_container loadDataFromLoader:^() {
        NSLog(@"This simulated call will fail. Usually you wouldn't have separate methods for this, just one, and the result selector would handle both the success and error case.");
        [self performSelector:@selector(finishLoadError)
                   withObject:nil
                   afterDelay:1.0];
    }];
}

-(void)finishLoadError {
    NSLog(@"If an error occurs, show the reload prompt. It will let the user rerun");
    [_container displayReloadPrompt];
}

@end
