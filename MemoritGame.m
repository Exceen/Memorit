//
//  MemoritGame.m
//  Memorit
//
//  Created by Exceen on 03/04/2014.
//  Copyright (c) 2014 Exceen. All rights reserved.
//

// deactive buttons while new sequence is played

#import "MemoritGame.h"

@implementation MemoritGame

@synthesize audioPlayers;

- (id)initWithScoreLabel:(UILabel *)sl highScoreLabel:(UILabel *)hsl greenButton:(UIButton *)gb redButton:(UIButton *)rb yellowButton:(UIButton *)yb blueButton:(UIButton *)bb backgroundImageView:(UIImageView *)biv
{
    scoreLabel = sl;
    highscoreLabel = hsl;
    greenButton = gb;
    redButton = rb;
    yellowButton = yb;
    blueButton = bb;
    backgroundImageView = biv;
    
    [highscoreLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self highscore]]];
    [self enableGameButtons:NO];
    
    gameOver = YES;
    
    return self;
}

- (void)startNewGame
{
    currentSequence = [[NSMutableArray alloc] init];
    audioPlayers = [[NSMutableArray alloc] init];
    
    gameOver = NO;
    playerIndex = 0;
    score = 0;
    
    [self enableGameButtons:YES];
    [self nextMove];
}

- (void)forceGameOver
{
    gameOver = YES;
    idle = YES;
    
    [scoreLabel setText:@"0"];
    [self enableGameButtons:NO];
    [backgroundImageView setImage:[UIImage imageNamed:@"background.png"]];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You lost the game." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}

- (void)buttonPressed:(id)sender
{
    if (playerIndex < [currentSequence count] && !idle) {
        UIButton *button = (UIButton *)sender;
        NSString *buttonName = [[button titleLabel] text];
        
        [self highlightButton:button];
        if ([buttonName isEqualToString:[currentSequence objectAtIndex:playerIndex]]) {
            playerIndex++;
            if (playerIndex == [currentSequence count]) {
                score++;
                [scoreLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)score]];
                
                if (score > [self highscore]) {
                    [self setHighscore:score];
                }
                
                [self performSelector:@selector(nextMove) withObject:nil afterDelay:0.4];
            }
        } else {
            [self forceGameOver];
        }
    }
}

- (void)resetHighscore
{
    [self setHighscore:0];
}

- (BOOL)isRunning
{
    return !gameOver;
}

//------------ private methods ------------

- (void)nextMove
{
    idle = YES;
    [backgroundImageView setImage:[UIImage imageNamed:@"background.png"]];
    switch (arc4random_uniform(4)) {
        case 0:
            [currentSequence addObject:[[greenButton titleLabel] text]];
            break;
        case 1:
            [currentSequence addObject:[[redButton titleLabel] text]];
            break;
        case 2:
            [currentSequence addObject:[[yellowButton titleLabel] text]];
            break;
        case 3:
            [currentSequence addObject:[[blueButton titleLabel] text]];
            break;
        default:
            break;
    }
    
    float interval = 0.5;
    playerIndex = 0;
    for (int i = 0; i < [currentSequence count]; i++) {
        [self performSelector:@selector(nextMoveSelector:) withObject:[currentSequence objectAtIndex:i] afterDelay:(i+1)*interval];
    }
    [self performSelector:@selector(setReadySelector) withObject:nil afterDelay:(([currentSequence count]+1)*interval)];
}

- (void)enableGameButtons:(BOOL)state
{
    if (state == NO) {
        [self changeToDim:greenButton];
        [self changeToDim:redButton];
        [self changeToDim:yellowButton];
        [self changeToDim:blueButton];
    }
    
    [greenButton setEnabled:state];
    [redButton setEnabled:state];
    [blueButton setEnabled:state];
    [yellowButton setEnabled:state];
}

- (void)highlightButton:(UIButton *)button
{
    NSString *buttonName = [[button titleLabel] text];
    
    NSURL *path = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[@"default_" stringByAppendingString:buttonName] ofType:@"mp3"]];
    NSError *error;
    
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
    
    [audioPlayers addObject:audioPlayer];
    audioPlayer.delegate = (id<AVAudioPlayerDelegate>)self;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
    AVAudioPlayer* objAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:path error:NULL];
    [objAudio play];
    
    [self performSelector:@selector(changeToLit:) withObject:button afterDelay:0.0];
    [self performSelector:@selector(changeToDim:) withObject:button afterDelay:0.4]; //delay must be smaller than interval from nextMove:
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [audioPlayers removeObject:player];
}

- (void)highlightButtonByName:(NSString *)buttonName
{
    if ([buttonName isEqualToString:[[greenButton titleLabel] text]]) {
        [self highlightButton:greenButton];
    } else if ([buttonName isEqualToString:[[redButton titleLabel] text]]) {
        [self highlightButton:redButton];
    } else if ([buttonName isEqualToString:[[yellowButton titleLabel] text]]) {
        [self highlightButton:yellowButton];
    } else if ([buttonName isEqualToString:[[blueButton titleLabel] text]]) {
        [self highlightButton:blueButton];
    }
}

- (void)setHighscore:(NSUInteger)newHighscore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSString stringWithFormat:@"%lu",(unsigned long)newHighscore] forKey:@"highscore"];
    [defaults synchronize];
    
    [highscoreLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)newHighscore]];
}

- (NSUInteger)highscore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"highscore"] intValue];
}

- (void)changeToLit:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:[[[button titleLabel] text] stringByAppendingString:@"-lit.png"]] forState:UIControlStateNormal];
}

- (void)changeToDim:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:[[[button titleLabel] text] stringByAppendingString:@"-dim.png"]] forState:UIControlStateNormal];
}

- (void)nextMoveSelector:(NSString *)buttonName
{
    [self highlightButtonByName:buttonName];
}

- (void)setReadySelector
{
    idle = NO;
    [backgroundImageView setImage:[UIImage imageNamed:@"background-ready.png"]];
}

@end
