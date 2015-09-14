//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MasterRootController.h"
#import "OriginalItemTableViewCell.h"

@interface MasterRootController (){
bool tabBarVerticalSpaceConstraintFixed;
//    id mSelectedItem;
        CGFloat mainViewHeight;
        UILongPressGestureRecognizer * mainViewLpgr;
        UILongPressGestureRecognizer * tableLpgr;
}
@end

@implementation MasterRootController



-(NSString *)nibName{
    return @"CustomRootController";
}
- (void)viewWillAppear:(BOOL)animated {
    if(self.isFirstControllerInNavigation){
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideUnnecessayView];
    
    [self setUpMenuContent];
    [self setUpTableContent];

}

-(void)updateViewConstraints{
    self.mainViewHeightConstraint.constant = mainViewHeight;
    [super updateViewConstraints];
}


//-(id)selectedItem{
//    return mSelectedItem;
//}
//
//-(void)setSelectedItem:(id)value{
//    mSelectedItem = value;
//    [self selectedItemSet];
//}
//
//- (void)selectedItemSet {
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)hideUnnecessayView{
    mainViewHeight = 0;
    [self.view setNeedsUpdateConstraints];
}

-(void)setUpMenuContent{
    ExpandableTableViewController *commandMenuController = [ExpandableTableViewController new];
    self.commandMenuController = commandMenuController;
    [self addChildViewController:commandMenuController];
    [self.commandMenuView addSubview:commandMenuController.view];
    commandMenuController.view.frame = CGRectMake(0, 0, self.commandMenuView.frame.size.width,  self.commandMenuView.frame.size.height);
    commandMenuController.coordinatorController = self;
}


-(void)coordinateMenuHeightChange:(CGFloat)height{
    if(height == 0)
    {
        height = 1; //Set it to zero and is gone for sure, don't know why though.
    }
    self.commandMenuViewHeightConstraint.constant = height;
}


-(void)coordinateMenuItemSelection:(NSString *)command{
    if([command isEqualToString:@"Cancel"]){
        self.commandMenuController.itemsInTable = nil;
    }
}


-(void)coordinateTableItemSelection:(id)item
                selectedByLongPress:(BOOL)longPress;
{
    [self itemSelectionHandler:item selectedByLongPress:longPress];
}

-(void)itemSelectionHandler:(id)item
                selectedByLongPress:(BOOL)longPress;
{
    if(longPress){
        //unrelated, invited, accepted (incomplete), rejected, completed.
        NSArray * items = [MasterRootController loadMenuItemsForChallengeItem:item];
        self.commandMenuController.itemsInTable = items;
    }
    else{
        MasterRootController * newRootController = [self.nextRootControllerClass new];
        newRootController.selectedItem = item;
        self.navigationController.navigationBar.translucent = false;
        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
        [self.navigationController pushViewController:newRootController animated:true];
        
    }
}

-(UIView*)createTableHeaderView: (id)object{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OriginalItemTableViewCell"
                                                      owner:self
                                                    options:nil];
    if(!object){ return nil; }
    Challenge * item = (Challenge *)object;
    OriginalItemTableViewCell * customCell = [ nibViews objectAtIndex: 0];
    customCell.title.text = item.title;
    customCell.challengeDescription.text = item.descriptionItem;
    customCell.author.text = item.nameAuthor;
    customCell.pubDate.text = item.creationDate;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.urlThumbnail]];
    UIImage * image = [UIImage imageWithData:imageData];
    [customCell.image setImage:image];
    return customCell;
    
}


-(void)setUpTableContent{
    MasterTableViewController * tableContentController = [self.tableControllerClass new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;
    
    UIView * header = [self createTableHeaderView:self.selectedItem];
    [self.tableContentController.tableView setTableHeaderView:header];
    
    mainViewLpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressOnHeaderView:)];
    mainViewLpgr.minimumPressDuration = 1.0; //seconds
    mainViewLpgr.delegate = self;
    [header addGestureRecognizer:mainViewLpgr];

    tableLpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressOnTable:)];
    tableLpgr.minimumPressDuration = 1.0; //seconds
    tableLpgr.delegate = self;
    [self.tableContentController.tableView addGestureRecognizer:tableLpgr];
}


-(void)handleLongPressOnHeaderView:(UILongPressGestureRecognizer *)recognizer{
    [self itemSelectionHandler:self.selectedItem selectedByLongPress:YES];
}

- (void)handleLongPressOnTable:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [gestureRecognizer locationInView:self.tableContentController.tableView];
        
        NSIndexPath *indexPath = [self.tableContentController.tableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            return;
        } else {
            id item = self.tableContentController.itemsArray[indexPath.row];
            [self itemSelectionHandler:item selectedByLongPress:YES];
        }
    }
}


+(NSArray *)loadMenuItemsForEvidence{
    NSDictionary * dict;
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"evidenceCommands" ofType:@"plist"]];
    NSArray * items =  [dict valueForKey:@"Items"];
    return  items;
}

+(NSArray *)loadMenuItemsForChallengeItem:(Challenge *)item{
    NSDictionary * dict;
    if([item.userStatus isEqualToString:@"unrelated"]){
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"unrelatedChallengeCommands" ofType:@"plist"]];
    }
    else if([item.userStatus isEqualToString:@"notified"]){
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notificationPendingChallengeCommands" ofType:@"plist"]];
    }
    else if([item.userStatus isEqualToString:@"accepted"]){
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"incompleteChallengeCommands" ofType:@"plist"]];
    }
    else if([item.userStatus isEqualToString:@"rejected"]){
        //        For this version rejected items behave the same as unrelated items.
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"unrelatedChallengeCommands" ofType:@"plist"]];
    }
    else if([item.userStatus isEqualToString:@"completed"]){
        dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"completedChallengeCommands" ofType:@"plist"]];
    }
    else{
        NSAssert(false, @"you made a mistake programmer");
    }
    
    NSArray * items =  [dict valueForKey:@"Items"];
    return  items;
}


@end
