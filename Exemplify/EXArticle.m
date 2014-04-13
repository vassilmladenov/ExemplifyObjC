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
	self.title = title;
    
	// set article body
	self.body = body;
    
	// set article URL
	self.URL = url;
}

- (NSString *)citeArticle
{
	NSMutableString *citation= [[NSMutableString alloc]init];

	// send article URL to easybib
    [citation appendString:self.title];
	[citation appendString:@"\n" ];
    [citation appendString:[self.URL absoluteString]];
    [citation appendString:@"\n" ];
    [citation appendString:@"Citation: http://www.easybib.com/cite/eval?url=" ];
    [citation appendString:[self.URL absoluteString]];

	return citation;
}

+ (NSString *)getBody:(NSURL *)url;
{
    NSString *content = @"";
	// code to set content
	
	return content;
}

@end
