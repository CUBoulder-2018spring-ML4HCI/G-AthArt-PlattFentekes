# MicrophoneBreathControl
Rachel Platt & Nick Fentekes

## Goal
We wanted to make a breathing trainer for the square breathing method we learned about in class. For square breathing, you breath in through your nose, pause, breath out through your mouth, pause and repeat. Each breath or pause is done for a consistent amount of time (typically about 4 seconds). We wanted to create a program that would show a person's in and out breaths in comparison to a visualization of pre-timed square breathing.

## Approach
For input, we used a microphone. We applied a Fourier Transform on the input audio and used the frequency spectrum values generated to train our model. We used a decision tree model. Many other models, especially K-nearest neighbor, barely worked for us at all. Decision tree seemed to be the best choice. 

## Improvements to be made
First of all, the detection of in and out breaths was really tricky, this coul probably be improved with a better microphone. Also, its pretty inconvenient to have to hold a microphone close to your mouth for this to work, so if it could be implemented in a more discrete way that would be a lot more user friendly.

## Demo Video
