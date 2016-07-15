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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

// This method is used to receive the data which we get using post method.
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

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error %@", error);
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
NSLog(@"conexxxx%@", connection);
}

@end
