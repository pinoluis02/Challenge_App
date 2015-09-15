//
//  ExpandableTableViewController.m
//  ExpandableTable
//
//  Created by Manpreet Singh on 06/12/13.
//  Copyright (c) 2013 Manpreet Singh. All rights reserved.
//

#import "ExpandableTableViewController.h"
#import "ExpandableTableViewCell.h"
#import "MasterRootController.h"

@interface ExpandableTableViewController ()
{
    
    NSMutableArray *itemsInTable;
}
@end



@implementation ExpandableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    self.menuTableView = (UITableView*)self.view;
     NSString * classNameStr = NSStringFromClass([ExpandableTableViewCell class]);
    UINib *cellNib = [UINib nibWithNibName:classNameStr bundle:nil];
    [self.menuTableView registerNib: cellNib forCellReuseIdentifier:classNameStr];

    //    WARNING: Don't remove this, this is the simplest way to the total height required by the table's cell.
    self.menuTableView.rowHeight = 36;
}

-(NSArray *) itemsInTable{
    return itemsInTable;
}

-(void)setItemsInTable:(NSArray *)value{
    itemsInTable=[[NSMutableArray alloc] init];
    [itemsInTable addObjectsFromArray:value];
    [self.menuTableView reloadData];
    
    if(!value || [value count] == 0){
        [self notifyCoordinatorOfSizeChange];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger i = [self.itemsInTable count];
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Title= [[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Name"];
    return [self createCellWithTitle:Title image:[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Image name"] indexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.itemsInTable objectAtIndex:indexPath.row];
    if([dic valueForKey:@"SubItems"])
    {
        
        		NSArray *arr=[dic valueForKey:@"SubItems"];
        		BOOL isTableExpanded=NO;
        
        		for(NSDictionary *subitems in arr )
                {
        			NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
        			isTableExpanded=(index>0 && index!=NSIntegerMax);
        			if(isTableExpanded) break;
        		}
        
        		if(isTableExpanded)
                {
        			[self CollapseRows:arr];
        		}
                else
                {
        			NSUInteger count=indexPath.row+1;
                    NSMutableArray *arrCells=[NSMutableArray array];
        			for(NSDictionary *dInner in arr )
                    {
        				[arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
        				[itemsInTable insertObject:dInner atIndex:count++];
        			}
                [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
                }
                [self notifyCoordinatorOfSizeChange];
    }
    else{
        [self notifyCoordinatorOfCommandSelection: [dic valueForKey:@"Name"]];
    }
}

-(void)notifyCoordinatorOfCommandSelection:(NSString *)command{
    [self.coordinatorController coordinateMenuItemSelection:command];
}

-(void)CollapseRows:(NSArray*)ar
{
	for(NSDictionary *dInner in ar )
    {
		NSUInteger indexToRemove=[self.itemsInTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"SubItems"];
		if(arInner && [arInner count]>0)
        {
			[self CollapseRows:arInner];
		}
		
		if([self.itemsInTable indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
			[itemsInTable removeObjectIdenticalTo:dInner];
			[self.menuTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                    [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                    ]
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
	}
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
         [self notifyCoordinatorOfSizeChange];
    }
}

-(void)notifyCoordinatorOfSizeChange{
    CGFloat height = self.menuTableView.rowHeight;
    height *= [self.menuTableView numberOfRowsInSection:0];
    [self.coordinatorController coordinateMenuHeightChange:height];
}

- (UITableViewCell*)createCellWithTitle:(NSString *)title image:(UIImage *)image  indexPath:(NSIndexPath*)indexPath
{
    NSString *CellIdentifier = @"ExpandableTableViewCell";
    ExpandableTableViewCell* cell = [self.menuTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    first menu item is handled as a header
    if(indexPath.row == 0){
        cell.selectedBackgroundView = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblTitle.textColor = [[UIColor alloc] initWithRed:0.0 green:122.f/255.f blue:1.f alpha:1.f];
       // cell.lblTitle.font = [UIFont systemFontOfSize:17.0f weight:5.f];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    else{
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor grayColor];
        cell.selectedBackgroundView = bgView;
        cell.lblTitle.textColor = [UIColor blackColor];
        cell.indentationWidth = 25;
        float indentPoints = cell.indentationLevel * cell.indentationWidth;
        CGFloat width = cell.bounds.size.width;
        cell.backgroundColor = [[UIColor alloc]initWithWhite:1 - (indentPoints / width) alpha:1.0];
        
    }
        cell.lblTitle.text = title;

        
        [cell setIndentationLevel:[[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
    
        NSDictionary *d1=[self.itemsInTable objectAtIndex:indexPath.row] ;
    
        if([d1 valueForKey:@"SubItems"])
        {
            cell.btnExpand.alpha = 1.0;
            [cell.btnExpand addTarget:self action:@selector(showSubItems:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.btnExpand.alpha = 0.0;
        }
    
        return cell;
}

-(void)showSubItems :(id) sender
{

    UIButton *btn = (UIButton*)sender;
    CGRect buttonFrameInTableView = [btn convertRect:btn.bounds toView:self.menuTableView];
    NSIndexPath *indexPath = [self.menuTableView indexPathForRowAtPoint:buttonFrameInTableView.origin];
    
    if(btn.alpha==1.0)
    {
        if ([[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"down-arrow.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"up-arrow.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"down-arrow.png"] forState:UIControlStateNormal];
        }
        
    }
    
    NSDictionary *d=[self.itemsInTable objectAtIndex:indexPath.row] ;
    NSArray *arr=[d valueForKey:@"SubItems"];
    if([d valueForKey:@"SubItems"])
    {
        BOOL isTableExpanded=NO;
        for(NSDictionary *subitems in arr )
        {
            NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
            isTableExpanded=(index>0 && index!=NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self CollapseRows:arr];
            //    Shows is in charge also of collpasing the rows don't let the name fool you.
            
        }
        else
        {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arrCells=[NSMutableArray array];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [itemsInTable insertObject:dInner atIndex:count++];
            }
            [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
            
        }
        
        [self notifyCoordinatorOfSizeChange];
    }
    

}


@end
