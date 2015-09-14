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
//    id mSelectedItem;
}
@end

@implementation CustomRootController

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
    
    [self setUpMainViewContent];
    [self setUpMenuContent];
    [self setUpTableContent];

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


-(void)setUpMenuContent{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
}


-(void)setUpMainViewContent{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
}

-(void)setUpTableContent{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
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


-(void)coordinateTableItemSelection:(NSObject *)item
           selectedByLongPress:(BOOL)longPress;
{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
}

-(void)coordinateMainItemSelection:(NSObject *)item
               selectedByLongPress:(BOOL)longPress{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
