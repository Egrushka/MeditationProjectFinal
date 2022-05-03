/****************************************************************************
IMPORT LIBRARIES
****************************************************************************/
import processing.video.*;
import processing.sound.*;

/****************************************************************************
IMPORT MEDIA AND ASSIGN VARIABLES
****************************************************************************/
SoundFile water;
SoundFile beat; 
Movie mov; 

String video = "rain.mp4"; 
PImage rain;
PFont font;
String[] words; 
IntDict concordance; 
int index = 0; 

Drop[] drops = new Drop[500]; // array of drop objects

void setup() 
{
  fullScreen(); 
/****************************************************************************
CANVAS OPTIONS
****************************************************************************/
  //size(1000, 1000);
  //size(1000, 1000, JAVA2D);
  
/****************************************************************************
VIDEO, SOUND, FONT
****************************************************************************/
  
  rain = loadImage("rain1.jpeg"); 
  mov = new Movie(this, video); 
  
  //font = createFont("Book Antiqua Bold",10); 
  //font = createFont("Calibri Light",10);
  
  //textFont(font); 
  //sound(); 
    
  mov.play(); 
  //mov.loop();
  
/****************************************************************************
READING THE TEXT
****************************************************************************/
  String[] lines = loadStrings("master.txt"); 
  String allthetxt = join(lines, " "); 
  words = splitTokens(allthetxt, " ’'…,.:;!)-–(?“”\"*[]1234567890"); 
  //printArray(words); 
  
  concordance = new IntDict(); 
  
  for (int x = 0; x < words.length; x++)
  {
    concordance.increment(words[x].toLowerCase()); 
  }
  
  concordance.sortValuesReverse(); 
  //println(concordance); 
  
  for (int i = 0; i < drops.length; i++) 
  { // we create the drops 
    drops[i] = new Drop();
  }
  
  smooth(8); 
  hint(ENABLE_STROKE_PURE); 
} 

void draw() 
{
 // println(PFont.list()); 
/****************************************************************************
CANVAS
****************************************************************************/
  image(mov, 0, 0, width, height);
  //mov.play(); 
  //background(0);
/****************************************************************************
CHECK TEXT
****************************************************************************/
  //image(rain, 0, 0); 
  //textSize(64); 
  //fill(#FFFFFF); 
  //textAlign(CENTER); 
  //text(words[index], width/2, height/2); 
  //index++; 
  //frameRate(3); 
  
/****************************************************************************
RAIN
****************************************************************************/
  String[] keys = concordance.keyArray(); 
  
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i].fall(); // sets the shape and speed of drop
    drops[i].show(keys[i]); // render drop
  }
}

void sound()
{
  water = new SoundFile(this, "rain.wav");
  beat = new SoundFile(this, "beat.wav");
  
  beat.play();
  beat.loop();
  beat.amp(.1);
  beat.rate(.5);
  
  water.play();
  water.amp(.2);
  water.loop();
}

void movieEvent(Movie m) {
  m.read();
}
