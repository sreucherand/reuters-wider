//
//  CSBlockContentModel.h
//  reuters-wider
//
//  Created by REUCHERAND Sylvain on 26/11/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.
//

#import "JSONModel.h"

@protocol CSBlockContentModel
@end

@interface CSBlockContentModel : JSONModel

@property (assign, nonatomic) int data;
@property (assign, nonatomic) int part;
@property (assign, nonatomic) int duration;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *teasing;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *context;
@property (strong, nonatomic) NSString *person;
@property (strong, nonatomic) NSString *alignment;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *video;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSArray<CSBlockContentModel> *views;
@property (strong, nonatomic) NSArray<CSBlockContentModel> *transitions;
@property (strong, nonatomic) NSArray<CSBlockContentModel> *keywords;

- (NSDate *)formattedDate;

@end
