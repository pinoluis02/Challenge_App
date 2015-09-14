//
//  ChallengesTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengesTableViewController.h"
#import "RegularItemTableViewCell.h"

@interface ChallengesTableViewController ()

@end

@implementation ChallengesTableViewController

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
    
    Challenge * item = [self.itemsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell;
        Challenge * cast = (Challenge *)item;
        RegularItemTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
        
        customCell.title.text = cast.title;
        customCell.challengeDescription.text = cast.descriptionItem;
        customCell.challengeDescription.numberOfLines = 5;
        customCell.author.text = cast.nameAuthor;
        customCell.pubDate.text = cast.creationDate;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cast.urlThumbnail]];
        UIImage * image = [UIImage imageWithData:imageData];
        [customCell.thumbnail setImage:image];
        cell = customCell;
    return cell;
}
@end
