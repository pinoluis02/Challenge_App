//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MasterRootController.h"
#import "ChallengeTableViewCellFull.h"
#import "EvidenceTableViewCellFull.h"
#import "SendChallengeViewController.h"

@interface MasterRootController (){
bool tabBarVerticalSpaceConstraintFixed;
//    id mSelectedItem;
        CGFloat mainViewHeight;
        UILongPressGestureRecognizer * tableHeaderLpgr;
        UILongPressGestureRecognizer * tableLpgr;
        UITapGestureRecognizer * tableHeaderTapGr;
}
@end

@implementation MasterRootController



-(NSString *)nibName{
    NSString * classNameStr = NSStringFromClass([MasterRootController class]);
    return classNameStr;
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
    else if([command isEqualToString:@"Share"]){
        Challenge * challenge;
        Evidence * evidence;
        NSString *title, *thumbnailUrl, *description, *videoUrl;
        if([self.selectedItem class] == [Challenge class]){
            challenge = self.selectedItem;
            title = challenge.title;
            thumbnailUrl = challenge.urlThumbnail;
            videoUrl = challenge.urlResource;
            description = challenge.descriptionItem;
        }else if([self.selectedItem class] == [Evidence class]){
            evidence = self.selectedItem;
            challenge = self.selectedItem;
            title = [[NSString alloc] initWithFormat:@"%@'s evidence", evidence.userName];
            thumbnailUrl = evidence.videoUrl;
            videoUrl = evidence.imageUrl;
            description = evidence.descriptionEvidence;
        }
        
        [[FbSingleton sharedInstance] shareLinkWithURL:videoUrl Title:title Description:description ImageUrl:thumbnailUrl];
    }
    else if([command isEqualToString:@"Challenge People"]){
        self.commandMenuController.itemsInTable = nil;
        SendChallengeViewController * shareController = [SendChallengeViewController new];
        [self pushToNavigationController:shareController];
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
        [self pushToNavigationController:newRootController];
    }
}

-(void)pushToNavigationController:(UIViewController *)controller{
    self.navigationController.navigationBar.translucent = false;
    self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:controller animated:true];

}

-(UIView*)createTableHeaderView: (id)object{
    return nil;
    
}



-(void)setUpTableContent{
    MasterTableViewController * tableContentController = [self.tableControllerClass new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
//    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;
    
    UIView * header = [self createTableHeaderView:self.selectedItem];
    
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = header.frame;
    frame.size.height = height;
    header.frame = frame;
    
    self.tableContentController.tableView.tableHeaderView = header;
    
    tableHeaderLpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressOnHeaderView:)];
    tableHeaderLpgr.minimumPressDuration = 1.0; //seconds
    tableHeaderLpgr.delegate = self;
    [header addGestureRecognizer:tableHeaderLpgr];
    
    tableHeaderTapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnHeaderView:)];
    tableHeaderTapGr.delegate = self;
    [header addGestureRecognizer:tableHeaderTapGr];

    tableLpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressOnTable:)];
    tableLpgr.minimumPressDuration = 1.0; //seconds
    tableLpgr.delegate = self;
    [self.tableContentController.tableView addGestureRecognizer:tableLpgr];
    
}

- (void)handleTapOnHeaderView:(UILongPressGestureRecognizer *)gestureRecognizer{
        [self itemSelectionHandler:self.selectedItem selectedByLongPress:NO];
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


+(UIView*)createTableHeaderViewForChallenge: (Challenge *)object{
    NSString * classNameStr = NSStringFromClass([ChallengeTableViewCellFull class]);
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:classNameStr
                                                      owner:self
                                                    options:nil];
    Challenge * item = object;
    ChallengeTableViewCellFull * customCell = [ nibViews objectAtIndex: 0];
    customCell.title.text = item.title;
    customCell.challengeDescription.text = item.descriptionItem;
    customCell.author.text = item.nameAuthor;
    customCell.pubDate.text = item.creationDate;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.urlThumbnail]];
    UIImage * image = [UIImage imageWithData:imageData];
    [customCell.image setImage:image];
    
    return customCell;
    
}


+(UIView*)createTableHeaderViewForEvidence: (Evidence *)object{
    NSString * classNameStr = NSStringFromClass([EvidenceTableViewCellFull class]);
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:classNameStr
                                                      owner:self
                                                    options:nil];
    
    Evidence * item = object;
    EvidenceTableViewCellFull * customCell = [ nibViews objectAtIndex: 0];
   
    
    customCell.evidenceDescription.text = item.descriptionEvidence;
    customCell.authorUsername.text = item.userName;
    customCell.creationDate.text = item.created_at;
    UIImage * image = [UIImage imageNamed:@"missing"];
    if(![item.imageUrl isKindOfClass:[NSNull class]]){
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.  imageUrl]];
         if(imageData != nil)
             image = [UIImage imageWithData:imageData];
    }
    [customCell.thumbnail setImage:image];
    return  customCell;
    
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
    else if([item.userStatus isEqualToString:@"notDecided"]){
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
