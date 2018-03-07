# MicrophoneBreathControl
Rachel Platt & Nick Fentekes

## Goal
We wanted to make a breathing trainer for the square breathing method we learned about in class. For square breathing, you breath in through your nose, pause, breath out through your mouth, pause, and repeat. Each breath or pause is done for a consistent amount of time (typically about 4 seconds). We wanted to create a program that would show a person's in and out breaths in comparison to a visualization of pre-timed square breathing, thus helping to train them on proper square breathing technique.

## Approach

### Input
For input, we used a microphone. We applied a Fourier Transform on the input audio and used the frequency spectrum values generated to train our model. We used a decision tree model. Many other models, especially K-nearest neighbor, barely worked for us at all. Decision tree seemed to be the best choice. 

#### Update 3/6
We realized we missed the requirement for Dynamic Time Warping for this project, so attempted to train our model using DTW instead of a decision tree. This worked pretty well for detecting in and out breaths, but still failed with detection of pauses. Another issue we encountered with this was having trouble getting the classification to change at the right time. We thought this might be because the beginning and end of an in-breath and out-breath are very similar, so the model wasn't catching the difference in sound until the middle of the breath.

### Output
For our output, we wanted to show a visual representation of square breathing by visualizing breaths in a square. The output takes the classification (in breath, out breath, or pause) and uses this to draw one of the edges on a square. At the same time, the output program gives pre-timed instructions for the user on what breaths they should be taking. The user's goal is to follow the instructions in the red text with their breathing, displayed by the edges of the square, to achieve proper square breathing technique.

## Improvements to be made
The detection of in and out breaths was really tricky, which could probably be improved with a better microphone, or even two microphones attached to the nose (for in-breathing) and mouth (for out breathing). It's pretty inconvenient to have to hold a microphone close to your mouth for this to work, so if it could be implemented in a more discrete way that would be more user friendly, especially if this was being used in a yoga practice.

## Demo Video
 https://youtu.be/ANaytI5UTiY
