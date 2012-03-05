/*
 * The Seek Steering Behaviour
 */
class Flee extends Steering {
    
  // Position/size of target
  PVector target;
  float radius;
  
  // How far away from persuer before we consider ourselves safe
  float safeDistance;
  
  // How far away from wall before we need to start turning away
  float wallDistance;
  
  // Force to turn away from wall with
  float turningForce;
  
  // Initialisation
  Flee(Agent a, float r, float sd, float wd, float tf) {
      super(a);
      safeDistance = sd;
      radius = r;
      wallDistance = wd;
      turningForce = tf;
  }
  
  PVector calculateRawForce() {
    
      if (target == null) return new PVector(0,0);
     
      // Check that agent's centre is not over target
      if (PVector.dist(target, agent.position) < safeDistance) {
        // Calculate Seek Force
        PVector flee = PVector.sub(agent.position, target);
        flee.normalize();
        flee.mult(agent.maxSpeed);
        flee.sub(agent.velocity);
        
        return flee;

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
}
