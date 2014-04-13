//
//  EXArticleSuggestions.h
//  Exemplify
//
//  Created by Vassil Mladenov on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "EXControl.h"
#import "EXArticle.h"
#import "EXArticleVC.h"

@interface EXArticleSuggestions : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property EXControl *control;
- (IBAction)finishPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentButton;
@property (weak, nonatomic) IBOutlet UIButton *discardButton;
@property (weak, nonatomic) IBOutlet UIButton *unmarkedButton;
@property (weak, nonatomic) IBOutlet UIButton *keptButton;

- (IBAction)discardedButtonPressed:(id)sender;
- (IBAction)unmarkedButtonPressed:(id)sender;
- (IBAction)keptButtonPressed:(id)sender;
- (IBAction)segmentedControlPressed:(id)sender;

@end

