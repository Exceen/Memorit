//
//  MemoritViewController.h
//  Memorit
//
//  Created by Exceen on 03/04/2014.
//  Copyright (c) 2014 Exceen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoritGame.h"


@interface MemoritViewController : UIViewController {
    MemoritGame *memoritGame;
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highscoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;

@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)startStop:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)info:(id)sender;

@end
