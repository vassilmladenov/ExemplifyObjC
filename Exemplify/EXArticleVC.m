//
//  EXArticleVC.m
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXArticleVC.h"

@interface EXArticleVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

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
	[self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.article.URL]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)discard:(id)sender {
    //move article from main array to discard array
    self.article.kept = NO;
    self.article.processed = YES;
    
    //return to articles VC
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)keep:(id)sender {
    //move article from main array to keep array
    self.article.kept = YES;
    self.article.processed = YES;
    
    //return to articles VC
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * Doesn't properly get main article
 */

//@synthesize hiddenWebView = _hiddenWebView;
//
//- (void)viewWillLayoutSubviews
//{
//	[super viewWillLayoutSubviews];
//	
//	if (!self.hiddenWebView.superview)
//	{
//		[self.view addSubview:self.hiddenWebView];
//	}
//}
//
//- (UIWebView *)hiddenWebView
//{
//	if (!_hiddenWebView) {
//		_hiddenWebView = [UIWebView.alloc initWithFrame:CGRectZero];
//		_hiddenWebView.delegate = self;
//		NSURLRequest *req = [[NSURLRequest alloc] initWithURL:self.article.URL];
//		[_hiddenWebView loadRequest:req];
//
//	}
//	return _hiddenWebView;
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//	NSString *documentBodyString = [self.hiddenWebView stringByEvaluatingJavaScriptFromString: @"document.documentElement.innerText"];
//
//	NSLog(@"%@", documentBodyString);
//}


@end
