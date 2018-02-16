//
//  ViewController.h
//  swipeCellToReply
//
//  Created by dharmesh  on 2/16/18.
//  Copyright © 2018 com.zaptechsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)panGestureCellAction:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtField;

@end

