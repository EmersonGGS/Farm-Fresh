//
//  ShoppingViewController.h
//  Farm Fresh
//
//  Created by Emerson on 28/6/13.
//  Copyright (c) 2014 Emerson Stewart & Elicia Durtnall. All rights reserved.
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
