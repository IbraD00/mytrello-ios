//
//  BoardController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 12/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "BoardController.h"

@interface BoardController ()

@end

@implementation BoardController {
    NSMutableArray *tableData;
    NSMutableDictionary *boards;
    NSMutableArray *data;
    NSString *board_id;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init table data
    tableData = [NSMutableArray array];
    boards = [NSMutableDictionary dictionary];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"token"];
    NSString *baseUrl = @"https://api.trello.com/1/members/me/boards?key=84f0517e4d81d7592f99c5170fc8ce0d&token=";
    NSString *append_url = [baseUrl stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString: append_url];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *responseCode = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:boardRequest returningResponse:&responseCode error:nil];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error HTTP %li", (long)[responseCode statusCode]);
    } else {
        NSError *error = nil;
        data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if (!data) {
            NSLog(@"Error");
        } else {
            for(NSDictionary *item in data) {
                [boards setObject:[item objectForKey:@"id"]  forKey:[item objectForKey:@"name"]];
                [tableData addObject:[item objectForKey:@"name"]];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    board_id = [boards objectForKey:cellText];
    [self performSegueWithIdentifier:@"ListController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ListController class]]) {
        [(ListController *)segue.destinationViewController setBoard_id:board_id];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)AddBoard:(id)sender {
//    NSString *post = [NSString stringWithFormat:@"Username=%@&Password=%@",@"username",@"password"];
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"http://www.abcde.com/xyz/login.aspx"]];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if(conn) {
//        NSLog(@"Connection Successful");
//    } else {
//        NSLog(@"Connection could not be made");
//    }
}

- (IBAction)decoAction:(id)sender {
    NSLog(@"LOGOUT");
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSString *token = [[NSUserDefaults standardUserDefaults]
//                       stringForKey:@"token"];
//    NSLog(@"%@", token);
////    [self performSegueWithIdentifier:@"MainController" sender:self];
    
    // for token
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    // URLrequests
    NSURLCache *sharedCache = [NSURLCache sharedURLCache];
    [sharedCache removeAllCachedResponses];
    
    // Also delete all stored cookies!
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookies];
    id cookie;
    for (cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    
    [self.navigationController popToRootViewControllerAnimated:true];
    
}
@end