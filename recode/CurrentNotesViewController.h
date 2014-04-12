//
//  CurrentNotesViewController.h
//  Scanner
//
//  Created by David Prorok on 1/7/14.
//  Copyright (c) 2014 NADCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentNotesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)Done:(id)sender;
- (IBAction)addNote:(id)sender;


@end
