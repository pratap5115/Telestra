//
//  InfoObject.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "InfoObject.h"
#import "ServiceManager.h"
#import "Constants.h"

@interface InfoObject()

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
    
    ServiceManager *objService=[[ServiceManager alloc] init];
    [objService getNetworkConnection:^(NSMutableArray *responseObject)
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

- (void)fetchImage:(NSString *)strUrl withData:(void (^)(NSData *responseData))completionBlock
{
     ServiceManager *objService=[[ServiceManager alloc] init];
    [objService getRowImge:strUrl withData:^(NSData *responseData) {
         completionBlock(responseData);
        
    }];
    

    
}
@end
