//
//  InfoViewController.m
//  Memorit
//
//  Created by Exceen on 03/04/2014.
//  Copyright (c) 2014 Exceen. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infoText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [infoText setText:@"THIS IS CREDITS U FEGITS\r\rExceen\roOLisaborgOo"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
