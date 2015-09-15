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

    {
        FBFriend * friendElement1 = [[FBFriend alloc]init];
        FBFriend * friendElement2 = [[FBFriend alloc]init];
        FBFriend * friendElement3 = [[FBFriend alloc]init];
        
        NSString * userIdString1   = [NSString stringWithFormat:@"10153024391815009"];
        NSString * userNameString1 = [NSString stringWithFormat:@"Erick Yusse Quintanar Torres"];
        NSString * imageURLString1 = [NSString stringWithFormat:@"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xap1/v/t1.0-1/p50x50/11947591_10153016992365009_3578098696050035424_n.jpg?oh=9d561f203d069b28651bafffa8e16a0a&oe=566E8BA6&__gda__=1453666211_9854981092b59b504629ece519abe953"];
        
        friendElement1.userId = userIdString1;
        friendElement1.userName = userNameString1;
        friendElement1.imageURL = imageURLString1;
        
        NSString * userIdString2   = [NSString stringWithFormat:@"10204900023689177"];
        NSString * userNameString2 = [NSString stringWithFormat:@"Nivardo Ibarra"];
        NSString * imageURLString2 = [NSString stringWithFormat:@"https://scontent.xx.fbcdn.net/hprofile-xaf1/v/t1.0-1/p50x50/10557251_10203736916812232_811988566299822853_n.jpg?oh=6ea1b1e7fcbed0a458b7feecfa222352&oe=56656C27"];
                                                                  
        friendElement2.userId = userIdString2;
        friendElement2.userName = userNameString2;
        friendElement2.imageURL = imageURLString2;
                                     
        NSString * userIdString3   = [NSString stringWithFormat:@"880773571990870"];
        NSString * userNameString3 = [NSString stringWithFormat:@"Ricardo Oter"];
        NSString * imageURLString3 = [NSString stringWithFormat:@"https://scontent.xx.fbcdn.net/hprofile-xpa1/v/t1.0-1/c197.45.566.566/s50x50/74927_426635537404678_1634161185_n.jpg?oh=ebb7cc0a942fa33e1bfe20ba04cdb365&oe=56A64A93"];
                                                                                               
        friendElement3.userId = userIdString3;
        friendElement3.userName = userNameString3;
        friendElement3.imageURL = imageURLString3;
                                     
        [self.friendArray addObject:friendElement1];
        [self.friendArray addObject:friendElement2];
        [self.friendArray addObject:friendElement3];
        
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
    
    NSURL *url = [NSURL URLWithString: newFriend.imageURL];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    cell.userURLimageView = [[UIImageView alloc] initWithImage:image];
    
//    cell.rightLabel.text = [self.items objectAtIndex:indexPath.row];
}

-(void)actionButton:(id) sender
{
    NSLog(@"Buttons Cell Pressed From View Controller");
    NSLog(@"%@", sender);
}

@end
