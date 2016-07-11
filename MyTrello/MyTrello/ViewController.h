//
//  ViewController.h
//  MyTrello
//
//  Created by Ibrahima Dansokho on 11/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OAUthiOS/OAuthiOS.h>

@interface ViewController : UIViewController<OAuthIODelegate>

// Handles the results of a successful authentication
- (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request;

// Handle errors in the case of an unsuccessful authentication
- (void)didFailWithOAuthIOError:(NSError *)error;

@property (weak, nonatomic) IBOutlet UILabel *InfoAction;
- (IBAction)loginAction:(id)sender;

@end

