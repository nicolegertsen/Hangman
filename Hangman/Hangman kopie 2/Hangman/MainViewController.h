//
//  MainViewController.h
//  Hangman
//
//  Created by Nicole Gertsen on 06-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "FlipsideViewController.h"
#import "GameplayDelegate.h"
#import "Gameplay.h"
#import "Scores.h"

@interface MainViewController : UIViewController <UITextFieldDelegate, FlipsideViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *hangmanImage;
@property (weak, nonatomic) IBOutlet UILabel *displayWord;
@property (weak, nonatomic) IBOutlet UILabel *guessesRemaining;
@property (weak, nonatomic) IBOutlet UILabel *lettersUsed;
@property (weak, nonatomic) IBOutlet UITextField *guessInput;
@property (readwrite, assign) int originalGuesses;
@property (strong, nonatomic) id <GamePlayDelegate> game;

@property (strong, nonatomic) Scores *history;

- (void)switchView:(NSString *)viewController;

- (IBAction)showInfo:(id)sender;

- (IBAction)newGame:(id)sender;

- (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate;

- (void)errorWithMessage:(NSString *)message;

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end