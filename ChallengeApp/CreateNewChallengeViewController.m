//
//  CreateNewChallengeViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/6/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "CreateNewChallengeViewController.h"
//#import "CreateNewChallengeView.h"

//#define trace_misleading_documentation

NSString * customCharityOrganizationOptionString = @"Other";
@interface CreateNewChallengeViewController ()
{
//    CreateNewChallengeView * newChallengeView;
    NSArray * charityOrganizations;
}
@end



@implementation CreateNewChallengeViewController


-(void)awakeFromNib{
//    IBOutlets guaranteed to be set up to this point, according to documentation at least, this variables are nil here but the're not in viewDidLoad. or maybe the documentation behaviour is only for MacOSX.
#ifdef trace_misleading_documentation
    NSLog(@"CreateNewChallengeViewController.awakeFromNib) picker is: %@", self.pickerCharityOrganization);
        NSLog(@"CreateNewChallengeViewController.awakeFromNib) btnDonate is: %@", self.btnDonate);
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    newChallengeView = (CreateNewChallengeView *)self.view;
//            NSLog(@"viewDidLoad %@", self.view);
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"Red cross", @"Magdelai organization", @"World children care", @"Human rights protection association", @"UNICEF", customCharityOrganizationOptionString, nil];
    charityOrganizations = arr;
#ifdef trace_misleading_documentation
    NSLog(@"CreateNewChallengeViewController.viewDidLoad) picker is: %@", self.pickerCharityOrganization);
    NSLog(@"CreateNewChallengeViewController.viewDidLoad) btnDonate is: %@", self.btnDonate);
#endif


    self.pickerCharityOrganization.delegate = self;
    self.pickerCharityOrganization.dataSource = self;
    
    UIButton * chkBtn = self.btnDonate;
    [chkBtn setSelected:YES];
    [chkBtn setImage: [UIImage imageNamed:@"checkbox_unchecked"]
            forState:UIControlStateNormal];
    [chkBtn setImage:[UIImage imageNamed:@"checkbox_checked"]
            forState:UIControlStateSelected];
    
    [self performSegueWithIdentifier:@"NewChallengeSegue" sender:self];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//<begin> UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    NSInteger result;
    result = [charityOrganizations count];
    return result;
    
}


//<end> datasource methods

//<begin> delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSString * result;
    result = charityOrganizations[row];
    return result;
}


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if([charityOrganizations[row] isEqualToString:customCharityOrganizationOptionString]){
        self.inputPaypalID.enabled = true;
        self.inputPaypalID.text = @"";
    }
    else{
        self.inputPaypalID.enabled = false;
        self.inputPaypalID.text = @"00-000-00-0000";
    }
}

//<end> delegate methods

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)donateButtonClick:(id)sender {
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
}
@end
