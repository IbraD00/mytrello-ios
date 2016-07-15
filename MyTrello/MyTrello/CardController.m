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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
//    cell.backgroundColor = [UIColor orangeColor];
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
//    cell.textLabel.textColor = [UIColor orangeColor];
//    cell.detailTextLabel.text = @"Red, White";
    return cell;
}

@end