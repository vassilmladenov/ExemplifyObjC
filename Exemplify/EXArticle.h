//
//  EXArticle.h
//  Exemplify
//
//  Created by David Prorok on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXArticle : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSURL *URL;

@property (nonatomic) BOOL citing;

/**
 * Builds out EXArticle object:
 * Gets article title, article body
 * @param {NSURL *} url URL of article
 */
- (void)fetchArticle:(NSURL *)url withTitle:(NSString *)title;

/**
 * Gets MLA format citation for the article
 * Builds out citation instance variable
 * @return {NSString *} citation
 */
- (NSString *)citeArticle;

@end
