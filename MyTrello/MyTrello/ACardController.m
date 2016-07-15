//
//  ACardController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 15/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "ACardController.h"

@interface ACardController ()

@end

@implementation ACardController {
    NSDictionary *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // init table data
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    NSLog(@"%@", token);
    NSString *baseUrl = [NSString stringWithFormat: @"https://api.trello.com/1/card/%@/?key=84f0517e4d81d7592f99c5170fc8ce0d&token=", _card_id];
    NSString *append_url = [baseUrl stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString: append_url];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *responseCode = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:boardRequest returningResponse:&responseCode error:nil];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting HTTP status code %li", (long)[responseCode statusCode]);
    } else {
        NSError *error = nil;
        data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if (!data) {
            NSLog(@"Error");
        } else {
            NSLog(@"%@", [data objectForKey:@"name"]);
            _name.text = [data objectForKey:@"name"];
            if([data objectForKey:@"closed"] == false)
                _state.text = @"Fermé";
            _state.text = @"Ouvert";
        }
    }
    [self getCardMembers];
}

- (void) getCardMembers {
    
    // init table data
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    NSLog(@"%@", token);
    NSString *baseUrl = [NSString stringWithFormat: @"https://api.trello.com/1/cards/%@/members?key=84f0517e4d81d7592f99c5170fc8ce0d&token=", _card_id];
    NSString *append_url = [baseUrl stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString: append_url];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *responseCode = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:boardRequest returningResponse:&responseCode error:nil];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting HTTP status code %li", (long)[responseCode statusCode]);
    } else {
        NSError *error = nil;
        data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if (!data) {
            NSLog(@"Error");
        } else {
            
            for (NSDictionary *item in data) {
                NSString *tmp = [NSString stringWithFormat: @"%@, ", [item objectForKey:@"fullName"]];
                _members.text = [NSString stringWithFormat: @"%@%@", _members.text, tmp];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
