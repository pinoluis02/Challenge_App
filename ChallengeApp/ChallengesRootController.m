//
//  ChallengesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengesRootController.h"
#import "Challenge.h"

@interface ChallengesRootController ()

@end

@implementation ChallengesRootController


-(NSString *)nibName{
    return @"CustomRootController";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpMenuContent{
    ExpandableTableViewController *commandMenuController = [ExpandableTableViewController new];
    self.commandMenuController = commandMenuController;
    [self addChildViewController:commandMenuController];
    [self.commandMenuView addSubview:commandMenuController.view];
    commandMenuController.view.frame = CGRectMake(0, 0, self.commandMenuView.frame.size.width,  self.commandMenuView.frame.size.height);
    commandMenuController.coordinatorController = self;
}


-(void)setUpMainViewContent{
    return;
}

-(void)setUpTableContent{
    ChallengeTableViewController * tableContentController = [ChallengeTableViewController new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;
}


-(void)coordinateMainItemSelection:(Challenge *)item
               selectedByLongPress:(BOOL)longPress{
    NSAssert(NO, @"ChallengesRootController shouldn't have a main item.");
}

-(void)coordinateItemSelection:(Challenge *)item
           selectedByLongPress:(BOOL)longPress;
{
    
    if(longPress){

        //unrelated, invited, accepted (incomplete), rejected, completed.
        NSArray * items = [CustomRootController loadMenuItemsForChallengeItem:item];
        self.commandMenuController.itemsInTable = items;
    }
    else{
        CustomRootController * newSpan = [CustomRootController new];
        newSpan.userId = 99;
        [self.navigationController pushViewController:newSpan animated:true];
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
