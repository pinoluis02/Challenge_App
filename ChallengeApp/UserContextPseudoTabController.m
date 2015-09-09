//
//  UserContextPseudoTabController.m
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UserContextPseudoTabController.h"

@interface UserContextPseudoTabController (){
bool tabBarVerticalSpaceConstraintFixed;
}
@end

@implementation UserContextPseudoTabController

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
        //         id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
        id<UILayoutSupport> topLayoutGuide = self.topLayoutGuide;
        //        CGRect screenRect = [[UIScreen mainScreen] bounds];
        //        CGFloat screenHeight = screenRect.size.height;
        //        [self.contextTabBar sizeToFit];
        //        CGFloat tabBarHeight = self.contextTabBar.bounds.size.height;
        //        self.tabBarVerticalSpaceConstraint.constant = screenHeight - [bottomLayoutGuide length] - tabBarHeight;
        self.tabBarVerticalSpaceConstraint.constant = [topLayoutGuide length];
        
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
