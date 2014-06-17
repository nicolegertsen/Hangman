//
//  MainViewController.m
//  Hangman
//
//  Created by Nicole Gertsen on 06-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//
#import "MainViewController.h"
#import "Gameplay.h"
#import "math.h"
#include <ctype.h>

@implementation MainViewController

@synthesize displayWord = _displayWord;
@synthesize guessesRemaining = _guessesRemaining;
@synthesize lettersUsed = _lettersUsed;
@synthesize guessInput = _guessInput;
@synthesize game = _game;
@synthesize originalGuesses = _originalGuesses;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults setValue:@"4" forKey:@"wordLength"];
    //[userDefaults setValue:@"4" forKey:@"guesses"];
    [userDefaults synchronize];
    
    // Done button on keyboard and no auto correction.
    [self.guessInput setReturnKeyType:UIReturnKeyDone];
    self.guessInput.autocorrectionType = UITextAutocorrectionTypeNo;
    self.game = [Gameplay alloc];
    self.history = [Scores alloc];
    
    // start game
    [self newGame:(id)nil];
    self.guessInput.delegate = self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.guessInput) {
         // hide the keyboard after input and react to guess
        [textField resignFirstResponder];
        
        // guess from label to string
        NSString *guess = [self.guessInput.text uppercaseString];
        if (self.game.guessCount == 0 || self.game.hiddenLetterCount <= 0) {
            // display error message if the game is over
            [self errorWithMessage:@"This game is over, please start a new game."];
        }
        else if (guess.length != 1 || !isalpha([guess characterAtIndex:0])) {
            // catch input that isn't a single valid character
            [self errorWithMessage:@"Please enter exactly one valid alphabetical character as your guess."];
            
        }
        else {
            // update the game
            int updateGameResult = [self.game updateGame:(guess)];
            if (updateGameResult == 1) { // already guessed;
                // catch letters already guessed and inform the user
                [self errorWithMessage:@"You already guessed that letter."];
            }
            else {
                // update the labels and image on the screen
                int mistakes = self.originalGuesses - [self.game guessCount];
                self.guessesRemaining.text = [NSString stringWithFormat:@"%d", [self.game guessCount]];
                self.lettersUsed.text = [NSString stringWithFormat:@"%@ %@", self.lettersUsed.text, guess];
                self.displayWord.text = self.game.displayWordString;
                // calculate state of hangman image
                float imageHangman = (mistakes) / (self.originalGuesses / 6.0f);
                int stateHangman = floorf(imageHangman);
                switch (stateHangman) {
                    case 0:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_start"];
                        break;
                    case 1:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_one"];
                        break;
                    case 2:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_two"];
                        break;
                    case 3:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_three"];
                        break;
                    case 4:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_four"];
                        break;
                    case 5:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_five"];
                        break;
                    case 6:
                        self.hangmanImage.image = [UIImage imageNamed:@"hangman_hanged"];
                        break;
                }
                
                NSString *result;
                // continue gameplay according to the result
                switch (updateGameResult) {
                    case 0: //continue
                        result = @"continue";
                        break;
                    case 2: //win
                        [self alertWithTitle:@"WINNING!" message:@"You won! Congratulations!" delegate:self];
                        // show user that the game was won and then show scores
                        int mistakes = self.originalGuesses - [self.game guessCount];
                        int score = 600 + ((100 * (self.game.word.length)) - (10 * (mistakes)));
                        [self.history updateHighscoresWithWord:self.game.word score:score];
                        result = @"won";
                        [self switchView:@"FlipsideViewController"];
                        break;
                    case 3: //lose
                        [self alertWithTitle:@"Lose..." message:@"You lost! Better luck next time!" delegate:self];
                        result = @"lost";
                        // show user that the game lost and then show scores
                        [self switchView:@"FlipsideViewController"];
                        break;
                }
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:result forKey:@"result"];
                [defaults synchronize];
            }
        }
        self.guessInput.text = @"";
        return NO;
        
    }

    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

// show the FlipsideViewController
- (IBAction)showInfo:(id)sender
{
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

-(void)switchView:(NSString *)viewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:viewController];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc animated:YES completion:nil];
}


// function to start new game
- (IBAction)newGame:(id)sender
{
    // load NSUserDefaults for wordLength and guesses
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int wordLength = [[userDefaults valueForKey:@"wordLength"] intValue];
    int guesses = [[userDefaults valueForKey:@"guesses"] intValue];
    
    self.originalGuesses = guesses;
    
    // set image to start image and text on screen to empty
    self.hangmanImage.image = [UIImage imageNamed:@"hangman_start"];
    self.guessInput.text = @"";
    self.lettersUsed.text = @"";
    self.guessesRemaining.text = [NSString stringWithFormat: @"%d", guesses];
    
    // define path to words.plist
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"words.plist"];
    
    // load plist to NSMutableArray
    NSMutableArray *plistData = [NSMutableArray arrayWithContentsOfFile:finalPath];
    
    // start the game
    [self.game startNewGame:guesses :wordLength :plistData];
    
    // show the initial hyphens
    self.displayWord.text = self.game.displayWordString;
}


// Alert user (win/lost)
- (void)alertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    // show alert view
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// Error message (letter already user/game over)
- (void)errorWithMessage:(NSString *)message
{
    [self alertWithTitle:@"Error" message:message delegate:nil];
}


@end

