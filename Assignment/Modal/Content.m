//
//  Content.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "Content.h"
#import "AFHTTPRequestOperationManager.h"
#define API_BASE_URL @"https://dl.dropboxusercontent.com/u/746330/facts.json"


@interface Content()
{
    
      AFHTTPRequestOperationManager *manager;
}

@end


@implementation Content


-(void)getNetworkConnection:(void (^)(NSMutableArray * responseObj))completionBlock
{
    
   
    NSString *urlString=[NSString stringWithFormat:API_BASE_URL];
    
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error.localizedDescription);
    }];
    [requestOperation start];
    
}


-(void)getRowImge:(NSString *)strUrl withData:(void (^)(id responseData))completionBlock   // for image loading
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
