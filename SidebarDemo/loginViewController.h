//
//  loginViewController.h
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)login:(id)sender;


@end
