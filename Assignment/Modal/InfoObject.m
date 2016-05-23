//
//  InfoObject.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "InfoObject.h"
#import "Content.h"

#define rows           @"rows"
#define FileTitle      @"title"
#define title          @"title"
#define description    @"description"
#define image          @"imageHref"

@interface InfoObject()
{

}

@property(nonatomic,strong) NSMutableArray *arrInfoObj;

@end



@implementation InfoObject

@synthesize strTitle;
@synthesize  strDescription;
@synthesize  urlImage;

-(void)fetchData:(void (^)(NSMutableArray * responseObj))completionBlock
{
    if (_arrInfoObj == nil || [_arrInfoObj count] == 0)
    {
        _arrInfoObj=[[NSMutableArray alloc] init];
    }
    else
    {
        [_arrInfoObj removeAllObjects];
        _arrInfoObj=nil;
    }
    
    Content *content=[[Content alloc] init];
    [content getNetworkConnection:^(NSMutableArray *responseObject)
     {
         
                 InfoObject *infObj;
         
                 _strHeadingTitle =[responseObject valueForKey:FileTitle];
                 for (NSDictionary *dictRow in [responseObject valueForKey:rows])
                 {
                     infObj=[[InfoObject alloc] init];
                     infObj.strTitle= ([dictRow valueForKey:title] == [NSNull null])?@"":[dictRow valueForKey:title];
                     infObj.strDescription=([dictRow valueForKey:description] == [NSNull null])?@"":[dictRow valueForKey:description];
                     infObj.urlImage=[dictRow valueForKey:image];
                     [_arrInfoObj addObject:infObj];
                     
                 }
                 completionBlock(_arrInfoObj);

         
         
     }];

    

}

- (void)fetchImage:(NSString *)strUrl withData:(void (^)(id responseData))completionBlock
{
     Content *content=[[Content alloc] init];
    [content getRowImge:strUrl withData:^(id responseData) {
        completionBlock(responseData);
    }];

    
}
@end
