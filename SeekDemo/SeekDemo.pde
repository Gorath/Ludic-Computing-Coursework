/*
 *
 * The SeekDemo sketch
 *
 */

// Stores all the initialised agents
ArrayList agents;

// Stores the number of the current focus
int focus;

// A single agent
Agent seeker;
Agent arriver;

// It's steering behaviour
Seek seek;
Arrive arrive;

// Are we paused?
boolean pause;
// Is this information panel being displayed?
boolean showInfo;

// Initialisation
void setup() {
  size(1000,600); // Large display window
  pause = false;
  showInfo = true;
  focus = 1;
  
  // Create the agent
  seeker  = new Agent(10, 10, randomPoint());
  arriver = new Agent(10, 10, randomPoint());
  arriver.setColour(50,200,0);
  
  // Create a Seek behaviour
  PVector p = randomPoint();
  seek  = new Seek(seeker , p, 10);
  arrive = new Arrive(arriver, p, 10, 100);
  
  // Add the behaviour to the agent
  seeker.behaviours.add(seek);
  arriver.behaviours.add(arrive);
  
  // Adds agents to ArrayList keep track
  agents = new ArrayList();
  agents.add(seeker);
  agents.add(arriver);

  smooth(); // Anti-aliasing on
}

// Pick a random point in the display window
PVector randomPoint() {
  return new PVector(random(width), random(height));
}

// The draw loop
void draw() {
  // Clear the display
  background(255); 
  
  // Move forward one step in steering simulation
  if (!pause) {
    seeker.update();
    arriver.update();
  }
  seek.target = new PVector(mouseX, mouseY);
   arrive.target = new PVector(mouseX,mouseY);
  // Draw the agent
  seeker.draw();
  arriver.draw();
  
  // Draw the information panel
  if (showInfo) drawInfoPanel();

}
  
// Draw the information panel!
void drawInfoPanel() {
  pushStyle(); // Push current drawing style onto stack
  fill(0);
  int base = 20;
  
  Agent currentFocus = (Agent) agents.get(focus);
  int numBehaviours = currentFocus.behaviours.size();
  // Basic annotations
  text("1-6 - toggle between agents", 10, base); base += 15;
  text("8 - toggle display", 10, base); base += 15;
  text("9 - toggle annotation", 10, base); base += 15;
  text("Space - play/pause", 10, base); base += 30;
  
  // Agent specific annotations
  text("Current focus is agent: " + focus, 10, base); base += 15;
  text("Mass (q/a) = " + currentFocus.mass, 10, base); base += 15;
  text("Max. Force (w/s) = " + currentFocus.maxForce, 10, base); base += 15;
  text("Max. Speed (e/d) = " + currentFocus.maxSpeed, 10, base); base += 15;
  
  for (int i = 0; i < numBehaviours; i++) {
     Steering currBehaviour = (Steering) currentFocus.behaviours.get(i);
     if (currBehaviour.ident == "ARRIVE") {
       Arrive behaviour = (Arrive) currentFocus.behaviours.get(i);
       text("Stopping Dist (r/f) = " + behaviour.stoppingDist, 10, base); base += 15;
     } 
  }
  
  text("Drag the mouse to move the target", 10, 400);
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Mouse clicked, so move the target
void mouseClicked() {
   seek.target = new PVector(mouseX, mouseY);
   arrive.target = new PVector(mouseX,mouseY);
}

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
   
   // Controls for selecting different agents  
   } else if (key == '1' || key == '!') {
     if (agents.size() > 0) focus = 0;
     
   } else if (key == '2' || key == '"') {
     if (agents.size() > 1) focus = 1;
     
      } else if (key == '3' || key == '£') {
     if (agents.size() > 2) focus = 2;
     
   } else if (key == '4' || key == '$') {
     if (agents.size() > 3) focus = 3;
     
        } else if (key == '5' || key == '%') {
     if (agents.size() > 4) focus = 4;
     
   } else if (key == '6' || key == '^') {
     if (agents.size() > 5) focus = 5;
     
   // Controls for toggleing info  
   } else if (key == '8' || key == '*') {
     toggleInfo();
     
   } else if (key == '9' || key == '(') {
     seeker.toggleAnnotate();
     arriver.toggleAnnotate();
     
   // Vary the agent's mass
   } else if (key == 'q' || key == 'Q') {
     Agent current = (Agent) agents.get(focus);
     current.incMass();

   } else if (key == 'a' || key == 'A') {
     Agent current = (Agent) agents.get(focus);
     current.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 'w' || key == 'W') {
     Agent current = (Agent) agents.get(focus);
     current.incMaxForce();
     
   } else if (key == 's' || key == 'S') {
     Agent current = (Agent) agents.get(focus);
     current.decMaxForce();

     // Vary the agent's maximum speed
   } else if (key == 'e' || key == 'E') {
     Agent current = (Agent) agents.get(focus);
     current.incMaxSpeed();
     
   } else if (key == 'd' || key == 'D') {
     Agent current = (Agent) agents.get(focus);
     current.decMaxSpeed();
     
   // Vary the agent's stopping distance
   } else if (key == 'r' || key == 'R') {
     Agent currentFocus = (Agent) agents.get(focus);
     
     for (int i = 0; i < currentFocus.behaviours.size(); i++) {
       Steering currBehaviour = (Steering) currentFocus.behaviours.get(i);
       if (currBehaviour.ident == "ARRIVE") {
         Arrive behaviour = (Arrive) currBehaviour; behaviour.incStopDist(); return;
       } 
     }
     
   } else if (key == 'f' || key == 'F') {
     Agent currentFocus = (Agent) agents.get(focus);
     
     for (int i = 0; i < currentFocus.behaviours.size(); i++) {
       Steering currBehaviour = (Steering) currentFocus.behaviours.get(i);
       if (currBehaviour.ident == "ARRIVE") {
         Arrive behaviour = (Arrive) currBehaviour; behaviour.decStopDist(); return;
       } 
     }

   }
}

// Toggle the pause state
void togglePause() {
     if (pause) {
       pause = false; 
     } else {
       pause = true;
     }
}

// Toggle the display of the information panel
void toggleInfo() {
     if (showInfo) {
       showInfo = false; 
     } else {
       showInfo = true;
     }
}

