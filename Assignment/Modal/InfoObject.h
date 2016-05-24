//
//  InfoObject.h
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoObject : NSObject

@property(nonatomic,strong) NSString *strTitle;
@property(nonatomic,strong) NSString *strDescription;
@property(nonatomic,strong) NSString *urlImage;

@property(nonatomic,strong)NSString *strHeadingTitle;

-(void)fetchData:(void (^)(NSMutableArray * responseObj))completionBlock;
-(void)fetchImage:(NSString *)strUrl withData:(void (^)(NSData *responseData))completionBlock;


@end
