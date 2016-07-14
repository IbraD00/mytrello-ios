//
//  CardController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 14/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "CardController.h"

@interface CardController ()

@end

@implementation CardController {
    NSMutableArray *tableData;
    NSMutableDictionary *cards;
    NSMutableArray *data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init table data
    tableData = [NSMutableArray array];
    cards = [NSMutableDictionary dictionary];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    NSLog(@"%@", token);
    //    NSString *token = @"36ba4056078a105b2b556f64607c91d546cd87e8f0f34a43e8bdd2c9de66afcb"; //request.data.oauth_token;
    //    NSString *baseUrl = @"https://api.trello.com//1/boards/%@/cards?key=84f0517e4d81d7592f99c5170fc8ce0d&token=";
    NSString *baseUrl = [NSString stringWithFormat: @"https://api.trello.com/1/lists/%@/cards/?key=84f0517e4d81d7592f99c5170fc8ce0d&token=", _list_id];
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
            for(NSDictionary *item in data) {
                [cards setObject:[item objectForKey:@"id"]  forKey:[item objectForKey:@"name"]];
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
    
    NSLog(@"%@", cellText);
    NSLog(@"%@", [cards objectForKey:cellText]);
    
    //    ListController * viewController = [[ListController alloc] init];
    //    [viewController setBoard_id:[boards objectForKey:cellText]];
    //    [self.navigationController pushViewController:viewController animated:YES];
    
    
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

@end