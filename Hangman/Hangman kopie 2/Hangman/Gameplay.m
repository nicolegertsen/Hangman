//
//  Gameplay.m
//  Hangman
//
//  Created by Nicole Gertsen on 10-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "Gameplay.h"


@implementation Gameplay

@synthesize guesses = _guesses;
@synthesize guessCount = _guessCount;
@synthesize word = _word;
@synthesize displayWordString = _displayWordString;
@synthesize hiddenLetterCount = _hiddenLetterCount;

// take in guess and update game
- (int)updateGame:(NSString *)guess;
{
    // check if letter has been guessed already
    if ([self.guesses containsObject:(guess)]) {
        return 1;
    } else {
        // else add letter to guess history
        [self.guesses addObject:guess];
        // check if guess is in the target word, and reduce guessCount if not
        if ([self.word rangeOfString:guess].location == NSNotFound) {
            self.guessCount--;
            // check if game was lost, and if so return accordingly
            if (self.guessCount <= 0) {
                return 3;
            }
        } else {
            // iterate through displayWordString and replace dashes with the letter if the guess is correct
            for (int i = 0; i < self.displayWordString.length; i++) {
                if ([[self.word substringWithRange:(NSMakeRange(i, 1))] caseInsensitiveCompare:guess] == NSOrderedSame) {
                    self.displayWordString = [self.displayWordString stringByReplacingCharactersInRange:(NSMakeRange(i, 1)) withString:guess];
                    self.hiddenLetterCount--;
                    // check if game was won, and if so return accordingly
                    if (self.hiddenLetterCount <= 0) {
                        return 2;
                        
                    }
                }
            }
        }
        // otherwise continue the game
        return 0;
    }
}

// start new game
- (void)startNewGame:(int)mistakeNumber :(int)wordSize :(NSMutableArray *) plistData;
{
    // declare variables for maximum and minimum values of slider
    int max = 0;
    int min = wordSize;
    
    // initialize variables for guesses, guessCount, word string to display, and count of hidden letters
    self.guesses = [[NSMutableArray alloc] init];
    self.guessCount = mistakeNumber;
    self.displayWordString = [@"" stringByPaddingToLength:(wordSize) withString:@"-" startingAtIndex:0];
    self.hiddenLetterCount = wordSize;
    
    // load possible words from plist file
    NSMutableArray *possibleWords = [[NSMutableArray alloc] initWithObjects:nil];
    
    //NSString *versionString = [NSString stringWithFormat:@"%@", [plistData objectAtIndex:0]];
    //NSLog(@"%@", versionString);
    
    // iterate through plist and load words, as well as noting max and min lengths to define the word length slider parameters
    for (NSString *object in plistData) {
        if (object.length == wordSize) {
            [possibleWords addObject:object];
        }
        if (object.length > max) {
            max = object.length;
        }
        if (object.length < min) {
            min = object.length;
        }
    }
    
    // pick a random word from the set of possible words to play the game with
    self.word = [possibleWords objectAtIndex:(arc4random_uniform([possibleWords count]))];
    NSLog(@"word: %@", self.word);
    
    // update NSUserDefaults to contain the max and min values
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSString stringWithFormat:@"%d", max] forKey:@"sliderMax"];
    [userDefaults setValue:[NSString stringWithFormat:@"%d", min] forKey:@"sliderMin"];
    [userDefaults synchronize];
    
}

@end