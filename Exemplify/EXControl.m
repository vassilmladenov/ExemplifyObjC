//
//  EXControl.m
//  Exemplify
//
//  Created by Vassil Mladenov on 4/12/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import "EXControl.h"
#import "TFHpple.h"

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
	NSData *wikiData = [NSData dataWithContentsOfURL:wikiURL];
	NSError *error = Nil;
	NSString *a = [NSString stringWithContentsOfURL:wikiURL encoding:NSUTF8StringEncoding error:&error];
	
	NSString *startString = @"<ol class=\"references\">";
	NSString *endString = @"<h2><span class=\"mw-headline\" id=\"External_links\">External links</span></h2>";
	
	NSRange r1 = [a rangeOfString:startString];
	NSRange r2 = [a rangeOfString:endString];
	NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
	NSString *b = [a substringWithRange:rSub];
    
    NSMutableArray *refs = [[NSMutableArray alloc]initWithArray:[b componentsSeparatedByString:@"</li>"]];
    
    for (int i = 0; i< [refs count]; i++){
        NSString *startString = @"<li>";
        //NSString *endString = @"<h2><span class=\"mw-headline\" id=\"External_links\">External links</span></h2>";

        NSRange start = [refs[i] rangeOfString:startString];
        if (start.location != NSNotFound)
        {
            NSString *b2 = [refs[i] substringFromIndex:start.location + start.length];
            NSLog(@"%@",b2);
            refs[i] = [[NSString alloc] initWithString:b2];
        }

        
    }
	// for every URL in the list
	//NSLog(@"%@",refs);
	// add to array

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
