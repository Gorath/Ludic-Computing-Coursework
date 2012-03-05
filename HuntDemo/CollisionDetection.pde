/*
 * The Seek Steering Behaviour
 *
class CollisionDetection extends Steering {
  
  // Array list of agents who we can collide with
  ArrayList agents;
    
  // Position/size of target
  PVector target;
  float radius;
  
  // How far away from person before we consider ourselves colliding
  float safeDistance;
  
  // Force to turn away from agent with
  float bumperForce;
  
  
  // Initialisation
  CollisionDetection(Agent a, float sd) {
      super(a);
      safeDistance = sd;
      turningForce = agent.maxSpeed;
      bumperForce = 1;
  }
  
  void setAgentList(ArrayList a) {
    agents = a;
  }
  
  void calculateTarget() {
    
  }
  
  PVector calculateRawForce() {
    
      if (target == null) {
        return new PVector(0,0);

      } else  {
        // If agent's centre is over target stop seeking
        return new PVector(0,0); 
      }   
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     fill(204, 153, 0);
     ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
} */
