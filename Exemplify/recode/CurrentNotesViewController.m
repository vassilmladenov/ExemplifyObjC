//
//  CurrentNotesViewController.m
//  Scanner
//
//  Created by David Prorok on 1/7/14.
//  Copyright (c) 2014 NADCA. All rights reserved.
//

#import "CurrentNotesViewController.h"
#import "Cell.h"

@interface CurrentNotesViewController ()

@end

@implementation CurrentNotesViewController
NSMutableArray *notes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    
    notes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"notes"]];
    if (notes==NULL)
        notes = [[NSMutableArray alloc] init];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    notes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"notes"]];
    [self.tableView reloadData];
    [self.view reloadInputViews];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (int i = 0; i<notes.count;i++)
    {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        Cell *cell = (Cell*)[self.tableView cellForRowAtIndexPath:index];
        notes[i] = cell.dateLabel.text;
        notes[i] = [notes[i] stringByAppendingString:@"<br>"];
        notes[i] = [notes[i] stringByAppendingString:cell.noteLabel.text];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"notes"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell) {
        cell = [[Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *note = [notes objectAtIndex:indexPath.row];
    note = [note stringByReplacingOccurrencesOfString:@"<br>" withString:@"dateEnd"];
    
    @try {
    cell.dateLabel.text = [note substringToIndex:NSMaxRange([note rangeOfString:@"MdateEnd"])-7];
    cell.noteLabel.text = [note substringFromIndex:NSMaxRange([note rangeOfString:@"MdateEnd"])];
    }
    
    @catch (NSException *exception) {
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        @try{
        [notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"notes"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
        @catch (NSException *ex){}
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}





#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


- (IBAction)Done:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"notes"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNote:(id)sender {
    [self performSegueWithIdentifier:@"addNote" sender:self];
}

@end
