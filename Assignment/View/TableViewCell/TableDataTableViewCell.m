//
//  TableDataTableViewCell.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "TableDataTableViewCell.h"
#define noImageName @"noimage.png" // default image

@interface TableDataTableViewCell()
{
    InfoObject *currentInfo;
}

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation TableDataTableViewCell

- (void)awakeFromNib  // calling from XIB
{
    // Initialization code
    
    _lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
    _lblDescription.numberOfLines = 0;
    _lblDescription.translatesAutoresizingMaskIntoConstraints = NO;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    _lblDescription.preferredMaxLayoutWidth = CGRectGetWidth(_lblDescription.frame);
    
}



-(void)updateData:(InfoObject *)infObj
{
    currentInfo=infObj;
    
    [_lblTitle setText:[NSString stringWithFormat:@"%@",currentInfo.strTitle]];
    [_lblDescription setText:[NSString stringWithFormat:@"%@",currentInfo.strDescription]];
    
    
    _imgImage.image=nil;   // clear image when reusing
    
    _activityIndicator.hidden=NO;
    [_activityIndicator startAnimating];
    
     _imgImage.image = [UIImage imageNamed:noImageName];
    
    if (currentInfo.urlImage != (id)[NSNull null])   // image url should not be nil
    {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            
            
            
            InfoObject *infObj=[[InfoObject alloc] init];
            [infObj fetchImage:[NSString stringWithFormat:@"%@",currentInfo.urlImage] withData:^(id responseData) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (responseData && responseData!=nil)   // image url needs data
                    {
                        _imgImage.image = responseData;
                        [_activityIndicator stopAnimating];
                        _activityIndicator.hidden=YES;
                    }
                    
                });
            }];
            
                    
           
            
        });
        
    }

    
    
}
@end
