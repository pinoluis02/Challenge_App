//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "GlobalContextPseudoTabController.h"

@interface GlobalContextPseudoTabController (){
bool tabBarVerticalSpaceConstraintFixed;
}
@end

@implementation GlobalContextPseudoTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

        UITabBar * visibleTabBar;
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

        visibleTabBar.hidden = false;
        visibleTabBarVerticalConstraint.constant = [topLayoutGuide length];
        self.contentViewVerticalSpaceConstraint.constant = visibleTabBarVerticalConstraint.constant;
        NSLog(@"length: %fd", visibleTabBarVerticalConstraint.constant);
        
        tabBarVerticalSpaceConstraintFixed = true;
    }
    [super updateViewConstraints];
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
