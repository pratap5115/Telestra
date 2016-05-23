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
@property(nonatomic,strong)NSString *strTitle;

-(void)getConnection:(void (^)(NSMutableArray * responseObj))completionBlock;
- (void)getImge:(NSString *)strUrl withData:(void (^)(id responseData))completionBlock;

@end
