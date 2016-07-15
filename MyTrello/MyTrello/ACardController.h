//
//  ACardController.h
//  MyTrello
//
//  Created by Ibrahima Dansokho on 15/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACardController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (nonatomic) NSString *card_id;
@property (weak, nonatomic) IBOutlet UITextView *members;
@property (weak, nonatomic) IBOutlet UITextView *labels;

@end
