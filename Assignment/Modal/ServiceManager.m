//
//  ServiceManager.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "ServiceManager.h"
#import "Constants.h"

@implementation ServiceManager


-(void)getNetworkConnection:(void (^)(NSMutableArray * responseObj))completionBlock
{
    @try {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:API_BASE_URL]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                    NSString *strData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                    NSMutableArray * arrJson = [NSJSONSerialization JSONObjectWithData:[strData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];

                                    completionBlock(arrJson);
                                          
                                      }];
    [dataTask resume];
    
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception :%@",exception);
    }
    
    
}


-(void)getRowImge:(NSString *)strUrl withData:(void (^)(NSData *responseData))completionBlock   // for image loading
{
    
    @try {
        

        
        // set the image URL
        NSString *imageUrl = strUrl;
        
        NSURLSessionDownloadTask *downloadImageTask = [[NSURLSession sharedSession]
                                                       downloadTaskWithURL:[NSURL URLWithString:imageUrl] completionHandler:^(NSURL *strDownloadImageURL, NSURLResponse *response, NSError *error) {

                                                           completionBlock([NSData dataWithContentsOfURL:strDownloadImageURL]);
                                                       }];
        
        [downloadImageTask resume];

        
        
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception :%@",exception);
    }
    
    
    
   
    
    
    
}


@end
