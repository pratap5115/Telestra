//
//  TableDataTableViewCell.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.
//

#import "TableDataTableViewCell.h"
#import "Constants.h"

@interface TableDataTableViewCell()
{
    InfoObject *currentInfo;
    
    UIImageView *imgView;
    UILabel *lblTitle;
    UIActivityIndicatorView *activityIndicator;
}


@end

@implementation TableDataTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
                
        self.userInteractionEnabled=NO;
        
        imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10,80,80)];
        [self.contentView addSubview:imgView];
        imgView.translatesAutoresizingMaskIntoConstraints = NO;
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.center = CGPointMake(imgView.frame.size.width / 2, imgView.frame.size.height / 2);
        [imgView addSubview:activityIndicator];


        
        
        lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+10.0, 10, self.contentView.frame.size.width-(imgView.frame.size.width+imgView.frame.origin.x+10.0), 21)];
        lblTitle.textAlignment=NSTextAlignmentLeft;
        lblTitle.font = [UIFont fontWithName:kHelveticaNeue size:kDescriptionText];
        [self.contentView addSubview:lblTitle];
        lblTitle.translatesAutoresizingMaskIntoConstraints = NO;

        
        
        _lblDescription=[[UILabel alloc] initWithFrame:CGRectMake(lblTitle.frame.origin.x, lblTitle.frame.origin.y+lblTitle.frame.size.height+10.0, lblTitle.frame.size.width, 21)];
        _lblDescription.textAlignment=NSTextAlignmentLeft;
        _lblDescription.font = [UIFont fontWithName:kHelveticaNeue size:kDescriptionText];

        [self.contentView addSubview:_lblDescription];
        
        _lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        _lblDescription.numberOfLines = 0;
        _lblDescription.translatesAutoresizingMaskIntoConstraints = NO;

        
        
        [self addingConstraints];
        
    }
    return self;
}

-(void)addingConstraints
{

// imageView Constraints
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:2.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:2.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:80.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:80.0]];
    
    
    
    // Activity Indicator Constraints
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:imgView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1.0
                                                                  constant:0.0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:imgView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    
    // Title Label Constraints
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lblTitle
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:2.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lblTitle
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:imgView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:8.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:lblTitle
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:1.0]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_lblDescription
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:lblTitle
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:1.0]];
   
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lblTitle
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:20.0]];
    
    
    
    
    
    
    
    // Description Label Constraints
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_lblDescription
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:imgView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:8.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_lblDescription
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:1.0]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_lblDescription
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:1.0]];


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
    
}



-(void)updateData:(InfoObject *)infObj
{
    currentInfo=infObj;
    
    [lblTitle setText:[NSString stringWithFormat:@"%@",currentInfo.strTitle]];
    [_lblDescription setText:[NSString stringWithFormat:@"%@",currentInfo.strDescription]];
    
    

    @try {
        
        [imgView setImage:nil]; // clear image when reusing
        
        
        activityIndicator.hidden=NO;
        [activityIndicator startAnimating];
        
        [imgView setImage:[UIImage imageNamed:noImageName] ];
        
        if (currentInfo.urlImage != (id)[NSNull null])   // image url should not be nil
        {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^{
                
                InfoObject *infObj=[[InfoObject alloc] init];
                
                [infObj fetchImage:[NSString stringWithFormat:@"%@",currentInfo.urlImage] withData:^(NSData *responseData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (responseData && responseData!=nil)   // image url needs data
                        {
                            [imgView setImage:[UIImage imageWithData:responseData]];
                            [activityIndicator stopAnimating];
                            activityIndicator.hidden=YES;
                        }
                        
                    });
                }];
            });
            
        }
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception :%@",exception);
    }
    
    
   

    
    
}
@end
