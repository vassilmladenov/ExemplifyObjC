//
//  Cell.h
//  Scanner
//
//  Created by David Prorok on 1/7/14.
//  Copyright (c) 2014 NADCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteLabel;


@end
