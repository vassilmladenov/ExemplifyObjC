//
//  NotesViewController.h
//  Scanner
//
//  Created by David Prorok on 1/3/14.
//  Copyright (c) 2014 NADCA. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class NotesViewController;

//@protocol NotesViewControllerDelegate
//- (void)notesViewControllerDidFinish:(NotesViewController *)controller;
//@end


@interface NotesViewController : UIViewController

//@property (weak, nonatomic) id <NotesViewControllerDelegate> delegate;


- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *notesView;
- (IBAction)cancel:(id)sender;

@end
