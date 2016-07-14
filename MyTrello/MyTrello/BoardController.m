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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init table data
    tableData = [NSMutableArray array];
    NSString *token = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"token"];
    NSLog(@"%@", token);
//    NSString *token = @"36ba4056078a105b2b556f64607c91d546cd87e8f0f34a43e8bdd2c9de66afcb"; //request.data.oauth_token;
    NSString *baseUrl = @"https://api.trello.com/1/members/me/boards?key=84f0517e4d81d7592f99c5170fc8ce0d&token=";
    NSString *append_url = [baseUrl stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString: append_url];
    NSURLRequest *boardRequest = [NSURLRequest requestWithURL:url];
    NSHTTPURLResponse *responseCode = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:boardRequest returningResponse:&responseCode error:nil];
    NSMutableArray *data;
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting HTTP status code %li", (long)[responseCode statusCode]);
    } else {
        NSError *error = nil;
        data = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
        if (!data) {
            NSLog(@"Error");
        } else {
            for(NSDictionary *item in data) {
                [tableData addObject:[item objectForKey:@"name"]];
            }
        }
    }
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