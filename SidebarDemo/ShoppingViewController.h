//
//  ShoppingViewController.h
//  Farm Fresh Simcoe
//
//  Created by STEWART EMERSON G. on 2014-04-10.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingViewController :UITableViewController <UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
- (IBAction)savebtn:(id)sender;
@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (weak, nonatomic) IBOutlet UITextField *item;
@property (strong,nonatomic) NSNumber *selectedLat;
@property (strong,nonatomic) NSNumber *selectedLong;
@property (strong,nonatomic) NSString *detailFarm;
@property (strong, nonatomic) NSString *listObjectId;

@end
