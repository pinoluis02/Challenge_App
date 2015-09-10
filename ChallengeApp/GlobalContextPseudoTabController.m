//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "GlobalContextPseudoTabController.h"
#import "ChallengeTableViewController.h"

@interface GlobalContextPseudoTabController (){
bool tabBarVerticalSpaceConstraintFixed;
            UITabBar * visibleTabBar;
    NSArray * navigation;
    ChallengeTableViewController * contentController;
}
@end

@implementation GlobalContextPseudoTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    contentController = [ChallengeTableViewController new];
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    NSLog(@"updateViewConstraints");
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

        self.globalOptionsTabBar.hidden = true;
        self.userOptionsTabBar.hidden = true;
        
        self.userOptionsTabBarVerticalSpaceConstraint.constant = [topLayoutGuide length];


        NSLayoutConstraint * visibleTabBarVerticalConstraint;
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
        visibleTabBarVerticalConstraint.constant = [topLayoutGuide length];
        self.contentViewVerticalSpaceConstraint.constant = visibleTabBarVerticalConstraint.constant;
        
        tabBarVerticalSpaceConstraintFixed = true;
    }
    [super updateViewConstraints];
}


//NB: each item should draw itself correctly based on its own type, and based on that the controller will show the appropiate commands

- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item{
    contentController.contentType = item.tag;
    
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
