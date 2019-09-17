import processing.sound.*;
SoundFile driving;

Player p1, p2;

boolean p1L, p1R, p1U, p1D; //hvis wasd er trykkede
boolean p2L, p2R, p2U, p2D; //hvis piletasterne er trykkede

boolean played;

void setup() {
  fullScreen();
  noCursor();
  imageMode(CENTER);
  fill(0);

  driving = new SoundFile(this, "Tank_Driving.mp3");

  p1 = new Player(new PVector(width/4, height/2), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width*3/4, height/2), loadImage("Rødtank.png"));
}

void draw() {
  background(255);
  movePlayers();
  
  //spiller lyd hvis en af tankene kører frem eller tilbage 
  if (p1U || p1D || p2U || p2D || p1R || p1L || p2R || p2L) {
    if (!played) {
      driving.loop();
      played = true;
    }
  } else {
    driving.stop();
    played = false;
  }
  
  p1.display();
  p2.display();
}

void movePlayers() {
  if (p1L) p1.angle -= 3;
  if (p1R) p1.angle += 3;
  if (p1U) p1.move(1);
  if (p1D) p1.move(-1);


  if (p2L) p2.angle -= 3;
  if (p2R) p2.angle += 3;
  if (p2U) p2.move(1);
  if (p2D) p2.move(-1);
}


void keyPressed() {
  switch(key) {
  case 'a':
  case 'A':
    p1L = true;
    break;
  case 'd':
  case 'D':
    p1R = true;
    break;
  case 'w':
  case 'W':
    p1U = true;
    break;
  case 's':
  case 'S':
    p1D = true;
    break;
  }
  switch(keyCode) {
  case LEFT:
    p2L = true;
    break;
  case RIGHT:
    p2R = true;
    break;
  case UP:
    p2U = true;
    break;
  case DOWN:
    p2D = true;
    break;
  }
}



void keyReleased() {
  switch(key) {
  case 'a':
  case 'A':
    p1L = false;
    break;
  case 'd':
  case 'D':
    p1R = false;
    break;
  case 'w':
  case 'W':
    p1U = false;
    break;
  case 's':
  case 'S':
    p1D = false;
    break;
  }
  switch(keyCode) {
  case LEFT:
    p2L = false;
    break;
  case RIGHT:
    p2R = false;
    break;
  case UP:
    p2U = false;
    break;
  case DOWN:
    p2D = false;
    break;
  }
}
