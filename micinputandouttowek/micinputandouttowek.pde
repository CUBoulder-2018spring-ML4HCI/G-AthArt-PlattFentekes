
import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*; // for AudioStream

import oscP5.*;
import netP5.*;

float outfreq;

OscP5 oscP5;
NetAddress dest;

FFT         fft;

Minim minim;
AudioOutput out;
LiveInput in;

void setup()
{
  // initialize the drawing window
  size(512, 200);
  
  // initialize the minim and out objects
  minim = new Minim(this);
  out = minim.getLineOut();
  
  // we ask for an input with the same audio properties as the output.
  AudioStream inputStream = minim.getInputStream( out.getFormat().getChannels(), 
                                                  out.bufferSize(), 
                                                  out.sampleRate(), 
                                                  out.getFormat().getSampleSizeInBits());
                                                 
  // construct a LiveInput by giving it an InputStream from minim.                                                  
  in = new LiveInput( inputStream );
  
  // create granulate UGen so we can hear the input being modfied before it goes to the output
  GranulateSteady grain = new GranulateSteady();
  
  // patch the input through the grain effect to the output
  in.patch(grain).patch(out);
  fft = new FFT( out.bufferSize(), out.sampleRate() );
  
  
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
  frameRate(90);
  
}

// draw is run many times
void draw()
{
  // erase the window to black
  background( 0 );
  // draw using a white stroke
  stroke( 255 );
  // draw the waveforms
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  } 
  
  
    fft.forward( out.mix );
  
  for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*50 );
    outfreq=fft.getBand(i)*8;
    
  }
  sendOsc();
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
  
  msg.add((float)outfreq); 
  //added extra outputs to match my wekinator program lol
  println(msg);
  
  oscP5.send(msg, dest);
}