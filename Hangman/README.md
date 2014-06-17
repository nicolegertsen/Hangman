apps
====
Hangman
-------
Hangman is a game in which a player has to guess a word. The word is represented by a line of dashes, giving the number of letters of the word to guess. If the players suggest a letter which occurs in the word, the letter is written in all its correct positions (instead of the dash).  If the suggested letter does not occur in the word, one element of the hanged man is drawn. The player has a limited amount of guesses. The game is over when the player guessed the word correctly within the limited amount of guesses or when the hangman is completed (the player needed more guesses than allowed).

Features:

*Gameplay must start immediately upon launch

*The front side displays the dashes for yet-unguessed letters that make clear the word’s length.
 
*Inform the user how many incorrect guesses he or she can still make before losing the game.

*Indicate to the user what letters he or she has not guessed yet.  

*Only single alphabetical characters are accepted as valid input.

*The app must have a title or logo and a button to start a new game.

*If the users guesses the word within the maximal amount of guesses, he or she should be congratulated and the game should end. If the user fails to guess the word within the maximal amount of guesses, he or she should be consoled and the game should end. 

*Two settings are able to configure: the length of words to be guessed (the allowed range is [1, n], where n is the length of the longest word in de list words.plist.xml) and the maximum number of incorrect guesses allowed (the allowed range is [1, 26]). 

*The app maintains a history of high score’s that is displayed anytime a game is won or lost. It ranks the result of at least 10 games (assuming at least 10 games have been won), displaying for each the word guessed and the number of mistakes made. The history of high score’s persists even when the app is backgrounded or force-quit. 

Frameworks, languages, libraries and other technologies:

*The app its code is written in Xcode. 

*The user interface (UI) is sized for a common smart phone (i.e., 320×480 points) with support for, at least, a portrait user interface orientation. 

*The contents of words.plist or words.xml are used as the universe of possible words. 

*A display of high scores is implemented in a separate view controller that presents itself at game’s end. A protocol is implemented in the main controller. 

*Methods are implemented with which high scores can be stored and retrieved in a model called History. High scores are stored persistently, as in a property list. 

*The gameplay is implemented in a separate model class called Gameplay. 

*Unit tests are implemented.

*The app works within the iPhone 6 Simulator. 

*The app is implemented from the Utility Application template, having a MainViewController and a FlipsideViewController. The flipside is used to manage game settings.

*The app comes with default values for the flipside’s two settings; these are set in NSUserdefaults with registerDefaults:. Anytime the user changes these settings, the new values are stored immediately. 

*Each of the flipside’s numeric settings are implemented with a slider control. Each slider is accompanied by at least one label that reports its current value (as an integer). 

*The app uses Automatic Referencs Counting (ARC). 

![Alt text](/Hangman/doc/START.png?raw=true "Start Scherm")
![Alt text](/doc/GAME.png?raw=true „Game Scherm")
![Alt text](/doc/WON.png?raw=true „Gewonnen Scherm")
![Alt text](/doc/LOST.png?raw=true „Verloren Scherm”)
![Alt text](/doc/SETTINGS.png?raw=true "Settings Scherm")
![Alt text](/doc/HIGHSCORE.png?raw=true „Highscore Scherm”)