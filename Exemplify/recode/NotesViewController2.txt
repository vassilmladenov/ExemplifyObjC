//
//  NotesViewController.m
//  Scanner
//
//  Created by David Prorok on 1/3/14.
//  Copyright (c) 2014 NADCA. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController
@synthesize notesView;

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
    NSString *currentNote = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentMessage"];
    if(currentNote.length>0)
        currentNote = [currentNote stringByAppendingString:@"\n"];
    self.notesView.text = currentNote;
    self.notesView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.notesView.autoresizesSubviews = YES;
    [self.notesView becomeFirstResponder];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotificationMethod:) name:UIKeyboardDidShowNotification object:nil];
    
	// Do any additional setup after loading the view.
}

- (void)myNotificationMethod:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    CGRect frame = self.notesView.frame;
    frame.size.height =self.view.frame.size.height-self.notesView.frame.origin.y-1-keyboardFrameBeginRect.size.height;
    self.notesView.frame = frame;
    [self.view addSubview: self.notesView];
}  



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    
    NSString *note = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"MMMM dd, hh:mm a";
    NSDate *date = [NSDate date];
    // if(([self.notesView.text rangeOfString:@"AM"].location == NSNotFound
    //  && [self.notesView.text rangeOfString:@"PM"].location == NSNotFound)
    //  || [self.notesView.text rangeOfString:@":"].location == NSNotFound
    //  || [self.notesView.text rangeOfString:@","].location == NSNotFound)
    //{
        note = [note stringByAppendingString:[dateFormatter stringFromDate:date]];
        note = [note stringByAppendingString:@"<br>"];
    //}
    note = [note stringByAppendingString:self.notesView.text];
    NSMutableArray *notes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"notes"]];
    [notes addObject: note];
    [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"notes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:^
    {
        NSString *messageString = @"Note added";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageString
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentMessage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)cancel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentMessage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:^
    {
        NSString *messageString = @"Note cancelled";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messageString
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.parentViewController viewDidAppear:animated];
}
@end
