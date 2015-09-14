//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "CustomTableViewController.h"
#import "RegularItemTableViewCell.h"
#import "ChallengeEvidenceTableViewCell.h"
#import "Challenge.h"
#import "ChallengesRootController.h"

@interface CustomTableViewController (){
    NSDictionary * items;    
    UILongPressGestureRecognizer * lpgr;
    NSArray * mItemsArray;
}
@end

@implementation CustomTableViewController


-(NSArray*)itemsArray{
    return mItemsArray;
}

-(void)setItemsArray:(NSArray *) arr{
    mItemsArray = arr;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
       UINib *cellNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
        [self.tableView registerNib: cellNib forCellReuseIdentifier:@"RegularItemTableViewCell"];
//    self.tableView.rowHeight = 255;
    UINib *evidenceCellNib = [UINib nibWithNibName:@"ChallengeEvidenceTableViewCell" bundle:nil];
    [self.tableView registerNib: evidenceCellNib forCellReuseIdentifier:@"ChallengeEvidenceTableViewCell"];
    
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
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
    //return [[items valueForKey:@"challenges"] count];
    NSInteger count = [self.itemsArray count];
    return count;
//    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Challenge * item = [self.itemsArray objectAtIndex:indexPath.row];
    UITableViewCell * cell;
    if([item class] == [Challenge class]){
        Challenge * cast = (Challenge *)item;
        RegularItemTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
        
        customCell.title.text = cast.title;
        customCell.challengeDescription.text = cast.descriptionItem;
        customCell.author.text = cast.nameAuthor;
        customCell.pubDate.text = cast.creationDate;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cast.urlThumbnail]];
        UIImage * image = [UIImage imageWithData:imageData];
        [customCell.thumbnail setImage:image];
        cell = customCell;
    }
    
    else if([item class] == [Evidence class]){
        ChallengeEvidenceTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeEvidenceTableViewCell" forIndexPath:indexPath];
        Evidence * cast = (Evidence *)item;
        customCell.evidenceDescription.text = @"Lorem Ipsum lalalallalala";
        customCell.authorUsername.text = @"Nivardo's";
        customCell.creationDate.text = cast.created_at;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:cast.imageUrl]];
        UIImage * image = [UIImage imageWithData:imageData];
        [customCell.thumbnail setImage:image];
        cell = customCell;
    }
    else{
        NSAssert(NO, @"programmer you made a mistake");
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Challenge *item = self.itemsArray[indexPath.row];
    [self notifyCoordinatorOfItemSelection:item longPress:NO];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            return;
        } else {
            id item = self.itemsArray[indexPath.row];
            [self notifyCoordinatorOfItemSelection:item longPress:YES];
        }
    }
}

-(void)notifyCoordinatorOfItemSelection: (id)item longPress:(BOOL)lp{
    [self.coordinatorController coordinateTableItemSelection:item selectedByLongPress:lp];
//    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
//    NSAssert(NO, msg);
}


@end
