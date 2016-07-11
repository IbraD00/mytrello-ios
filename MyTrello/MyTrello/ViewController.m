//
//  ViewController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 11/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "ViewController.h"

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
    NSString * info = @"Hello world";
    _InfoAction.text = info;
    OAuthIOModal *oauthioModal = [[OAuthIOModal alloc] initWithKey:@"JLNwgM9ro0H5A_Q87qMmVzn4sY0" delegate:self];
    [oauthioModal showWithProvider:@"trello"];
}

- (void)didFailWithOAuthIOError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request {
    NSLog(@"%@", request.data.oauth_token);
//    NSDictionary *credentials = [request getCredentials];
    NSURL *url = [NSURL URLWithString:@"https://api.trello.com/1/members/ibrad00/boards?key=84f0517e4d81d7592f99c5170fc8ce0d"];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:boardRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (data.length > 0 && connectionError == nil)
        {
            NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@", responseData);
        }
    }];
    
    

}

- (void) didReceiveOAuthIOCode:(NSString *)code {}

- (void) didAuthenticateServerSide:(NSString *)body andResponse:(NSURLResponse *)response {}

- (void) didFailAuthenticationServerSide:(NSString *)body andResponse:(NSURLResponse *)response andError:(NSError *)error {}

@end
