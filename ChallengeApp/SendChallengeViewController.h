//
//  SendChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/14/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FbSingleton.h"

@interface SendChallengeViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray * friendArray;

@end
