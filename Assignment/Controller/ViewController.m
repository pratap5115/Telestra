//
//  ViewController.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.p
//

#import "ViewController.h"
#import "Constants.h"
#import "InfoObject.h"
#import "TableDataTableViewCell.h"
#import "Reachability.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *tblView;
    NSArray *arrRowData;
    UILabel *lblLoadeing;
    BOOL isCommunicationFirstTime;   // check first time Data Loaded on Tableview or Not
}

-(void)createTableView;
-(void)refreshData:(id)sender;
-(CGSize)getSizeForText:(NSString *)text;
-(BOOL)isNetworkAvailable;
-(void)serviceDataWithTableviewCommunication;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData:)];
    self.navigationItem.rightBarButtonItem = refreshButton;

    lblLoadeing=[[UILabel alloc] initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)-15.0, self.view.frame.size.width-40.0, 30.0)];    // Data Loading
    [self.view addSubview:lblLoadeing];
    lblLoadeing.textAlignment=NSTextAlignmentCenter;
    [lblLoadeing setText:loadingLabelText];
    lblLoadeing.font= loadingLabelFont;
    
    [self serviceDataWithTableviewCommunication];
    isCommunicationFirstTime=YES;
}

/*!
 *  Checking Network
 *  Data Available Creating and data loading on Tableview
 */
-(void)serviceDataWithTableviewCommunication
{
    if ([self isNetworkAvailable])
    {
        InfoObject *infObj=[[InfoObject alloc] init];
        [infObj fetchData:^(NSMutableArray *responseObj)
         {
             if ([responseObj count]>0)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     // Why are we dispatching this to the main queue?
                     // Because InfoObject Service Calling in backing layer for UITableView
                     // can only be manipulated on the main thread.
                     
                     isCommunicationFirstTime=NO;
                     
                     [self setTitle:infObj.strHeadingTitle];
                     [lblLoadeing removeFromSuperview];
                     [self createTableView];
                     arrRowData=[responseObj copy];
                     
                 });
             }
         }];
    }
    else
    {
        [self showAlertTitle:kNetworkAlertTitle WithMessage:kNetworkMessageTitle];
    }
}


/*! 
 *  Creating Tableview
 *  initializing Object for Tableview data
 */
-(void)createTableView
{
    tblView=[[UITableView alloc]initWithFrame:CGRectMake(0, 66.0, self.view.frame.size.width, self.view.frame.size.height-66.0)];
    tblView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tblView.dataSource=self;
    tblView.delegate=self;
    [self.view addSubview:tblView];
    
    arrRowData=[[NSArray alloc] init];    // Tableview Data

}

/*!
 *   Refresh Tableview Data
 *   Note : Due to Network issues at least one time table list not loaded again it will hit service URL
 *   Refreshing Data when Already Table Data loaded
 */
-(void)refreshData:(id)sender
{
    if (isCommunicationFirstTime)
    {
        [self serviceDataWithTableviewCommunication];
    }
    else
    {
        if ([arrRowData count] >0)
        {
            [tblView reloadData];
        }
    }
}

#pragma mark - TableView DataSource Implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrRowData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

/*!
 * Create a reusable Tableview cell
 * For  The result
 */
    
    TableDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[TableDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    [cell updateData:(InfoObject *)[arrRowData objectAtIndex:indexPath.row]];

    return cell;
}


#pragma mark - TableView Delegate Implementation
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
/*!
 *  Calculating Dynamic Height of Cell
 *  InfoObject is Custom Data Object for UITableview Cell
 *  infObj.strDescription is row text
 */
    
    
    TableDataTableViewCell *cell = [[TableDataTableViewCell alloc] init];
    
    InfoObject *infObj=(InfoObject *)[arrRowData objectAtIndex:indexPath.row];
    cell.lblDescription.text=[NSString stringWithFormat:@"%@",infObj.strDescription];
    
    
  
   CGFloat contentHeight = [self getSizeForText:[NSString stringWithFormat:@"%@",infObj.strDescription]].height;
    
    if (contentHeight <=cellMinimumHeight)    // row height is minimum 100
    {
         contentHeight=cellMinimumHeight;
    }
    else          // row height is > 100  it will add 40 px for title and top,bottom space
    {
        contentHeight+=5.0;

    }
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
   
    
    return contentHeight;
}


#pragma mark - Helper Methods
/*!
 *  Calculating Dynamic Height for Description Lable
 *  Returns lblDescription label Sizes (Width,Height )
 *
 */

-(CGSize)getSizeForText:(NSString *)text      // get dynamic text width and height
{
    
    CGSize constraintSize;
    constraintSize.height = descriptionTextMaximumHeight;
    constraintSize.width = descriptionTextMaximumWidth;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:kHelveticaNeue size:kDescriptionTextFont], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize stringSize = frame.size;
    return stringSize;
    
    
}

/*!
 *  Check Network Connection
 *  Returns Boolean flag
 *
 */

-(BOOL)isNetworkAvailable
{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        return NO;  //connection unavailable
    }
    else
    {
       return YES;  //connection available
    }
    
}

/*!
*  Show Alert Message
*  @param1 alertTitle
*  @param2 strMessage
*
*/
-(void)showAlertTitle:(NSString *)alertTitle WithMessage:(NSString *)strMessage
{
    if ([UIAlertController class])  //  >= IOS 8 and Above
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        // Why are we dispatching this to the main queue?
        // Note: Error Happening from popup view controller show the alert controller directly from parent view

            
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:strMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:kAlertOKButtonTitle style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
        
    }
    else  // below ios8  < IOS 8
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:alertTitle message:strMessage delegate:nil cancelButtonTitle:kAlertOKButtonTitle otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

#pragma mark - deallocating
-(void)dealloc
{
    [tblView removeFromSuperview];
    tblView=nil;
    
    arrRowData=nil;
    
    [lblLoadeing removeFromSuperview];
    lblLoadeing=nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
