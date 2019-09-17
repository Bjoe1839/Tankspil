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
  if (p1L) {
    p1.angle--;
  }
  if (p2L) {
    p2.angle--;
  }
}


void keyPressed() {
  switch(key) {
  case 'a':
  case 'A':
    p1L = true;
    break;
  }
  switch(keyCode) {
  case LEFT:
    p2L = true;
    break;
  }
}



void keyReleased() {
  switch(key) {
  case 'a':
  case 'A':
    p1L = false;
    break;
  }
}
