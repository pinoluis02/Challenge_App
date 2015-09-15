//
//  MakeDonationViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MakeDonationViewController.h"

NSString * customCharityOrganizationOptionString = @"Other";
@interface MakeDonationViewController ()
{
    //    CreateNewChallengeView * newChallengeView;
    NSArray * charityOrganizations;
}

@end

@implementation MakeDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"Red cross", @"Magdelai organization", @"World children care", @"Human rights protection association", @"UNICEF", customCharityOrganizationOptionString, nil];
    charityOrganizations = arr;
    
    self.pickerCharityOrganization.delegate = self;
    self.pickerCharityOrganization.dataSource = self;
    
    self.inputAmount.delegate = self;
    self.inputAmount.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputPaypalId.enabled = false;
    
    NSInteger initialRow = 0;
    [self pickerView:self.pickerCharityOrganization didSelectRow:initialRow inComponent:0];
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
    NSString * fakePaypalId = [[NSString alloc] initWithFormat:@"00-000-00-000%ld", (long)row];
    self.inputPaypalId.text = fakePaypalId;
    self.organizationName = [self pickerView:self.pickerCharityOrganization titleForRow:row forComponent:0];
}

//http://hugolarcher.com/uitextfield-allowing-only-decimal-characters/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    
    // allow backspace
    if (range.length > 0 && [string length] == 0) {
        return YES;
    }
    // do not allow . at the beggining
    if (range.location == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    // set the text field value manually
    NSString *newValue = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    newValue = [[newValue componentsSeparatedByCharactersInSet:nonNumberSet] componentsJoinedByString:@""];
    textField.text = newValue;
    // return NO because we're manually setting the value
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) btnAcceptClicked:(id)sender{
    if(!self.inputAmount.text){
    self.inputAmount.text = @"0.00";
    }
    NSString * unwindSegueIdentifier = @"unwindFromMakeDonation";
    [self performSegueWithIdentifier:unwindSegueIdentifier sender:self];
}
@end
