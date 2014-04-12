//
//  MainViewController.h
//  Scanner
//
//  Created by David Prorok on 12/26/13.
//  Copyright (c) 2013 NADCA. All rights reserved.
//

#import "FlipsideViewController.h"
#import "NotesViewController.h"
#import <MessageUI/MessageUI.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, MFMailComposeViewControllerDelegate, PPBarcodeDelegate, UIAlertViewDelegate>


- (IBAction)send:(id)sender;
- (IBAction)scan:(id)sender;
- (IBAction)help:(id)sender;
- (IBAction)currentNotes:(id)sender;
- (IBAction)holdHelp:(id)sender;
- (IBAction)holdSend:(id)sender;
- (IBAction)holdCurrentNotes:(id)sender;
- (IBAction)holdScan:(id)sender;
- (IBAction)stopHoldScan:(id)sender;
- (IBAction)stopHoldCurrentNotes:(id)sender;
- (IBAction)stopHoldSend:(id)sender;
- (IBAction)stopHoldHelp:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;

@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIImageView *graybar;
@property (weak, nonatomic) IBOutlet UIImageView *ironbar;
@property (weak, nonatomic) IBOutlet UIImageView *bronzebar;
@property (weak, nonatomic) IBOutlet UIImageView *goldbar;

@end
