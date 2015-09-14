//
//  EvidencesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UserCommentsRootController.h"
#import "UserCommentsTableViewController.h"
#import "Comment.h"
#import "NSDate+Utils.h"

@interface UserCommentsRootController ()
{
    CGFloat mainViewHeight;
    UILongPressGestureRecognizer * mainViewLpgr;
    UIView * headerView;
}
@end

@implementation UserCommentsRootController



-(NSString *)nibName{
    return @"CustomRootController";
}


- (void)viewDidLoad {
    self.tableControllerClass = [UserCommentsTableViewController class];
    self.nextRootControllerClass = nil;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData:self.selectedItem];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)setDemoData{
    
    
//    @property (strong, nonatomic) NSString *commentsId;
//    @property (strong, nonatomic) NSString *evidenceId;
//    @property (strong, nonatomic) NSString *descripcion;
//    @property (strong, nonatomic) NSString *date;
//    @property (strong, nonatomic) NSString *idAuthor;

    Comment * itemOne = [Comment new];
    itemOne.commentsId = @"1";
    itemOne.evidenceId = @"1";
    itemOne.descripcion = @"lorem ipsum";
    itemOne.date = [[NSDate date] shortFormattedDateString];
    itemOne.idAuthor = @"1";
    
    Comment * itemTwo = [Comment new];
    itemTwo.commentsId = @"1";
    itemTwo.evidenceId = @"1";
    itemTwo.descripcion = @"lorem ipsum";
    itemTwo.date = [[NSDate date] shortFormattedDateString];
    itemTwo.idAuthor = @"1";
    
    NSArray * resultsArray = @[itemOne, itemTwo];
    
    self.tableContentController.itemsArray = resultsArray;
}

@end
