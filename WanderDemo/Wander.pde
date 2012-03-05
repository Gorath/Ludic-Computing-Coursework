/*
 * The Seek Steering Behaviour
 */
class Wander extends Steering {
  
  float wanderD;
  float wanderR;
  float jitter;
  
  boolean debug;
  
  // Position/size of target
  PVector target;
  float radius;
  float theta;
  
  // Initialisation
  Wander(Agent a, float r, float wd, float wr, float jit) {
      super(a);
      
      PVector valTemp = agent.velocity.get();
      valTemp.normalize();
      valTemp.mult(wd);
      theta = 0;
      //target = new PVector(agent.position.x + valTemp.x, agent.position.y + valTemp.y );
      radius = r;
      wanderD = wd;
      wanderR = wr;
      jitter = jit;
      debug = true;
      
  }
  
  ///////////////////////////
 ///New wonder, jitter changes degree amount
  void wander() {
      
    float change = random(-jitter/10, jitter/10);
    theta += change;

    // Now we have to calculate the new location to steer towards on the wander circle
    PVector circleloc = agent.velocity.get();    // Start with velocity
    circleloc.normalize();                       // Normalize to get heading
    circleloc.mult(wanderD);                     // Multiply by distance
    circleloc.add(agent.position);               // Make it relative to boid's location
    
    PVector circleOffset = new PVector(cos(theta), sin(theta));
   // PVector circleOffset = new PVector(target.x + thetaX, target.y + thetaY);
    circleOffset.normalize();
    circleOffset.mult(wanderR);
    
    target = PVector.add(circleloc,circleOffset);


    // Render wandering circle, etc. 
   if (debug) drawWanderStuff(agent.position,circleloc,target,wanderR);
  }
  
 PVector calculateRawForce() {
      wander(); 
      // Check that agent's centre is not over target
      if (PVector.dist(target, agent.position) > radius) {
        // Calculate Seek Force
        
        PVector wander = PVector.sub(target, agent.position);
        wander.normalize();
        wander.mult(agent.maxSpeed);
        wander.sub(agent.velocity);
        
        return wander;

      } else  {
        // If agent's centre is over target stop seeking
        return new PVector(0,0); 
      }   
  }
    
  // A method just to draw the circle associated with wandering
  void drawWanderStuff(PVector loc, PVector circle, PVector target, float rad) {
    stroke(0); 
    noFill();
    ellipseMode(CENTER);
    ellipse(circle.x,circle.y,rad*2,rad*2);
    stroke(255,0,0);
    ellipse(target.x,target.y,4,4);
    stroke(0);
    line(loc.x,loc.y,circle.x,circle.y);
    line(circle.x,circle.y,target.x,target.y);
  }
  
  void incWanderR() {
    wanderR += 1;
  }
  
  void decWanderR() {
    wanderR -= 1;
  }
  
  void incWanderD() {
    wanderD += 1;
  }
  
  void decWanderD() {
    wanderD -= 1;
  }
  
  void incJitter() {
    jitter += 1;
  }
  
  void decJitter() {
    jitter -= 1;
  }  
  
  // Draw the target
  void draw() {
     pushStyle();
     fill(204, 153, 0);
     //ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
}

