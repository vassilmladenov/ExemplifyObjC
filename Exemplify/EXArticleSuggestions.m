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


NSMutableArray *articles;
NSMutableArray *keptArticles;
NSMutableArray *discardedArticles;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    articles = [self.control getArticles];
    keptArticles = [[NSMutableArray alloc]init];
    discardedArticles = [[NSMutableArray alloc]init];
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
    return [articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article" forIndexPath:indexPath];
    
    cell.textLabel.text = ((EXArticle*)articles[indexPath.row]).title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"DisplayArticle" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    EXArticleVC *articleView = segue.destinationViewController;
    articleView.article = [articles objectAtIndex:[self.tableView indexPathForSelectedRow].row];
}

-(void) viewDidAppear:(BOOL)animated{
    for (int i = 0; i< [articles count]; i++)
    {
        EXArticle *a = articles[i];
        if (a.processed){
            if (a.kept){
                [articles removeObject:a];
                [keptArticles addObject:a];
            }
            else{
                [articles removeObject:a];
                [discardedArticles addObject:a];
            }
        }
    }
    
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
        [mailBody appendString: @"Article List:<br><br>"];
		
		
        if([x length] > 0)
			[mailBody appendString: x];
        
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
    [self performSelector:@selector(showMessage:) withObject:messageAlert afterDelay:0.4];
    
    
}

-(void)showMessage:(UIAlertView *)messageAlert
{
    [messageAlert show];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
