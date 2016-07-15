//
//  CreateBoardController.h
//  MyTrello
//
//  Created by Ibrahima Dansokho on 15/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBoardController : UIViewController
- (IBAction)addBoard:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *boardName;
@property (weak, nonatomic) IBOutlet UILabel *boardLabel;

@end
