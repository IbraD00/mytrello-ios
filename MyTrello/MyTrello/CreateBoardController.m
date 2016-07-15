//
//  CreateBoardController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 15/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "CreateBoardController.h"

@interface CreateBoardController ()

@end

@implementation CreateBoardController {
    NSMutableArray *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBoard:(id)sender {
    
    NSLog(@"add boards %@", _boardName.text);
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    NSLog(@"%@", token);
    
    NSString *post = [NSString stringWithFormat:@"name=%@",_boardName.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *url = [NSString stringWithFormat: @"https://api.trello.com/1/boards?key=84f0517e4d81d7592f99c5170fc8ce0d&token=%@", token];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

// on receive
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)response{
    NSLog(@"success %@", response);
    NSError *error = nil;
    data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
    if (!data) {
        NSLog(@"Error when parsing json");
    } else {
        NSLog(@"%@", data);
    }
}

// on fail
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error %@", error);
}

// on finish
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
NSLog(@"conexxxx%@", connection);
}

@end
