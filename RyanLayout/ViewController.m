//
//  ViewController.m
//  RyanLayout
//
//  Created by Ryan Poolos on 11/14/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//


/*
 
 Basic Layout in Code
 
 Basic Layout in Visual Format
 
 Animating Layout Changes Manually
  - Animating Changed Constants
  - Aniamting New Constraints
 
 Intrinsic Content Size for custom views
  - Setting the frame is BAD, but having a view that needs certain sizes isn't.
 
 Random complicated problems because
  - Thats my view! aka, the what if someone turns on AutoLayout and I didn't want them to? Hint: you can request it too.
  - Intrinsic Content Size based on Frame... its not impossible. Hint: Apple breaks rules too.
  - A grid with fixed item sizes ala UICollectionViewFlowLayout. Hint: not easy.
  - UILayoutSupport Protocol
 
 What have I learned over my month of AutoLayout boot camp?
  - Its not always easy, it can be hard to come up with rules that last and play nice.
  - Its also not always as long winded as it seemed at first. Things can be simple.
  - Its not always easy, sometimes you can't help but dive back into the depths of 7 
        line single constraints. Visual Format just isn't the whole package.
  - It CAN be done.
  - Sometimes it shouldn't be done. AutoLayout for now, isn't the end all.
        There are times you may still need to break out some good old frames and YouLayout™.
        AutoLayout is designed for everyone, by the law of cool, you've got to add the umph,
        and that means doing your own linear equations for custom layouts.
 
 */

#import "ViewController.h"

@interface ViewController ()
{
    // AnimatingChangedConstants
    NSLayoutConstraint *orangeTopPaddingConstraint;
    NSLayoutConstraint *orangeLeftPaddingConstraint;
    NSLayoutConstraint *greenRightPaddingConstraint;
    
    // AnimatingNewConstraints
    NSArray *landscapeConstraints;
    NSArray *portraitConstraints;
}

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *orangeView;

@property (nonatomic, strong) NSDictionary *metricsDict;
@property (nonatomic, strong) NSDictionary *viewsDict;

@end

#define BasicInCode (0)
#define BasicVisualFormat (1)
#define AnimatingChangedConstants (2)
#define AnimatingNewConstraints (3)

#define Layout BasicInCode

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.orangeView];
    
    if (Layout == BasicInCode) {
        [self basicCodeLayout];
    }
    else if (Layout == BasicVisualFormat) {
        [self basicVisualFormatLayout];
    }
    else if (Layout == AnimatingChangedConstants) {
        [self animatingChangedConstants];
    }
    else if (Layout == AnimatingNewConstraints) {
        [self animatingNewConstraints];
    }

}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (Layout == BasicInCode) {
        // Nothing to update, AutoLayout has our back (bout time)
    }
    else if (Layout == BasicVisualFormat) {
        // Nothing again, this AutoLayout thing is almost fun! (almost)
    }
    else if (Layout == AnimatingChangedConstants) {
        [self updateAnimatingChangedConstants:toInterfaceOrientation duration:duration];
    }
    else if (Layout == AnimatingNewConstraints) {
        [self updateAnimatingNewConstraints:toInterfaceOrientation duration:duration];
    }
}

#pragma mark - Layouts

- (void)basicCodeLayout
{
    // Equal blue and green heights
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Equal blue and green widths
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // 20 points of fixed padding between left blue edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView.superview
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // 20 points of fixed padding between right green edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.greenView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView.superview
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-20.0]];

    // 20 points of fixed padding between right blue edge and left green edge
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    // 20 points of fixed padding between top blue edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView.superview
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // 20 points of fixed padding between top green edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.greenView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView.superview
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // Equal orange and blue heights
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // 20 points of fixed padding between top orange edge and blue bottom edge
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // 20 points of fixed padding between left orange edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.orangeView.superview
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // 20 points of fixed padding between right orange edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.orangeView.superview
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    // 20 points of fixed padding between bottom orange edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.orangeView.superview
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    

}

- (void)basicVisualFormatLayout
{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[blue(==green)]-(padding)-[green(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[orange]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[blue(==orange)]-(padding)-[orange(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[green(==orange)]-(padding)-[orange(==green)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    // Note that the last line above is a bit redundant by stating top and bottom padding again when all we need at this point is green's height linked to blue in reality.
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[green(==blue)]" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    // And just to confuse the mess out of you, here is another that works.
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[green(==orange)]-(padding)-[orange(==green)]" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    
    // These additional possibilities bring up a key point. AutoLayout is based on fluid rules from your magical imagination.
    // You create rules to satisfy your requirements. However those are thought of by you.
    // I chose the first because it made sense to me to map blue to orange and green to orange with appropriate padding.
    // You could easily choose the second to just map green to blue if you wanted.
}

- (void)animatingChangedConstants
{
    // Equal blue and green heights
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // Equal blue and green widths
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // 20 points of fixed padding between left blue edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView.superview
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // animted padding between right green edge and its superview
    greenRightPaddingConstraint = [NSLayoutConstraint constraintWithItem:self.greenView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.greenView.superview
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:-20.0];
    [self.view addConstraint:greenRightPaddingConstraint];
    
    // 20 points of fixed padding between right blue edge and left green edge
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    // 20 points of fixed padding between top blue edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.blueView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView.superview
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // 20 points of fixed padding between top green edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.greenView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.greenView.superview
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:20.0]];
    
    // Equal orange and blue heights
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.blueView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // animated padding between top orange edge and its superview
    orangeTopPaddingConstraint = [NSLayoutConstraint constraintWithItem:self.orangeView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.orangeView.superview
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:20.0];
    [self.view addConstraint:orangeTopPaddingConstraint];
    
    // animated padding between left orange edge and its superview
    orangeLeftPaddingConstraint = [NSLayoutConstraint constraintWithItem:self.orangeView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.orangeView.superview
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:20.0];
    [self.view addConstraint:orangeLeftPaddingConstraint];
    
    // 20 points of fixed padding between right orange edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.orangeView.superview
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-20.0]];
    
    // 20 points of fixed padding between bottom orange edge and its superview
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.orangeView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.orangeView.superview
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20.0]];
}

- (void)updateAnimatingChangedConstants:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // Its not perfect but its not our math, its the screen!
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [greenRightPaddingConstraint setConstant:-294.0]; // Magic numbers OMG
        [orangeLeftPaddingConstraint setConstant:294.0]; // Magic numbers OMG
        [orangeTopPaddingConstraint setConstant:20.0];
    }
    else {
        [greenRightPaddingConstraint setConstant:-20.0];
        [orangeLeftPaddingConstraint setConstant:20.0];
        [orangeTopPaddingConstraint setConstant:294.0]; // Magic numbers OMG
    }
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)animatingNewConstraints
{
    NSMutableArray *portrait = [NSMutableArray array];

    [portrait addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[blue(==green)]-(padding)-[green(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [portrait addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[orange]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    [portrait addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[blue(==orange)]-(padding)-[orange(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [portrait addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[green(==orange)]-(padding)-[orange(==green)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    portraitConstraints = portrait.copy;
    
    
    NSMutableArray *landscape = [NSMutableArray array];
    
    [landscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(padding)-[blue(==green)]-(padding)-[orange(==280)]-(padding)-[green(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    [landscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[blue(==green)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [landscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[orange(==blue)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    [landscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[green(==orange)]-(padding)-|" options:0 metrics:self.metricsDict views:self.viewsDict]];
    
    landscapeConstraints = landscape.copy;
    

    [self.view addConstraints:portraitConstraints];
}

- (void)updateAnimatingNewConstraints:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.view removeConstraints:portraitConstraints];
        [self.view addConstraints:landscapeConstraints];
    } else {
        [self.view removeConstraints:landscapeConstraints];
        [self.view addConstraints:portraitConstraints];
    }
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
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

#pragma mark - Properties

- (NSDictionary *)metricsDict
{
    if (!_metricsDict) {
        return @{@"padding": @20.0};
    }
    
    return _metricsDict;
}

- (NSDictionary *)viewsDict
{
    if (!_viewsDict) {
        _viewsDict = @{@"blue": self.blueView,
                       @"green": self.greenView,
                       @"orange": self.orangeView};
    }
    
    return _viewsDict;
}

@end
