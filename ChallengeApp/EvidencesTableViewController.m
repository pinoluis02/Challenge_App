//
//  EvidencesTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "EvidencesTableViewController.h"
#import "EvidenceTableViewCellCompact.h"

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

    
    Evidence * cast = [self.itemsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell;
    NSString * classNameStr = NSStringFromClass([EvidenceTableViewCellCompact class]);
    EvidenceTableViewCellCompact *customCell = [tableView dequeueReusableCellWithIdentifier:classNameStr forIndexPath:indexPath];
        
    
        customCell.evidenceDescription.text = cast.descriptionEvidence;
        customCell.authorUsername.text = cast.userName;
        customCell.creationDate.text = cast.created_at;
        UIImage * image = [UIImage imageNamed:@"missing"];
        if(![cast.imageUrl isKindOfClass:[NSNull class]]){
            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cast.imageUrl]];
            image = [UIImage imageWithData:imageData];
        }
        [customCell.thumbnail setImage:image];
        cell = customCell;
   
    return cell;
}

@end
