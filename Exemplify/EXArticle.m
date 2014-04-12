//
//  EXArticle.m
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXArticle.h"

@interface EXArticle()

/**
 * Returns array that holds the article title and its body text
 * @param  {NSURL          *} url URL of article
 * @return {NSMutableArray *}     array of size 2
 */
+ (NSMutableArray *)getTitleAndBody:(NSURL *)url;

@end

@implementation EXArticle

- (void)fetchArticle:(NSURL *)url
{
	NSMutableArray *content = [EXArticle getTitleAndBody:url];
	// set article title
	self.articleTitle = content[0];
	// set article body
	self.articleBody = content[1];
	// set article URL
	self.articleURL = url;
}

- (NSString *)citeArticle
{
	NSString *citation;

	// send article URL to easybib
	
	// set MLA formatted citation  

	return citation;
}

+ (NSMutableArray *)getTitleAndBody:(NSURL *)url;
{
	NSMutableArray *content = [[NSMutableArray alloc] initWithCapacity:2];
	
	// code to set content
	
	return content;
}

@end
