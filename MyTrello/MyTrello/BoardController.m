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

@implementation BoardController : UITableViewController {
    NSArray *tableData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    
    NSString *token = @"36ba4056078a105b2b556f64607c91d546cd87e8f0f34a43e8bdd2c9de66afcb"; //request.data.oauth_token;
    NSString *baseUrl = @"https://api.trello.com/1/members/me/boards?key=84f0517e4d81d7592f99c5170fc8ce0d&token=";
    NSString *append_url = [baseUrl stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString: append_url];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:boardRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSError *e = nil;
             NSArray *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             if (!responseData) {
                 NSLog(@"Error parsing JSON: %@", e);
             } else {
                 for(NSDictionary *item in responseData) {
                     NSLog(@"Item: %@", [item objectForKey:@"name"]);
                     tableData = [NSArray arrayWithObjects:[item objectForKey:@"name"], nil];
                 }
                 
             }
             
             // NSLog(@"%@", responseData);
         }
     }];
    tableData = [NSArray arrayWithObjects: @"hello", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

@end