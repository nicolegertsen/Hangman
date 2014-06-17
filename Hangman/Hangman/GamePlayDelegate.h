//
//  GamePlayDelegate.h
//  Hangman
//
//  Created by Nicole Gertsen on 10-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#ifndef Hangman_GamePlayDelegate_h
#define Hangman_GamePlayDelegate_h

@protocol GamePlayDelegate <NSObject>

@property (strong, nonatomic) NSMutableArray *guesses;
@property (readwrite, assign) int guessCount;
@property (strong, nonatomic) NSString *displayWordString;
@property (readwrite, assign) int hiddenLetterCount;
@property (strong, nonatomic) NSString *word;

- (void)startNewGame:(int)mistakeNumber :(int)wordSize :(NSMutableArray *)plistData;
- (int)updateGame:(NSString *)guess;

@end

#endif
