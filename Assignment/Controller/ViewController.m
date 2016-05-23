//
//  ViewController.m
//  Assignment
//
//  Created by Pratap on 20/05/16.
//  Copyright © 2016 Pratap. All rights reserved.p
//

#import "ViewController.h"
#import "InfoObject.h"
#import "Content.h"
#import "TableDataTableViewCell.h"

#define loadingFont [UIFont fontWithName:@"HelveticaNeue-Thin" size:22.0]
#define cellIdentifier @"Cell"
#define cellMinimumHeight 100.0
#define descriptionTextMaximumWidth   200.0
#define descriptionTextMaximumHeight  300.0


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *tblView;
    NSArray *arrRowData;
    UILabel *lblLoadeing;
}

-(void)createTableView;
-(void)refreshData:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData:)];
    self.navigationItem.rightBarButtonItem = refreshButton;

    lblLoadeing=[[UILabel alloc] initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)-15.0, self.view.frame.size.width-40.0, 30.0)];    // Data Loading
    [self.view addSubview:lblLoadeing];
    lblLoadeing.textAlignment=NSTextAlignmentCenter;
    [lblLoadeing setText:@"Loading ..... "];
    lblLoadeing.font= loadingFont;
    
    Content *content=[[Content alloc] init];
    [content getConnection:^(NSMutableArray *responseObj)
    {
        [self setTitle:content.strTitle];
        [lblLoadeing removeFromSuperview];
        [self createTableView];
        arrRowData=[responseObj copy];

    }];
    

}


-(void)refreshData:(id)sender
{
    if ([arrRowData count] >0)
    {
        [tblView reloadData];
    }
 
}


-(void)createTableView
{
    tblView=[[UITableView alloc]initWithFrame:CGRectMake(0, 66.0, self.view.frame.size.width, self.view.frame.size.height-66.0)];
    tblView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tblView.dataSource=self;
    tblView.delegate=self;
    [self.view addSubview:tblView];
    
    UINib *nib = [UINib nibWithNibName:@"TableDataTableViewCell" bundle:nil];
    [tblView registerNib:nib forCellReuseIdentifier:cellIdentifier];

  
        arrRowData=[[NSArray alloc] init];    // Tableview Data

}





#pragma mark - TableView DataSource Implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [arrRowData count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a reusable cell
    
    
    TableDataTableViewCell *dataCell = (TableDataTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [dataCell updateData:(InfoObject *)[arrRowData objectAtIndex:indexPath.row]];
    [dataCell.contentView bringSubviewToFront:dataCell];

    
    
    return dataCell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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




-(CGSize)getSizeForText:(NSString *)text     // get dynamic text width and height
{

    
    CGSize constraintSize;
    constraintSize.height = descriptionTextMaximumHeight;
    constraintSize.width = descriptionTextMaximumWidth;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"TrebuchetMS-Bold" size:17.0], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [text boundingRectWithSize:constraintSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];
    
    CGSize stringSize = frame.size;
    return stringSize;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
