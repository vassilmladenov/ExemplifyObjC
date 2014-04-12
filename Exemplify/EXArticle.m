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
+ (NSString *)getBody:(NSURL *)url;

@end

@implementation EXArticle

- (void)fetchArticle:(NSURL *)url withTitle:(NSString *)title
{
	NSString *body = [EXArticle getBody:url];
    
	// set article title
	self.articleTitle = title;
    
	// set article body
	self.articleBody = body;
    
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

+ (NSString *)getBody:(NSURL *)url;
{
    NSString *content = @"";
	// code to set content
	
	return content;
}

@end
