//
//  MemoritViewController.m
//  Memorit
//
//  Created by Exceen on 03/04/2014.
//  Copyright (c) 2014 Exceen. All rights reserved.
//

#import "MemoritViewController.h"
#import "InfoViewController.h"

@interface MemoritViewController ()

@end

@implementation MemoritViewController

@synthesize scoreLabel;
@synthesize highscoreLabel;

@synthesize greenButton;
@synthesize redButton;
@synthesize yellowButton;
@synthesize blueButton;

@synthesize startStopButton;

@synthesize backgroundImageView;


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
    
    memoritGame = [[MemoritGame alloc] initWithScoreLabel:scoreLabel highScoreLabel:highscoreLabel greenButton:greenButton redButton:redButton yellowButton:yellowButton blueButton:blueButton backgroundImageView:backgroundImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    [memoritGame buttonPressed:sender];
    
    if (![memoritGame isRunning]) {
        [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)startStop:(id)sender
{
    if ([[startStopButton currentTitle] isEqualToString:@"Start"]) {
        [startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        [memoritGame startNewGame];
        
    } else if ([[startStopButton currentTitle] isEqualToString:@"Stop"]) {
        [startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        
        [memoritGame forceGameOver];
    }
}

- (IBAction)reset:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset highscore?" message:@"Are you sure you want to reset your highscore?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
        [memoritGame resetHighscore];
	}
}

- (IBAction)info:(id)sender
{
    InfoViewController *infoViewcontroller = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    [self presentViewController:infoViewcontroller animated:YES completion:nil];
}


@end
