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


/**
 Calling this Service Method for getting service data
 @returns JSON data
 */

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



/**
Calling this Service Method for getting image data
@param image URL
@returns image data
*/

-(void)getRowImge:(NSString *)strUrl withData:(void (^)(NSData *responseData))completionBlock   // for image loading
{
    
    @try {
        

        
        // set the image URL
        NSString *imageUrl = strUrl;
        
        NSURLSessionDownloadTask *downloadImageTask = [[NSURLSession sharedSession]
                                                       downloadTaskWithURL:[NSURL URLWithString:imageUrl] completionHandler:^(NSURL *strDownloadImageURL, NSURLResponse *response, NSError *error) {

                                                           NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];

                                                           NSData *imgData;
                                                           imgData=nil;

                                                           if (statusCode == 200)   // OK - response for successful HTTP requests
                                                           {
                                                               if (error == nil)
                                                               {
                                                                   imgData =[NSData dataWithContentsOfURL:strDownloadImageURL];
                                                               }

                                                           }
                                                           else
                                                           {
                                                               // Bad Response
                                                               // NSLog(@"Error :%@",error);
                                                           }
                                                           
                                                           
                                                           completionBlock(imgData);

                                                       }];
        
        [downloadImageTask resume];

        
        
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception :%@",exception);
    }
    
    
    
   
    
    
    
}


@end
