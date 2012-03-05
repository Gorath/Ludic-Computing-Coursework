/*
 * Persuit towards another agent
 * 
 * Time = 0 seek behaviour
 * Time > 0 persue behaviour
 */
class Seek extends Steering {
  
  // Position/size of target
  
  PVector target;
  float radius;
  
  // Initialisation
  Seek(Agent a, float r) {
      super(a);
      radius = r;
  }
  
  PVector calculateRawForce() {
      // Check that agent's centre is not over target
      if (target == null) return new PVector(0,0);
      
      if (PVector.dist(target, agent.position) > radius) {
        // Calculate Seek Force
        PVector seek = PVector.sub(target, agent.position);
        seek.normalize();
        seek.mult(agent.maxSpeed);
        seek.sub(agent.velocity);
        return seek;

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
