//
//  Scores.h
//  Hangman
//
//  Created by Nicole Gertsen on 13-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scores : NSObject

-(void)updateHighscoresWithWord:(NSString *)word score:(int)score;
-(NSMutableArray *)getHighscores;
-(NSString *) getCorrectWord;

@end
