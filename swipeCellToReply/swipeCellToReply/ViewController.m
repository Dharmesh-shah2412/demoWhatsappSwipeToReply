//
//  ViewController.m
//  swipeCellToReply
//
//  Created by dharmesh  on 2/16/18.
//  Copyright © 2018 com.zaptechsolutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tblView.delegate = self;
    _tblView.dataSource = self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureCellAction:)];
    pan.delegate = self;
    [cell.contentView addGestureRecognizer:pan];
    return cell;
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:_tblView];
    if (velocity.x < 0) {
        return false;
    }
    return fabs(velocity.x) > fabs(velocity.y);
}
- (IBAction)panGestureCellAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    if (recognizer.view.frame.origin.x < 0) { return; }
    recognizer.view.center = CGPointMake(recognizer.view.center.x+ translation.x,
                                         recognizer.view.center.y );
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if(recognizer.view.frame.origin.x > [UIScreen mainScreen].bounds.size.width * 0.9)
    {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [recognizer.view setFrame: CGRectMake(0, recognizer.view.frame.origin.y, recognizer.view.frame.size.width, recognizer.view.frame.size.height)];
        } completion:nil];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        int x = recognizer.view.frame.origin.x;
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [recognizer.view setFrame: CGRectMake(0, recognizer.view.frame.origin.y, recognizer.view.frame.size.width, recognizer.view.frame.size.height)];
        } completion:^(BOOL finished) {
            if (x > recognizer.view.frame.size.width / 2) {
                [_txtField becomeFirstResponder];
            }
        }];
    }
}
@end
