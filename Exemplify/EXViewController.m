//
//  EXViewController.m
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXViewController.h"

@interface EXViewController ()

@end

@implementation EXViewController

EXArticleSuggestions *child;
NSString *searchText = @"";
EXControl *control;

- (void)viewDidLoad
{
    self.searchField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"];

    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (!child)
        child = [self.storyboard instantiateViewControllerWithIdentifier:@"articleSuggestions"];

	// Do any additional setup after loading the view, typically from a nib.
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.searchField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"];
}
-(void) viewDidAppear:(BOOL)animated
{
	[self.searchField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.searchField.text  isEqual: @""]) return NO;
    
    searchText = self.searchField.text;
    
    if (searchText != [[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"]){
        child = [self.storyboard instantiateViewControllerWithIdentifier:@"articleSuggestions"];
        child.segmentButton.selectedSegmentIndex = 1;
        child.unmarkedButton.selected = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:searchText forKey:@"searchText"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        control = [[EXControl alloc] init];
        
        [control pullSources:searchText];
    }
    [self.searchField resignFirstResponder];
    
    double delayInSeconds = .25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            child.control = control;
            [[self navigationController] pushViewController:child animated:YES];
    });
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
