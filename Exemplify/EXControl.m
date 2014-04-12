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

- (NSMutableArray *)pullSources:(NSString *)query;
{
	NSMutableArray *sources = [[NSMutableArray alloc] init];
	
	NSURL *wikiURL = [[NSURL alloc] initWithScheme:@"http" host:@"en.wikipedia.org" path:[@"/wiki/" stringByAppendingString:query]];
	// get block of URLs
	NSError *error = Nil;
	NSString *a = [NSString stringWithContentsOfURL:wikiURL encoding:NSUTF8StringEncoding error:&error];
	// for every URL in the list
	
	// add to array

	return sources;
}

- (void)makeArticles:(NSMutableArray *)sources
{
	// for every URL in sources
	for (NSURL *url in sources) {
		// create an EXArticle
		EXArticle *a = [[EXArticle alloc] init];
		// fetch the article's data
		[a fetchArticle:url];
		// add it to articles
		[self.articles addObject:a];
	}

	

}

- (NSMutableArray *)getArticles
{
	return self.articles;
}

@end
