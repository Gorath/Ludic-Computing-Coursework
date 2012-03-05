/*
 * The Arrive Steering Behaviour
 */
class Arrive extends Steering {
  
  // Position/size of target
  PVector target;
  float radius;
  int stoppingDist;
  
  // Initialisation
  Arrive(Agent a, float r, int d) {
      super(a);
      radius = r;
      stoppingDist = d;
  }
  
  PVector calculateRawForce() {
      // Check that agent's centre is not over target
      if (PVector.dist(target, agent.position) > 0) {
        // Calculate Seek Force
        PVector arrive = PVector.sub(target, agent.position);
        arrive.normalize();
      
        float m = PVector.dist(target,agent.position);  
        if (m < stoppingDist) arrive.mult(agent.maxSpeed*(m/stoppingDist));
        else arrive.mult(agent.maxSpeed);
      
        arrive.sub(agent.velocity);
        
        return arrive;

      } else  {
        // If agent's centre is over target stop seeking
        return new PVector(0,0); 
      }   
  }
  
  void incStopDist() {
    stoppingDist += 5;
  }
  void decStopDist() {
    stoppingDist -= 5;
  }
  
  // Draw the target
  void draw() {
     pushStyle();
     fill(204, 153, 0);
     ellipse(target.x, target.y, radius, radius);
     popStyle();
  }
}
