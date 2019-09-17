Player p1, p2;

boolean p1L, p1R, p1U, p1D; //hvis wasd er trykkede
boolean p2L, p2R, p2U, p2D; //hvis piletasterne er trykkede

void setup() {
  fullScreen();
  imageMode(CENTER);

  p1 = new Player(new PVector(width/4, height/2), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width*3/4, height/2), loadImage("Rødtank.png"));
}

void draw() {
  background(255);
  movePlayers();

  p1.display();
  p2.display();
}

void movePlayers() {
  if (p1L) p1.angle--;
  if (p1R) p1.angle++;
  if (p1U) p1.move(1);
  if (p1D) p1.move(-1);
  
  
  
  if (p2L) p2.angle--;
  if (p2R) p2.angle++;
  if (p2U) ;
  if (p2D) ;
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
  }
  switch(keyCode) {
  case LEFT:
    p2L = true;
    break;
  case RIGHT:
    p2R = true;
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
  }
  switch(keyCode) {
  case LEFT:
    p2L = false;
    break;
  case RIGHT:
    p2R = false;
    break;
  }
}
