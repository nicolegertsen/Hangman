//
//  FlipsideViewController.m
//  Hangman
//
//  Created by Nicole Gertsen on 06-06-14.
//  Copyright (c) 2014 nicolegertsen. All rights reserved.
//

#import "FlipsideViewController.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize wordSize = _wordSize;
@synthesize mistakeNumber = _mistakeNumber;
@synthesize wordSlider = _wordSlider;
@synthesize mistakeSlider = _mistakeSlider;
@synthesize highscores;
@synthesize history;
@synthesize newgamebutton;
@synthesize donebutton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // load NSUserDefaults and configure sliders and labels accordingly
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.wordSlider.maximumValue = [[userDefaults valueForKey:@"sliderMax"] intValue];
    self.wordSlider.minimumValue = [[userDefaults valueForKey:@"sliderMin"] intValue];
    self.wordSlider.value = [[userDefaults valueForKey:@"wordLength"] intValue];
    self.wordSize.text = [userDefaults valueForKey:@"wordLength"];
    self.mistakeSlider.value = [[userDefaults valueForKey:@"guesses"] intValue];
    self.mistakeNumber.text = [userDefaults valueForKey:@"guesses"];
    
    self.history = [Scores alloc];
    self.highscores = [self.history getHighscores];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *result = [defaults objectForKey:@"result"];
    
    newgamebutton.hidden = YES;
    if ([result isEqualToString:@"lost"]) {
        newgamebutton.hidden = YES;
    }
    else if ([result isEqualToString:@"won"]){
        newgamebutton.hidden = YES;
    }
    else {
        newgamebutton.hidden = NO;
        donebutton.title = @"";
    }
    
    for (int i = 0; i < 10; i++) {
        NSString *tempWordString = [NSString stringWithFormat:@"highscoreLabel%d", i + 1];
        NSString *tempScoreString = [NSString stringWithFormat:@"highscoreLabelScore%d",i + 1];
        UILabel *tempWordLabel = [self valueForKey:tempWordString];
        UILabel *tempScoreLabel = [self valueForKeyPath:tempScoreString];
        
        if (i < [highscores count]) {
            NSString *tempStringLabelText = [NSString stringWithFormat:@"%d. %@", i + 1, self.highscores[i][1]];
            NSString *tempStringLabelScore = [NSString stringWithFormat:@"%@", self.highscores[i][0]];
            tempWordLabel.text = tempStringLabelText;
            tempScoreLabel.text = tempStringLabelScore;
        }
        else {
            tempWordLabel.text = @"";
            tempScoreLabel.text = @"";
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

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

#pragma mark - Actions

// Done with flipside, return to the main
- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

// Detect slider changes
- (IBAction)setWordLength:(UISlider *)sender
{
    // load user defaults and record changes, converting to strings in order to store as an object
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger wordLength = (int)self.wordSlider.value;
    NSString *strFromInt = [NSString stringWithFormat:@"%d", wordLength];
    self.wordSize.text = [NSString stringWithFormat:@"%d", wordLength];
    [userDefaults setValue:strFromInt forKey:@"wordLength"];
}

- (IBAction)setMistakesNumber:(UISlider *)sender
{
    // load user defaults and record changes, converting to strings in order to store as an object
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger guesses = (int)self.mistakeSlider.value;
    NSString *strFromInt2 = [NSString stringWithFormat:@"%d", guesses];
    self.mistakeNumber.text = [NSString stringWithFormat:@"%d", guesses];
    [userDefaults setValue:strFromInt2 forKey:@"guesses"];
}

- (IBAction)newGame:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc animated:YES completion:nil];
    [self setMistakeNumber:sender];
    [self setWordLength:sender];
}


@end