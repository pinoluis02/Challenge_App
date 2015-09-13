//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "CustomRootController.h"

@interface CustomRootController (){
bool tabBarVerticalSpaceConstraintFixed;
}
@end

@implementation CustomRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChallengeTableViewController * tableContentController = [ChallengeTableViewController new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;

    ExpandableTableViewController *commandMenuController = [ExpandableTableViewController new];
    self.commandMenuController = commandMenuController;
    [self addChildViewController:commandMenuController];
    [self.commandMenuView addSubview:commandMenuController.view];
    commandMenuController.view.frame = CGRectMake(0, 0, self.commandMenuView.frame.size.width,  self.commandMenuView.frame.size.height);
    commandMenuController.coordinatorController = self;

    

}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"GlobalContextPseudoTabController_idLoginUser:%@",self.idLoginUser);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    if(!tabBarVerticalSpaceConstraintFixed){
//        http://stackoverflow.com/questions/19078278/is-there-any-way-to-add-constraint-between-a-view-and-the-top-layout-guide-in-a/26397943#26397943
        [super viewWillLayoutSubviews];

//        To set up constraint to the bottomGuide use code similar to:
//        id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
//        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        CGFloat screenHeight = screenRect.size.height;
//        [self.contextTabBar sizeToFit];
//        CGFloat tabBarHeight = self.contextTabBar.bounds.size.height;
//        self.tabBarVerticalSpaceConstraint.constant = screenHeight - [bottomLayoutGuide length] - tabBarHeight;

//        Fix selected tab bar.
         id<UILayoutSupport> topLayoutGuide = self.topLayoutGuide;
        
//        I need a normalized value, not the "at query time" value
        
        self.globalOptionsTabBar.hidden = true;
        self.userOptionsTabBar.hidden = true;
        
        self.userOptionsTabBarVerticalSpaceConstraint.constant = [topLayoutGuide length];


        NSLayoutConstraint * visibleTabBarVerticalConstraint;
        UITabBar * visibleTabBar;
        switch (self.tabBarType) {
            case GlobalOptionsTabBarType:
                visibleTabBar = self.globalOptionsTabBar;
                visibleTabBarVerticalConstraint = self.globalOptionsTabBarVerticalSpaceConstraint;
                break;
            case UserOptionsTabBarType:
                visibleTabBar = self.userOptionsTabBar;
                visibleTabBarVerticalConstraint = self.userOptionsTabBarVerticalSpaceConstraint;
                break;
            default:
                break;
        }

        visibleTabBar.selectedItem = visibleTabBar.items[1];
        [self tabBar:visibleTabBar didSelectItem:visibleTabBar.selectedItem];
        
        visibleTabBar.hidden = false;
//        topLayoutGuide is statusBar height.
//        NB. visibleTabBar.bounds.size.height and tabViewController.tabBar.frame.size.height return 0
        visibleTabBarVerticalConstraint.constant = [topLayoutGuide length];
        [visibleTabBar sizeToFit];
        CGFloat tabBarHeight  = visibleTabBar.frame.size.height;
        self.contentViewVerticalTopSpaceConstraint.constant = [topLayoutGuide length] + tabBarHeight;
        
        tabBarVerticalSpaceConstraintFixed = true;
    }
    [super updateViewConstraints];
}


//NB: each item should draw itself correctly based on its own type, and based on that the controller will show the appropiate commands

- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item{
    self.tableContentController.contentType = item.tag;

}


-(void)coordinateMainContentViewHeightWithMenuHeight:(CGFloat)height{
    if(height == 0)
    {
        height = 1; //Set it to zero and is gone for sure, don't know why though.
    }
    self.commandMenuViewHeightConstraint.constant = height;
}


-(void)respondToMenuItemSelection:(NSString *)command{
    if([command isEqualToString:@"Cancel"]){
        self.commandMenuController.itemsInTable = nil;
    }
}


-(void)coordinateItemSelection:(Challenge *)item
           selectedByLongPress:(BOOL)longPress;
{
        NSAssert(NO, @"Subclasses need to overwrite this method");
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
