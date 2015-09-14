//
//  UserCommentsTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UserCommentsTableViewController.h"
#import "UserCommentTableViewCell.h"
#import "Comment.h"

@interface UserCommentsTableViewController ()

@end

@implementation UserCommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
//    @property (strong, nonatomic) NSString *commentsId;
//    @property (strong, nonatomic) NSString *evidenceId;
//    @property (strong, nonatomic) NSString *descripcion;
//    @property (strong, nonatomic) NSString *date;
//    @property (strong, nonatomic) NSString *idAuthor;
    

    
    Comment * cast = [self.itemsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell;

    NSString * classNameStr = NSStringFromClass([UserCommentTableViewCell class]);
    UserCommentTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:classNameStr forIndexPath:indexPath];
    
    customCell.username.text = cast.idAuthor;

    UIImage * image = [UIImage imageNamed:@"user avatar placeholder"];
    [customCell.avatar setImage:image];
    cell = customCell;
    return cell;
}
@end
