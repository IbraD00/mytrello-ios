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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    OAuthIOModal *oauthioModal = [[OAuthIOModal alloc] initWithKey:@"JLNwgM9ro0H5A_Q87qMmVzn4sY0" delegate:self];
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    if ([oauthioModal cacheAvailableForProvider:@"trello"]) {
        NSLog(@"ya du cache");
    } else {
        [options setObject:@"true" forKey:@"cache"];
        [oauthioModal showWithProvider:@"trello" options:options];
    }
    
//    NSString *data = [options objectForKey:@"cache"];
//    NSLog(@"%@", data);
    
}

- (void)didFailWithOAuthIOError:(NSError *)error {
    NSLog(@"%@", error);
    NSString * info = @"Impossible de se connecter";
    _InfoAction.text = info;
}

- (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request {
//    BoardController* viewController = [[BoardController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) didReceiveOAuthIOCode:(NSString *)code {}

- (void) didAuthenticateServerSide:(NSString *)body andResponse:(NSURLResponse *)response {}

- (void) didFailAuthenticationServerSide:(NSString *)body andResponse:(NSURLResponse *)response andError:(NSError *)error {}

@end
