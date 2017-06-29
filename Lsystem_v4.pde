// This program is designed to produce an L-System based on twitter posts
// Parameters that can decide this are :
// - Word count
// - Letter Count 
// - Length of tweet 
// Each tweet is represented by an L-System
// Author    : Dave Brown (1393595)
// Revision  : 4
// Reference : Twitter code retrieved from http://blog.blprnt.com/blog/blprnt/updated-quick-tutorial-processing-twitter
//           : Stream code retreived from http://forum.processing.org/one/topic/twitter-streaming.html


// camera library
import peasy.*;

// vector math library (for easier 3D vector manipluation)
import toxi.geom.*;

// twitter libraries
import twitter4j.*;
import java.util.List;



// variables that will be controlled by the twitter post

String twit = " ";

PeasyCam cam;
Stick st;

static int MAXGENERATIONS = 18;

ArrayList <Stick>allSticks;
boolean nextTweet = true;
float timer = 0;
float r=255, g=255, b=255;
int genCount = 2; // start showing 2 generations

void setup()
{
  size(800,600, P3D);
  smooth();
  
  // Connect to twitter stream
  connectTwitter();
  tstream.addListener(listener);
  
  if(searchKeyword.length==0) tstream.sample();  
  else tstream.filter(new FilterQuery().track(searchKeyword));
  
  // setup camera
  cam = new PeasyCam(this,1000); 
  cam.setMinimumDistance(200);
  
  // init arralylist of the Lsystem
  allSticks = new ArrayList<Stick>();

  
}

void draw()
{
  background(0);

  stroke(0,255,0);
  noFill();
  strokeWeight(1);
  allSticks.clear();
  // set starting point and populate the first node
  Vec3D v = new Vec3D(0,200,0); // center of the screen
  Vec3D iniVel = new Vec3D(0,-100,0); // 100 units X
  st = new Stick(v, iniVel, wordNum /* generations */, "A");

  allSticks.add(st);
  for(Stick b:allSticks)
  {
    b.run();
  }

  cam.beginHUD();
  
  String info = "Press C for colour, Press Z to toggle pattern hold";
  String info2 = "Press < or > to decrease and increase the generations";
  text(info, 250 , height - 40);
  text(info2, 230, height - 20);
  text(twit, 20,20);
  if(!nextTweet)
  {
    text("HOLDING PATTERN", width - 120, height - 20);
  }
  cam.endHUD();
  
  // rotate gently around the Y axis
  cam.rotateY(0.008);
  
  // every 6 seconds... get a new tweet
  if(nextTweet)
  {
    if(timer + 6000 < millis())
    {
      timer = millis();
      if(!ready) { ready = !ready; } 
    }
  }
}


  
