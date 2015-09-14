//
//  EvidencesTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "EvidencesTableViewController.h"
#import "ChallengeEvidenceTableViewCell.h"

@interface EvidencesTableViewController ()

@end

@implementation EvidencesTableViewController

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
        NSString * loremLipsum = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
        
        
        ChallengeEvidenceTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeEvidenceTableViewCell" forIndexPath:indexPath];
        Evidence * cast = (Evidence *)item;
        customCell.evidenceDescription.text = loremLipsum;
        customCell.authorUsername.text = @"Nivardo's";
        customCell.creationDate.text = cast.created_at;
        UIImage * image = nil;
        if(![cast.imageUrl isKindOfClass:[NSNull class]]){
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cast.imageUrl]];
            image = [UIImage imageWithData:imageData];
        }
        [customCell.thumbnail setImage:image];
        cell = customCell;
   
    return cell;
}

@end
