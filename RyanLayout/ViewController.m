//
//  ViewController.m
//  RyanLayout
//
//  Created by Ryan Poolos on 11/14/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *orangeView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.orangeView];
    
    NSDictionary *metrics = @{@"padding": @20.0};

    NSDictionary *views = @{@"blue": self.blueView,
                            @"green": self.greenView,
                            @"orange": self.orangeView};
    
    // The "squishy" layout
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[blue(==green)]-(padding)-[green(==blue)]-(padding)-|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[orange]-(padding)-|" options:0 metrics:metrics views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[blue(==orange)]-(padding)-[orange(==blue)]-(padding)-|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[green(==orange)]-(padding)-[orange(==green)]-(padding)-|" options:0 metrics:metrics views:views]];
    
    // The "sliding" layout
    
}

#pragma mark - Views

- (UIView *)blueView
{
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectZero];
        [_blueView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_blueView setBackgroundColor:[UIColor blueColor]];
    }
    
    return _blueView;
}

- (UIView *)greenView
{
    if (!_greenView) {
        _greenView = [[UIView alloc] initWithFrame:CGRectZero];
        [_greenView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_greenView setBackgroundColor:[UIColor greenColor]];
    }
    
    return _greenView;
}

- (UIView *)orangeView
{
    if (!_orangeView) {
        _orangeView = [[UIView alloc] initWithFrame:CGRectZero];
        [_orangeView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_orangeView setBackgroundColor:[UIColor orangeColor]];
    }
    
    return _orangeView;
}

@end
