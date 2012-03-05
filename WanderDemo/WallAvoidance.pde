/*
 * The Seek Steering Behaviour
 */
class WallAvoidance extends Steering {
  
  // Position/size of target
  PVector target;
  float radius;
  
  // How far away from wall before we need to start turning away
  float wallDistance;
  
  // Force to turn away from wall with
  float turningForce;
  
  // Initialisation
  WallAvoidance(Agent a, float walld, float tf) {
      super(a);
      wallDistance = walld;
      turningForce = tf;
  }
  
  PVector calculateRawForce() {
      PVector turn = new PVector(0,0);
      // Check that agent's centre is not over target
      if (agent.velocity.x != 0 && agent.velocity.y != 0) {
        if ( agent.position.y < wallDistance )          turn.add(new PVector(agent.velocity.x * turningForce ,turningForce));
        if ( agent.position.y > height - wallDistance ) turn.add(new PVector(agent.velocity.x * turningForce ,-turningForce));
        if ( agent.position.x < wallDistance )          turn.add(new PVector(turningForce ,agent.velocity.y * turningForce ));
        if ( agent.position.x > width - wallDistance )  turn.add(new PVector(-turningForce ,agent.velocity.y * turningForce ));
      }
      return turn;
  }
  
  // Draw the target
  void draw() {
  }
}
