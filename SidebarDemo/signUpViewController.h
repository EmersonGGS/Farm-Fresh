//
//  signUpViewController.h
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface signUpViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;
- (IBAction)signup:(id)sender;
- (IBAction)backbtn:(id)sender;

@end
