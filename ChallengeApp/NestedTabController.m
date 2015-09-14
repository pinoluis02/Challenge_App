//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NestedTabController.h"
#import "ChallengesRootController.h"

@interface NestedTabController (){
bool tabBarVerticalSpaceConstraintFixed;
    UINavigationController * rootController;
}
@end

@implementation NestedTabController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];


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
    if(rootController){
        [rootController removeFromParentViewController ];
    }
    ChallengesRootController * root = [ChallengesRootController new];
    root.contentType = item.tag;
    UINavigationController * embededRoot = [[UINavigationController alloc] initWithRootViewController:root];
    [self.contentView addSubview:embededRoot.view];
    embededRoot.view.frame = CGRectMake(0, 0, self.contentView.frame.size.width,  self.contentView.frame.size.height);
    rootController = embededRoot;

}



@end
