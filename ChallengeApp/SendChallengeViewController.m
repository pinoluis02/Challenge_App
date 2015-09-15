//
//  SendChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/14/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SendChallengeViewController.h"
#import "SendChallengeCustomeTableViewCell.h"

#import "FBFriend.h"

@interface SendChallengeViewController ()
{
    NSMutableArray * checkedItems;
}
@end

@implementation SendChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.friendArray = [[NSMutableArray alloc ]init];
    
    [self setValuesToArray];

    NSString * classNameStr = NSStringFromClass([SendChallengeCustomeTableViewCell class]);
    UINib *cellNib = [UINib nibWithNibName:classNameStr bundle:nil];
    [self.tableView registerNib: cellNib forCellReuseIdentifier:classNameStr];
//    self.tableView.rowHeight = 110;
    
    checkedItems = [NSMutableArray array];
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setValuesToArray
{
    FbSingleton *fb = [FbSingleton sharedInstance];
    NSArray *friends = fb.friendsFbUser;
    
//    for (int x=0; x<=friends.count; x++)
    for (int x=0; x<=10; x++)
    {
        FBFriend * friendElement = [[FBFriend alloc]init];
        
        NSString * userIdString   = [NSString stringWithFormat:@"Friend userId %d", x];
        NSString * userNameString = [NSString stringWithFormat:@"Friend userName %d", x];
        NSString * imageURLString = @"http://epguides.com/HomeMovies/cast.jpg";
        
        friendElement.userId = userIdString;
        friendElement.userName = userNameString;
        friendElement.imageURL = imageURLString;
        
        [self.friendArray addObject:friendElement];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger c = [self.friendArray count];
    return c;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * classNameStr = NSStringFromClass([SendChallengeCustomeTableViewCell class]);
    SendChallengeCustomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:classNameStr];
    
    FBFriend * item = self.friendArray[indexPath.row];
    if(cell.setUpMark.hidden == false){
        [cell.checkButton addTarget:self action:@selector(selectFriendButton:) forControlEvents: UIControlEventTouchUpInside];
         cell.setUpMark.hidden = true;
    }
    
    cell.username.text = item.userName;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.imageURL]];
    UIImage * image = [UIImage imageWithData:imageData];
    cell.profilePicture.image = image;
    cell.checkButton.tag = indexPath.row;
    return cell;
}


- (void)selectFriendButton:(id)sender
{
    UIButton * btn = sender;
    btn.selected = !btn.isSelected;
    FBFriend * friend = self.friendArray[btn.tag];
    if ([btn isSelected])
    {
        [btn setImage:[UIImage imageNamed:@"RoundCheck"] forState:UIControlStateSelected];
        [checkedItems addObject:friend];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"RoundUnCheck"] forState:UIControlStateNormal];
        [checkedItems removeObject:friend];
    }
}


@end
