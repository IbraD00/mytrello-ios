//
//  ViewController.m
//  MyTrello
//
//  Created by Ibrahima Dansokho on 11/07/2016.
//  Copyright © 2016 Ibrahima Dansokho. All rights reserved.
//

#import "ViewController.h"
#import <OAuthiOS/OAuthiOS.h>

@interface ViewController ()

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


@end
