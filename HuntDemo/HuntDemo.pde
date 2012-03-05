/*
 *
 * The SeekDemo sketch
 *
 */

// A single agent
Agent Player1;
Agent Player2;

// It's steering behaviour
Seek seek1;
Flee flee2;

// Are we paused?
boolean pause;
// Is this information panel being displayed?
boolean showInfo;

// Initialisation
void setup() {
  size(1000,600); // Large display window
  pause = false;
  showInfo = true;
  
  // Create the agent
  Player1 = new Agent(10, 10, randomPoint());
  Player2 = new Agent(10, 10, randomPoint());
  
  // Create a Seek behaviour
  seek1 = new Seek(Player1, 20);
  flee2 = new Flee(Player2, 20.0, 100.0, 100.0, 10.0);
  
  // Add the behaviour to the agent
  Player1.behaviours.add(seek1);
  Player2.behaviours.add(flee2);
  
  seek1.target = Player2.position;
  flee2.target = Player1.position;
  Player2.behaviours.add(new WallDetection(Player2,100.,30));

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
    Player1.update();
    Player2.update();
  }
  
  // Draw the agent
  Player1.draw();
  Player2.draw();
  
  // Draw the information panel
  if (showInfo) drawInfoPanel();

}
  
// Draw the information panel!
void drawInfoPanel() {
  pushStyle(); // Push current drawing style onto stack
  fill(0);
  int base = 20;
  text("1 - toggle display", 10, 20);
  text("2 - toggle annotation", 10, 35);
  text("Space - play/pause", 10, 50);
  text("Mass (q/a) = " + Player1.mass, 10, 65);
  text("Max. Force (w/s) = " + Player1.maxForce, 10, 80);
  text("Max. Speed (e/d) = " + Player1.maxSpeed, 10, 95);
  popStyle(); // Retrieve previous drawing style
}

/*
 * Input handlers
 */

// Mouse clicked, so move the target
void mouseClicked() {
     seek1.target = new PVector(mouseX, mouseY);
     flee2.target = new PVector(mouseX, mouseY);
}

// Key pressed
void keyPressed() {
   if (key == ' ') {
     togglePause();
     
   } else if (key == '1' || key == '!') {
     toggleInfo();
     
   } else if (key == '2' || key == '@') {
     Player1.toggleAnnotate();
     
     // Vary the agent's mass
   } else if (key == 'q' || key == 'Q') {
     Player1.incMass();
     
   } else if (key == 'a' || key == 'A') {
     Player1.decMass();
     
     // Vary the agent's maximum force
   } else if (key == 'w' || key == 'W') {
     Player1.incMaxForce();
   } else if (key == 's' || key == 'S') {
     Player1.decMaxForce();
     

     // Vary the agent's maximum speed
   } else if (key == 'e' || key == 'E') {
     Player1.incMaxSpeed();
     
   } else if (key == 'd' || key == 'D') {
     Player1.decMaxSpeed();
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

