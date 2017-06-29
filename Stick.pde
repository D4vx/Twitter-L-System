class Stick
{
  Vec3D loc;
  Vec3D vel;
  Vec3D oriLoc;
  
  int generations;
  
  String type;
  
  Stick(Vec3D _loc, Vec3D _vel, int _generations, String _type)
  {
    loc = _loc;
    vel = _vel;
    oriLoc = _loc.copy();
    generations = _generations;
    type = _type;
    
    // stack of functions that get executed only once
    updateDir();
    updateLoc();
    spawn();
  }
  
  void run()
  {
    display();
    
  }
  
  void spawn()
  {
    if(generations > 0)
    {
      // Each A spawns A and B
      if(type == "A") 
      {
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newStick = new Stick(v, iniVel, generations-1, "A");
        allSticks.add(newStick);
                
        Vec3D v2 = loc.copy();
        Vec3D iniVel2 = vel.copy();
        Stick newStick2 = new Stick(v2, iniVel2, generations-1, "B");
        allSticks.add(newStick2);
      }
      
      // Each B spawns a C
      if(type == "B") 
      {
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newStick = new Stick(v, iniVel, generations-1, "B");
        allSticks.add(newStick);
        
        Vec3D v2 = loc.copy();
        Vec3D iniVel2 = vel.copy();
        Stick newStick2 = new Stick(v2, iniVel2, generations-1, "C");
        allSticks.add(newStick2);
      }
      
      // Each C spawns an A
      if(type == "C")
      {
        Vec3D v = loc.copy();
        Vec3D iniVel = vel.copy();
        Stick newStick = new Stick(v, iniVel, generations-1, "B");
        allSticks.add(newStick);
      }      
    }
  }
  
  void updateLoc()
  {
    loc.addSelf(vel);  
  }
  
  void updateDir()
  {
    if(type == "A")
    {      
      float angle1 = radians(varians.get(0));
      float angle2 = radians(varians.get(1));
      float angle3 = radians(varians.get(2));
      
      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3); 

    }
    
    if(type == "B")
    {
      float angle1 = radians(varians.get(6));
      float angle2 = radians(varians.get(7));
      float angle3 = radians(varians.get(8));
      
      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3); 
      
    }
    
    if(type == "C")
    {
      float angle1 = radians(varians.get(3));
      float angle2 = radians(varians.get(4));
      float angle3 = radians(varians.get(5));
      
      vel.rotateX(angle1);
      vel.rotateY(angle2);
      vel.rotateZ(angle3);  
      
    }
  }
  
  void display()
  {
    // draws the joint point
//    stroke(150, map(generations, 1, MAXGENERATIONS, 20, 255));
//    strokeWeight(generations);
//    point(loc.x, loc.y, loc.z);
    
    // draws the line / stick
    
    // colours based on the 'type'
    if(type == "A") // core branch
    {       
      //stroke(r,g,b , map(generations, 1, MAXGENERATIONS, 20, 255));
      stroke(255, map(generations, 1, MAXGENERATIONS, 20, 255));  // brownish core branches
      strokeWeight(1 * generations);
      line(loc.x, loc.y, loc.z, oriLoc.x, oriLoc.y, oriLoc.z);
    }
    if(type == "B")
    {
      stroke(r, g, b , map(generations, 1, MAXGENERATIONS, 20, 255));
      strokeWeight(1 * generations);
      line(loc.x, loc.y, loc.z, oriLoc.x, oriLoc.y, oriLoc.z);
    }
    
    if(type == "C")
    {     
      stroke(r,g,b , map(generations, 1, MAXGENERATIONS, 20, 255));
      strokeWeight(1 * generations);
      line(loc.x, loc.y, loc.z, oriLoc.x, oriLoc.y, oriLoc.z);
    }
    
  }
}

