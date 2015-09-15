//
//  SendChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/14/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SendChallengeViewController.h"
#import "SendChallengeCustomeTableViewCell.h"

#import "FriendList.h"

@interface SendChallengeViewController ()

@property (strong, nonatomic) NSArray * items;
@end

@implementation SendChallengeViewController
@synthesize items = _items;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    self.friendArray = [[NSMutableArray alloc ]init];
    
    [self setValuesToArray];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SendChallengeCustomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FriendsCell"];
    self.tableView.rowHeight = 110;
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)items
{
    if (!_items)
    {
        NSMutableArray * arr = [NSMutableArray arrayWithCapacity:20];
        for (NSInteger i=0; i<20; i++)
            [arr addObject:[NSString stringWithFormat:@"Item%ld", (long)i]];
        _items = arr;
    }
    return _items;
//    return self.friendArray;
}

-(void)setValuesToArray
{
    FbSingleton *fb = [FbSingleton sharedInstance];
    NSArray *friends = fb.friendsFbUser;
    
    for (int x=0; x<=friends.count; x++)
//    for (int x=0; x<=10; x++)
    {
        FriendList * friendElements = [[FriendList alloc]init];
        
        NSString * userIdString   = [NSString stringWithFormat:@"Friend userId %d", x];
        NSString * userNameString = [NSString stringWithFormat:@"Friend userName %d", x];
        NSString * imageURLString = [NSString stringWithFormat:@"Friend imageURL %d", x];
        
        friendElements.userId = userIdString;
        friendElements.userName = userNameString;
        friendElements.imageURL = imageURLString;
        
        [self.friendArray addObject:friendElements];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu", (unsigned long)[self.friendArray count]);
    return [self.friendArray count];
    
//    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewCell");
    SendChallengeCustomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"];
   
    [cell.selectFriendButton addTarget:self action:@selector(actionButton:) forControlEvents: UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SendChallengeCustomeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendList * newFriend = (FriendList *)[self.friendArray objectAtIndex:indexPath.row];\
    NSString * userName = newFriend.userName;
    
    NSLog(@"User Name %@", userName);
    cell.rightLabel.text = userName;
    
//    cell.rightLabel.text = [self.items objectAtIndex:indexPath.row];
}

-(void)actionButton:(id) sender
{
    NSLog(@"Buttons Cell Pressed From View Controller");
    NSLog(@"%@", sender);
}

@end
