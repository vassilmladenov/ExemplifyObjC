//
//  EXArticleSuggestions.m
//  Exemplify
//
//  Created by Vassil Mladenov on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXArticleSuggestions.h"

@interface EXArticleSuggestions ()

@end

@implementation EXArticleSuggestions

int whichArray = 1;

NSMutableArray *articles;
NSMutableArray *unmarkedArticles;
NSMutableArray *keptArticles;
NSMutableArray *discardedArticles;


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

    articles = [self.control getArticles];
    unmarkedArticles = [[NSMutableArray alloc]initWithArray:articles];
    keptArticles = [[NSMutableArray alloc]init];
    discardedArticles = [[NSMutableArray alloc]init];
    
    self.unmarkedButton.selected = YES;
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissController)];
    
    self.navigationItem.leftBarButtonItem = customBarItem;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (whichArray == 0)
        return [discardedArticles count];
    else if (whichArray == 1)
        return [unmarkedArticles count];
    else if (whichArray == 2)
        return [keptArticles count];
    
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article" forIndexPath:indexPath];
    
    if (whichArray == 0)
        cell.textLabel.text = ((EXArticle*)discardedArticles[indexPath.row]).title;
    else if (whichArray == 1)
    cell.textLabel.text = ((EXArticle*)unmarkedArticles[indexPath.row]).title;
    else if (whichArray == 2)
        cell.textLabel.text = ((EXArticle*)keptArticles[indexPath.row]).title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"DisplayArticle" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    EXArticleVC *articleView = segue.destinationViewController;
    if (whichArray == 0)
        articleView.article = [discardedArticles objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    else if (whichArray == 1)
    articleView.article = [unmarkedArticles objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    else if (whichArray == 2)
        articleView.article = [keptArticles objectAtIndex:[self.tableView indexPathForSelectedRow].row];
}

-(void) viewWillAppear:(BOOL)animated{
    for (int i = 0; i< [articles count]; i++)
    {
        EXArticle *a = articles[i];
        if (a.processed){
            if (a.kept){
                [discardedArticles removeObject:a];
                [unmarkedArticles removeObject:a];
                [keptArticles removeObject:a];
                [keptArticles addObject:a];
            }
            else{
                [discardedArticles removeObject:a];
                [keptArticles removeObject:a];
                [unmarkedArticles removeObject:a];
                [discardedArticles addObject:a];
            }
        }
    }
    whichArray = self.segmentButton.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (IBAction)finishPressed:(id)sender
{	
	if ([keptArticles count] > 0){
        NSMutableString *mailBody = [[NSMutableString alloc] init];
        
		NSMutableString *x = [[NSMutableString alloc] init];
        for (EXArticle *a in keptArticles) {
			[x appendString:[a citeArticle]];
			[x appendString:@"\n\n"];
		}
        [mailBody appendString: @"Article titles and links to citations:<br><br>"];
		
		
        if([x length] > 0)
			[mailBody appendString: x];
		
		[mailBody appendString:@"Sources compiled using Exemplify"];
        
        mailBody = (NSMutableString*)[mailBody stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        NSMutableString *emailTitle = [[NSMutableString alloc] initWithString:@"References about "];
		[emailTitle appendString:[[NSUserDefaults standardUserDefaults] objectForKey:@"searchText"]];
		
        
        NSString *messageBody = mailBody;
        
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
	}
	else
	{
		NSString *titleString = @"No Articles";
		NSString *messageString = @"Please select at least one article.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleString
														message:messageString
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil, nil];
		[alert show];
	}
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *messageAlert;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Cancelled" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        case MFMailComposeResultSaved:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Saved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        case MFMailComposeResultSent:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Sent" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [articles removeAllObjects];
			[keptArticles removeAllObjects];
			[discardedArticles removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"searchText"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSelector:@selector(dismissController) withObject:nil afterDelay:.5];
            
            break;
        case MFMailComposeResultFailed:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail sent failure:" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void) dismissController {
    [[self navigationController] popViewControllerAnimated:YES];
}


-(void)showMessage:(UIAlertView *)messageAlert
{
    [messageAlert show];
}

- (IBAction)segmentedControlPressed:(id)sender {
    if (self.segmentButton.selectedSegmentIndex == 0) {
		[self discardedButtonPressed:sender];
    }
    if (self.segmentButton.selectedSegmentIndex == 1) {
		[self unmarkedButtonPressed:sender];
    }
    if (self.segmentButton.selectedSegmentIndex == 2) {
		[self keptButtonPressed:sender];
    }
}

- (IBAction)discardedButtonPressed:(id)sender {
    whichArray = 0;

    [self.tableView reloadData];
}

- (IBAction)unmarkedButtonPressed:(id)sender {
    whichArray = 1;

    [self.tableView reloadData];
}

- (IBAction)keptButtonPressed:(id)sender {
    whichArray = 2;

    [self.tableView reloadData];
}

@end
