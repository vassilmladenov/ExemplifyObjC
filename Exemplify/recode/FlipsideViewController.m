//
//  FlipsideViewController.m
//  Scanner
//
//  Created by David Prorok on 12/26/13.
//  Copyright (c) 2013 NADCA. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView = [[UITextView alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setText:(NSString *)text
{
    NSLog(@"hahah");
    self.textView.text = @"sdsaads";
    NSLog(@"Text View Value = %@",self.textView.text);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)cancel:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)submit:(id)sender {
    
    self.textView.text = @"blah";
    [self setText:@"blah"];
}
@end
