//
//  Content.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "Content.h"
#import "InfoObject.h"
#import "AFHTTPRequestOperationManager.h"
#define API_BASE_URL @"https://dl.dropboxusercontent.com/u/746330/facts.json"


#define rows           @"rows"
#define FileTitle      @"title"
#define title          @"title"
#define description    @"description"
#define image          @"imageHref"


@interface Content()
{
    
      AFHTTPRequestOperationManager *manager;
}

@property(nonatomic,strong) NSMutableArray *arrInfoObj;

@end


@implementation Content


-(void)getConnection:(void (^)(NSMutableArray * responseObj))completionBlock
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
   
    NSString *urlString=[NSString stringWithFormat:API_BASE_URL];
    
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        InfoObject *infObj;
        
        _strTitle =[responseObject valueForKey:FileTitle];
        for (NSDictionary *dictRow in [responseObject valueForKey:rows])
        {
            infObj=[[InfoObject alloc] init];
            infObj.strTitle= ([dictRow valueForKey:title] == [NSNull null])?@"":[dictRow valueForKey:title];
            infObj.strDescription=([dictRow valueForKey:description] == [NSNull null])?@"":[dictRow valueForKey:description];
            infObj.urlImage=[dictRow valueForKey:image];
            [_arrInfoObj addObject:infObj];
            
        }
        
        
        completionBlock(_arrInfoObj);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    [requestOperation start];
    
}


-(void)getImge:(NSString *)strUrl withData:(void (^)(id responseData))completionBlock   // for image loading
{
    
    @try {
        
        manager = [AFHTTPRequestOperationManager manager];
        
        NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"GET" URLString:strUrl parameters:nil error:nil];
        
        
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //        NSLog(@"Response: %@", responseObject);
            
            
            completionBlock(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
        }];
        [requestOperation start];
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception :%@",exception);
    }
    
    
    
   
    
    
    
}


@end
