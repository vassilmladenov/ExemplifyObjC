//
//  FlipsideViewController.h
//  Scanner
//
//  Created by David Prorok on 12/26/13.
//  Copyright (c) 2013 NADCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pdf417/PPBarcode.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
@property ( nonatomic, retain) IBOutlet UITextView *textView;
- (IBAction)submit:(id)sender;
-(void)setText:(NSString *)text;

@end
