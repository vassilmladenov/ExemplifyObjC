//
//  EXArticleVC.m
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXArticleVC.h"

@interface EXArticleVC ()

@end

@implementation EXArticleVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.article.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)discard:(id)sender {
    //move article from main array to discard array
    [((EXArticleSuggestions *)self.navigationController.parentViewController).control discardArticle:self.article];
    
    //return to articles VC
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)keep:(id)sender {
    //move article from main array to keep array
    [((EXArticleSuggestions *)self.navigationController.parentViewController).control keepArticle:self.article];
    
    //return to articles VC
    [self.navigationController popViewControllerAnimated:YES];
}

@end
