//
//  EXViewController.m
//  Exemplify
//
//  Created by Vassil Mladenov on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXViewController.h"

@interface EXViewController ()

@end

@implementation EXViewController
NSString *searchText = @"";
EXControl *control;

- (void)viewDidLoad
{
    
    self.searchField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"];
    [super viewDidLoad];
    

	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
	[self.searchField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.searchField.text  isEqual: @""]) return NO;
    
    searchText = self.searchField.text;
    
    if (searchText != [[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"]){
        
        [[NSUserDefaults standardUserDefaults] setObject:searchText forKey:@"searchText"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        control = [[EXControl alloc] init];
        
        [control pullSources:searchText];
    }
    [self.searchField resignFirstResponder];
    
    double delayInSeconds = .25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self performSegueWithIdentifier:@"DisplayArticleSuggestions" sender:self];
    });

	return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    EXArticleSuggestions *tableView = segue.destinationViewController;
    tableView.control = control;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
