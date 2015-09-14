//
//  EvidencesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "EvidencesRootController.h"
#import "UserCommentsRootController.h"
#import "ChallengeTableViewCellCompact.h"
#import "NSDate+Utils.h"

@interface EvidencesRootController ()
{

}
@end

@implementation EvidencesRootController



- (void)viewDidLoad {
    self.tableControllerClass = [EvidencesTableViewController class];
    self.nextRootControllerClass = [UserCommentsRootController class];
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

-(UIView*)createTableHeaderView: (id)object{
    return [MasterRootController createTableHeaderViewForChallenge:object];
    
}



-(void)setDemoData{
    
    
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
    
    self.tableContentController.itemsArray = resultsArray;
}

@end
