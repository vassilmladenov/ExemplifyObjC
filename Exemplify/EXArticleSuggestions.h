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

@interface EXArticleSuggestions : UITableViewController <MFMailComposeViewControllerDelegate>
@property EXControl *control;
- (IBAction)finishPressed:(id)sender;

@end
