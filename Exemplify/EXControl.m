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

@end

@implementation EXControl

- (NSMutableDictionary *)pullSources:(NSString *)query;
{
	NSMutableDictionary *sources = [[NSMutableDictionary alloc] init];
	
	NSURL *wikiURL = [[NSURL alloc] initWithScheme:@"http" host:@"en.wikipedia.org" path:[@"/wiki/" stringByAppendingString:query]];
	
//	NSError *getSourceError = Nil;
//	NSString *htmlSource = [NSString stringWithContentsOfURL:wikiURL encoding:NSUTF8StringEncoding error:&getSourceError];
//	
//	if (getSourceError) {
//		NSLog(@"Error getting source: %@", getSourceError);
//		return Nil;
//	}
	
	NSError *parserError = Nil;
	HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:wikiURL error:&parserError];
	
	if (parserError) {
		NSLog(@"Error getting source: %@", parserError);
		return Nil;
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
		NSString *title = [quotedTitle substringWithRange:NSMakeRange(1, [quotedTitle length] - 2)];
		
		[URLs addObject:url];
		[titles addObject:title];
		
//		NSLog(@"\n%@", url);
//		NSLog(@"\n%@", title);
	}
	
	return sources;
}

- (void)makeArticles:(NSMutableDictionary *)sources
{
	// for every element in sources
    [sources enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        // create an EXArticle
		EXArticle *a = [[EXArticle alloc] init];
        
		// fetch the article's data
		[a fetchArticle:key withTitle:obj];
        
		// add it to articles
		[self.articles addObject:a];
        
    }];

	

}

- (NSMutableArray *)getArticles
{
	return self.articles;
}

@end
