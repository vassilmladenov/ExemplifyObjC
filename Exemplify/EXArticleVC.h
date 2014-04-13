//
//  EXArticleVC.h
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXArticle.h"
#import "EXArticleSuggestions.h"


@interface EXArticleVC : UIViewController

@property EXArticle *article;

- (IBAction)discard:(id)sender;
- (IBAction)keep:(id)sender;

@end
