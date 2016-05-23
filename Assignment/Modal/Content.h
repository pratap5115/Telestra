//
//  Content.h
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Content : NSObject
{

}


-(void)getNetworkConnection:(void (^)(NSMutableArray * responseObj))completionBlock;
-(void)getRowImge:(NSString *)strUrl withData:(void (^)(id responseData))completionBlock;

@end
