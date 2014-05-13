//
//  MemoritGame.h
//  Memorit
//
//  Created by Exceen on 03/04/2014.
//  Copyright (c) 2014 Exceen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MemoritGame : NSObject {
    NSMutableArray *currentSequence;
    NSUInteger playerIndex;
    NSUInteger score;
    BOOL gameOver;
    BOOL idle;
    
    UILabel *scoreLabel;
    UILabel *highscoreLabel;
    
    UIButton *greenButton;
    UIButton *redButton;
    UIButton *yellowButton;
    UIButton *blueButton;
    
    UIImageView *backgroundImageView;
}

@property (strong, nonatomic) NSMutableArray *audioPlayers;

- (id)initWithScoreLabel:(UILabel *)sl highScoreLabel:(UILabel *)hsl greenButton:(UIButton *)gb redButton:(UIButton *)rb yellowButton:(UIButton *)yb blueButton:(UIButton *)bb backgroundImageView:(UIImageView *)biv;

- (void)startNewGame;
- (void)forceGameOver;

- (void)buttonPressed:(id)sender;
- (void)resetHighscore;
- (BOOL)isRunning;

@end
