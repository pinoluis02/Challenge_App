//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeTableViewController.h"
#import "RegularItemTableViewCell.h"

@interface ChallengeTableViewController (){
    NSMutableDictionary * items;
ChallengeTableViewControllerContent mContentType;
}
@end

@implementation ChallengeTableViewController


-(ChallengeTableViewControllerContent)contentType{
    return mContentType;
}

-(void)setContentType:(ChallengeTableViewControllerContent)contentType{
    mContentType = contentType;
    NSDictionary * dic = [self getDemoObjects:contentType];
    items = dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
       UINib *cellNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
        [self.tableView registerNib: cellNib forCellReuseIdentifier:@"RegularItemTableViewCell"];
    self.tableView.rowHeight = 310;
}

-(NSDictionary *) getDemoObjects:(ChallengeTableViewControllerContent)contentType{

    NSMutableDictionary * master = [NSMutableDictionary new];
    NSMutableDictionary * itemOne = [NSMutableDictionary new];
    NSMutableDictionary * itemTwo = [NSMutableDictionary new];
    
    NSString * resultType;
    
    
    //    I need also challenge status with respect to the user
    //    suggestion: rename url for thumbnail
    //    If user can donate but rejects he doesn't get to save the donation prove (challenge)
    
    switch (contentType) {
        case AllChallenges:{
            resultType = @"didFinishGetAllChallengesWithResult_";
        }break;
        case PopularChallenges:{
            resultType = @"GetMostViewedChallenges";
        }break;
        case RecentChallenges:{
            resultType = @"GetRecentsChallenges";
        }break;
        case SearchChallenges:{
            resultType = @"_pending_search";
        }break;
        case UserChallengeInvitation:{
            resultType = @"didFinishGetChallengeRequestsWithResult_";
        }break;
        case UserCompleteChallenges:{
            resultType = @"didFinishGetChallengeCompleteWithResult_";
        }break;
        case UserIncompleteChallenges:{
            resultType = @"didFinishGetChallengeIncompletesWithResult_";
        }break;
        default:
            NSAssert(false, @"some programmer error");
    }
    
    NSArray * challenges_arr = [[NSArray alloc] initWithObjects:itemOne, itemTwo, nil];
    [master setValue:resultType forKey:@"resultType"];
    [master setValue:challenges_arr forKey:@"challenges"];
    
    [itemOne setValue:@1 forKey:@"id"];
    [itemOne setValue:@"mauris, rhoncus id," forKey:@"title"];
    [itemOne setValue:@"Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet" forKey:@"description"];
    [itemOne setValue:@"image" forKey:@"type"];
    [itemOne setValue:@"http://i.blogs.es/e61022/bit-0-1/650_1200.jpg" forKey:@"url"];
    
    [itemTwo setValue:@1 forKey:@"id"];
    [itemTwo setValue:@"mauris, rhoncus id," forKey:@"title"];
    [itemTwo setValue:@"Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet" forKey:@"description"];
    [itemTwo setValue:@"image" forKey:@"type"];
    [itemTwo setValue:@"http://i.blogs.es/e61022/bit-0-1/650_1200.jpg" forKey:@"url"];

    [self.tableView reloadData];
    return master;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    return [[items valueForKey:@"challenges"] count];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegularItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
    
    NSDictionary * item = [items valueForKey:@"challenges"][indexPath.row];
    cell.title = [item objectForKey:@"title"];
    cell.challengeDescription = [item objectForKey:@"description"];
    cell.author.text = @"UserXXII";
    cell.pubDate.text = [NSString stringWithFormat:@"%@", [NSDate date]];
    UIImage * image = [UIImage imageNamed:@"homemovies"];
    [cell.thumbnail setImage:image];
    return cell;
}



@end
