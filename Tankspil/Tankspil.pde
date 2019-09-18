import processing.sound.*;
SoundFile driving;

Player p1, p2;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Turret> turrets = new ArrayList<Turret>();

PImage tImg;

boolean p1L, p1R, p1U, p1D; //hvis wasd er trykkede
boolean p2L, p2R, p2U, p2D; //hvis piletasterne er trykkede

boolean played;

int score = 20, timer = 180, goal = 100, level = 1;

PFont font; 

void setup() {
  fullScreen();
  noCursor();
  imageMode(CENTER);
  textAlign(CENTER, TOP);
  //textSize(25);
  fill(0);
  font = loadFont("Digitaltech-rm0K.vlw");
  textFont(font, 45);
  tImg = loadImage("Turret.gif");

  driving = new SoundFile(this, "Tank_Driving.mp3");

  p1 = new Player(new PVector(width/4, height/2), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width*3/4, height/2), loadImage("Rødtank.png"));
}

void draw() {
  background(255);

  //bullets
  for (int i = bullets.size()-1; i >= 0; i--) {
    bullets.get(i).move();
    if (bullets.get(i).lifespan > 0) bullets.get(i).display();
    else bullets.remove(bullets.get(i));
  }


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


  p1.collision();
  p2.collision();


  p1.display();
  p2.display();
  
  if (frameCount%180 == 0) turrets.add(new Turret());
  
  for (int i = turrets.size()-1; i >= 0; i--) {
    if (frameCount%180 == 60) turrets.get(i).shoot();
    if (turrets.get(i).collision()) turrets.remove(turrets.get(i));
    else turrets.get(i).display();
  }

  if (frameCount%60 == 0) timer--;
  if (timer < 0) gameOver();
  if (frameCount%120 == 0) score--;
  if (score < 0) score = 0;

  text("Goal: "+goal+"\nScore: "+score, width/16, height/30);
  text("Time Left: "+timer, width/2, height/30);
  text("Level: "+level, width-width/16, height/30);
}

void movePlayers() {
  if (p1L) p1.angle -= 5;
  if (p1R) p1.angle += 5;
  if (p1U) p1.move(1);
  if (p1D) p1.move(-1);


  if (p2L) p2.angle -= 5;
  if (p2R) p2.angle += 5;
  if (p2U) p2.move(1);
  if (p2D) p2.move(-1);
}


void keyPressed() {
  switch(keyCode) {
  case 'A':
    p1L = true;
    break;
  case 'D':
    p1R = true;
    break;
  case 'W':
    p1U = true;
    break;
  case 'S':
    p1D = true;
    break;
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

  case ' ':
    bullets.add(new Bullet(p1.location, p1.angle, 20, 100));
    break;
  case ENTER:
    bullets.add(new Bullet(p2.location, p2.angle, 20, 100));
    break;
  }
}


void keyReleased() {
  switch(keyCode) {
  case 'A':
    p1L = false;
    break;
  case 'D':
    p1R = false;
    break;
  case 'W':
    p1U = false;
    break;
  case 'S':
    p1D = false;
    break;
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


void gameOver() {
}
