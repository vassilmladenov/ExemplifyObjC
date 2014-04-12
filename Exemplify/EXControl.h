//
//  EXControl.h
//  Exemplify
//
//  Created by Vassil Mladenov on 4/12/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXControl : NSObject

/**
 * Gets the references from the Wikipedia page
 * @param  {NSString       *} query What you would type in Wikipedia search
 * @return {NSMutableArray *}       Array of URLs of the references for
 *                                  the article
 */
- (NSMutableArray *)pullSources:(NSString *)query;

/**
 * Builds out the private member articles
 * @param  {NSMutableArray *} sources NSMutableArray of URLs
 */
- (void)makeArticles:(NSMutableArray *)sources;

/**
 * Returns the list of EXArticle objects for the controller to use
 * @return {NSMutableArray *} articles private member
 */
- (NSMutableArray *)getArticles;

@end
