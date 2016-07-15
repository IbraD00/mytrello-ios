//
//  ListController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 14/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "ListController.h"

@interface ListController ()

@end

@implementation ListController {
    NSMutableArray *tableData;
    NSMutableDictionary *lists;
    NSMutableArray *data;
    NSString *list_id;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init table data
    tableData = [NSMutableArray array];
    lists = [NSMutableDictionary dictionary];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]
                       stringForKey:@"token"];
    NSLog(@"%@", token);
    NSString *baseUrl = [NSString stringWithFormat: @"https://api.trello.com/1/boards/%@/lists?key=84f0517e4d81d7592f99c5170fc8ce0d&token=", _board_id];
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
                [lists setObject:[item objectForKey:@"id"]  forKey:[item objectForKey:@"name"]];
                [tableData addObject:[item objectForKey:@"name"]];
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CardController class]]) {
        [(CardController *)segue.destinationViewController setList_id:list_id];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    list_id = [lists objectForKey:cellText];
    [self performSegueWithIdentifier:@"CardController" sender:self];
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
