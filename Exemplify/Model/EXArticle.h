//
//  EXArticle.h
//  Exemplify
//
//  Created by Vassil Mladenov on 4/11/14.
//  Copyright (c) 2014 Confluence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXArticle : NSObject

@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) NSString *articleBody;
@property (strong, nonatomic) NSURL *articleURL;

@property (nonatomic) BOOL citing; // will/won't use article
@property (strong, nonatomic) NSString *citation;

@end
