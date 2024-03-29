//
//  ViewController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 11/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "ViewController.h"
#import "BoardController.h"

@interface ViewController ()

@property OAuthIORequest *request_object;

@end

@implementation ViewController : UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    OAuthIOModal *oauthioModal = [[OAuthIOModal alloc] initWithKey:@"JLNwgM9ro0H5A_Q87qMmVzn4sY0" delegate:self];
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    if (token) {
        [self performSegueWithIdentifier:@"BoardController" sender:self];
    } else {
        [oauthioModal showWithProvider:@"trello"];
    }
}

- (void)didFailWithOAuthIOError:(NSError *)error {
    NSLog(@"%@", error);
    _InfoAction.text = @"Impossible de se connecter";
}

- (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request {
    NSString *valueToSave = request.data.oauth_token;
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"BoardController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[BoardController class]]) {
    }
}

- (void) didReceiveOAuthIOCode:(NSString *)code {}

- (void) didAuthenticateServerSide:(NSString *)body andResponse:(NSURLResponse *)response {}

- (void) didFailAuthenticationServerSide:(NSString *)body andResponse:(NSURLResponse *)response andError:(NSError *)error {}

@end
