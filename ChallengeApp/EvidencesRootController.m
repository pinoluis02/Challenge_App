//
//  EvidencesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "EvidencesRootController.h"
#import "OriginalItemTableViewCell.h"
#import "NSDate+Utils.h"

@interface EvidencesRootController ()
{
    CGFloat mainViewHeight;
    UILongPressGestureRecognizer * mainViewLpgr;
    UIView * headerView;
}
@end

@implementation EvidencesRootController



-(NSString *)nibName{
    return @"CustomRootController";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData:self.selectedItem];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        id item = self.mainItem;
        [self coordinateMainItemSelection:(Challenge *)item selectedByLongPress:YES];
    
    }
}
//
//-(void)selectedItemSet:(id)item{
//
//}

-(void)updateViewConstraints{
    self.mainViewHeightConstraint.constant = mainViewHeight;
    [super updateViewConstraints];
}


- (UIView *)headerView
{
    // If you have not loaded the headerView yet...
    if (!headerView) {
        headerView = [self setUpMainViewContentWithItem:self.selectedItem];
    }
    return headerView;
}



-(void) fetchData:(Challenge *)challenge{
    BOOL debug = true;
    if(!debug)
    {
//     network code   
    }else
    {
        [self setDemoData];
    }
}



-(void)setUpMenuContent{
    ExpandableTableViewController *commandMenuController = [ExpandableTableViewController new];
    self.commandMenuController = commandMenuController;
    [self addChildViewController:commandMenuController];
    [self.commandMenuView addSubview:commandMenuController.view];
    commandMenuController.view.frame = CGRectMake(0, 0, self.commandMenuView.frame.size.width,  self.commandMenuView.frame.size.height);
    commandMenuController.coordinatorController = self;
}

-(UIView*)setUpMainViewContentWithItem: (Challenge *)item{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OriginalItemTableViewCell"
                                                      owner:self
                                                    options:nil];
    
    OriginalItemTableViewCell * customCell = [ nibViews objectAtIndex: 0];
    self.mainItemView.gestureRecognizers = [NSArray array];
    customCell.title.text = item.title;
    customCell.challengeDescription.text = item.descriptionItem;
    customCell.author.text = item.nameAuthor;
    customCell.pubDate.text = item.creationDate;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.urlThumbnail]];
    UIImage * image = [UIImage imageWithData:imageData];
    [customCell.image setImage:image];
    
    [self.mainItemView addSubview:customCell];
    mainViewLpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    mainViewLpgr.minimumPressDuration = 1.0; //seconds
    mainViewLpgr.delegate = self;
    [self.mainItemView addGestureRecognizer:mainViewLpgr];
    
    return customCell;
    
}

-(void)setUpMainViewContent{
    mainViewHeight = 1;
    [self.view setNeedsUpdateConstraints];

}

-(void)setUpTableContent{
    EvidencesTableViewController * tableContentController = [EvidencesTableViewController new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;
    UIView * header = self.headerView;
    [self.tableContentController.tableView setTableHeaderView:header];
}


-(void)coordinateMainItemSelection:(Challenge *)item
               selectedByLongPress:(BOOL)longPress{
    NSAssert(NO, @"ChallengesRootController shouldn't have a main item.");
}

-(void)coordinateTableItemSelection:(Challenge *)item
                selectedByLongPress:(BOOL)longPress;
{
    
    if(longPress){
        //unrelated, invited, accepted (incomplete), rejected, completed.
        NSArray * items = [CustomRootController loadMenuItemsForChallengeItem:item];
        self.commandMenuController.itemsInTable = items;
    }
    else{
        CustomRootController * newSpan = [CustomRootController new];
        [self.navigationController pushViewController:newSpan animated:true];
        
    }
    
}

-(void)coordinateMenuHeightChange:(CGFloat)height{
    [super coordinateMenuHeightChange:height];
}

-(void)coordinateMenuItemSelection:(NSString *)command{
    [super coordinateMenuItemSelection:command];
}

#pragma mark -



-(void)setDemoData{
    
    NSString * loremLipsum = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    
    Evidence * itemOne = [Evidence new];
    
    itemOne.evidenceId = @"1";
    itemOne.challengeId = @"1";
    itemOne.imageUrl = @"http://i.cdn.turner.com/asfix/repository//8a25c3920eec2495010eecf65c5a16f7/thumbnail_8877914413458619170.jpg";
    itemOne.videoUrl = @"http://i.cdn.turner.com/asfix/repository//8a25c3920eec2495010eecf65c5a16f7/thumbnail_8877914413458619170.jpg";
    itemOne.created_at = [[NSDate date] shortFormattedDateString];
    
    Evidence * itemTwo = [Evidence new];
    itemTwo.evidenceId = @"1";
    itemTwo.challengeId = @"1";
    itemTwo.imageUrl = @"http://i.cdn.turner.com/asfix/repository//8a25c3920eec2495010eecf65c5a16f7/thumbnail_8877914413458619170.jpg";
    itemTwo.videoUrl = @"http://i.cdn.turner.com/asfix/repository//8a25c3920eec2495010eecf65c5a16f7/thumbnail_8877914413458619170.jpg";
    itemTwo.created_at = [[NSDate date] shortFormattedDateString];
    
    
    NSArray * resultsArray = @[itemOne, itemTwo];
    
    self.evidencesArray = resultsArray;
    self.tableContentController.itemsArray = self.evidencesArray;
}

@end
