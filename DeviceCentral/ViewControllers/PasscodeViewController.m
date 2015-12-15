//
//  PasscodeViewController.m
//  DeviceCentral
//
//  Created by Janice Garingo on 10/29/13.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "PasscodeViewController.h"
#import "WelcomeViewController.h"

@interface PasscodeViewController ()

@property (nonatomic) NSArray *textFieldArray;

@end

@implementation PasscodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldArray = [NSArray arrayWithObjects:self.passcodeTextField1, self.passcodeTextField2, self.passcodeTextField3, self.passcodeTextField4, nil];
    
    for(UITextField *textField in self.textFieldArray)
    {
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}


- (IBAction)skipButtonDidSelect:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)savePasscode
{
    NSString *passcode = [NSString stringWithFormat:@"%@%@%@%@", self.passcodeTextField1.text, self.passcodeTextField2.text, self.passcodeTextField3.text, self.passcodeTextField4.text];
    [Admin savePasscode:passcode];
}


# pragma mark - UITextField delegate methods
-(void)textFieldDidChange:(UITextField*)textField
{
    NSUInteger currentIndex = textField.tag - 1;
  
    if(currentIndex < (self.textFieldArray.count-1) )
    {
        for(UITextField *textField in self.textFieldArray)
        {
            UITextField *nextTextField = self.textFieldArray[currentIndex + 1];
            [nextTextField becomeFirstResponder];
        }
    }
    
    
    if(textField == self.passcodeTextField4)
    {
        if( (self.passcodeTextField1.text.length > 0) && (self.passcodeTextField2.text.length > 0) && (self.passcodeTextField3.text.length > 0) && (self.passcodeTextField4.text.length > 0) )
        {
            [self savePasscode];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    // Limit input to numbers only
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    // Limit textfields to one character only
    return (newLength > 1) ? NO : YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
