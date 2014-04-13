//
//  EXControl.m
//  Exemplify
//
//  Created by Vassil Mladenov on 4/12/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXControl.h"

@interface EXControl();

// stores the list of articles, contents of type EXArticle
@property NSMutableArray *articles;
@property NSMutableArray *keptArticles;
@property NSMutableArray *discardedArticles;

@end

@implementation EXControl

- (void)pullSources:(NSString *)query;
{
	
	NSURL *wikiURL = [[NSURL alloc] initWithScheme:@"http" host:@"en.wikipedia.org" path:[@"/wiki/" stringByAppendingString:query]];
	
	NSError *parserError = Nil;
	HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:wikiURL error:&parserError];
	
	// necessary error check
	if (parserError) {
		NSLog(@"Error getting source: %@", parserError);
		return;
	}
	
	// grabs the References tag from the Wikipedia HTML
	HTMLNode *referencesDiv = [[parser body] findChildWithAttribute:@"class" matchingName:@"reflist" allowPartial:YES];
	
	// makes an array of the references, which are <li> tags
	NSArray *refsArray = [referencesDiv findChildTags:@"li"];
	
	// temporary parallel arrays to hold the titles and URLs, will be placed in dictionary eventually
	NSMutableArray *URLs = [[NSMutableArray alloc] init];
	NSMutableArray *titles = [[NSMutableArray alloc] init];
	
	for (HTMLNode *ref in refsArray) {
		// get the actual link from the reference
		HTMLNode *a = [ref findChildWithAttribute:@"rel" matchingName:@"nofollow" allowPartial:YES];
		
		NSString *url = [a getAttributeNamed:@"href"]; // get the url
		NSString *quotedTitle = [a contents]; // get the title, has quotes at start and end
		// strips the quotes from around the title,
        if ([quotedTitle length] > 2) {
            NSString *title = [quotedTitle substringWithRange:NSMakeRange(1, [quotedTitle length] - 2)];
            if (url && title) {
                [URLs addObject:url];
                [titles addObject:title];
            }
        }
	}
	
	[self makeArticlesWithTitles:titles withURLs:URLs];
}

- (void)makeArticlesWithTitles:(NSMutableArray *)titles withURLs:(NSMutableArray *)URLs
{
    self.articles = [[NSMutableArray alloc] init];
    
	// for every element, create an article with paired title and url
    for (int i = 0; i < [titles count]; i++){
        
        // create an EXArticle
		EXArticle *a = [[EXArticle alloc] init];
        
		// fetch the article's data
		[a fetchArticle:URLs[i] withTitle:titles[i]];
        
		// add it to articles
		[self.articles addObject:a];
        
    }

}

- (NSMutableArray *)getArticles
{
	return self.articles;
}

-(void)keepArticle:(EXArticle *)article{
    [self.articles removeObject:article];
    [self.keptArticles addObject:article];
}

-(void)discardArticle:(EXArticle *)article{
    [self.articles removeObject:article];
    [self.discardedArticles addObject:article];
}

@end
