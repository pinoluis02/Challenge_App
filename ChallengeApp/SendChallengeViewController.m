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

    NSString * classNameStr = NSStringFromClass([SendChallengeCustomeTableViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:classNameStr bundle:nil] forCellReuseIdentifier:classNameStr];
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
    
//    for (int x=0; x<=friends.count; x++)
    for (int x=0; x<=10; x++)
    {
        FBFriend * friendElement = [[FBFriend alloc]init];
        
        NSString * userIdString   = [NSString stringWithFormat:@"Friend userId %d", x];
        NSString * userNameString = [NSString stringWithFormat:@"Friend userName %d", x];
        NSString * imageURLString = [NSString stringWithFormat:@"Friend imageURL %d", x];
        
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
   
    [cell.selectFriendButton addTarget:self action:@selector(actionButton:) forControlEvents: UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SendChallengeCustomeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FBFriend * newFriend = (FBFriend *)[self.friendArray objectAtIndex:indexPath.row];
    NSString * userName = newFriend.userName;
    cell.rightLabel.text = userName;
//    cell.rightLabel.text = [self.items objectAtIndex:indexPath.row];
}

-(void)actionButton:(id) sender
{
    NSLog(@"Buttons Cell Pressed From View Controller");
    NSLog(@"%@", sender);
}

@end
