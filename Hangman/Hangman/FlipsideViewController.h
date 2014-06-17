//
//  FlipsideViewController.h
//  Hangman
//
//  Created by Nicole Gertsen on 06-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scores.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

// declare properties for labels, sliders, and switches
@property (weak, nonatomic) IBOutlet UILabel *wordSize;
@property (weak, nonatomic) IBOutlet UILabel *mistakeNumber;
@property (weak, nonatomic) IBOutlet UISlider *wordSlider;
@property (weak, nonatomic) IBOutlet UISlider *mistakeSlider;
@property (strong, nonatomic) NSMutableArray *highscores;
@property (strong, nonatomic) Scores *history;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel1;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore1;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel2;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore2;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel3;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore3;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel4;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore4;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel5;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore5;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel6;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore6;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel7;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore7;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel8;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore8;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel9;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore9;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabel10;
@property (strong, nonatomic) IBOutlet UILabel *highscoreLabelScore10;
@property (strong, nonatomic) IBOutlet UIButton *newgamebutton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebutton;


// declare IBActions for hiding the flipside view and detecting slider changes

- (IBAction)done:(id)sender;

- (IBAction)newGame:(id)sender;

- (IBAction)setWordLength:(UISlider *)sender;

- (IBAction)setMistakesNumber:(UISlider *)sender;

@end
