 import processing.sound.*;
SoundFile driving, pew1, pew2, oof;

Player p1, p2;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Turret> turrets = new ArrayList<Turret>();

PImage tImg; //turret
PImage gameOver, levelUpImg, win, background, tree;

boolean p1L, p1R, p1U, p1D; //hvis wasd er trykkede
boolean p2L, p2R, p2U, p2D; //hvis piletasterne er trykkede

boolean drivingPlays;

int score = 10, timer = 90, goal = 50, level = 1, turretsEvery = 180;
boolean levelUp;

PFont font; 

void setup() {
  fullScreen();
  noCursor();
  imageMode(CENTER);
  textAlign(CENTER, TOP);
  fill(0);
  font = loadFont("Digitaltech-rm0K.vlw");
  textFont(font, 45);
  tImg = loadImage("Turret.gif");
  gameOver = loadImage("Game Over.png");
  levelUpImg = loadImage("Level Up.png");
  win = loadImage("You Win.png");
  background = loadImage("Background.png");
  tree = loadImage("Tree.png");

  driving = new SoundFile(this, "Tank_Driving.wav");
  pew1 = new SoundFile(this, "Pew Pew.wav");
  pew2 = new SoundFile(this, "Pew Pew.wav");
  oof = new SoundFile(this, "deathsound.wav");
  p1 = new Player(new PVector(width/4, height/2), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width*3/4, height/2), loadImage("Rødtank.png"));
}


void draw() {
  background(background);
  

  if (levelUp) {
    image(levelUpImg, width/2, height/2);
    text("Press mousebutton to continue", width/2, height/2+height/8);
  } else {

    //bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      bullets.get(i).move();
      if (bullets.get(i).lifespan > 0) bullets.get(i).display();
      else bullets.remove(bullets.get(i));
    }


    movePlayers();

    //spiller lyd hvis en af tankene kører frem eller tilbage 
    if (p1U || p1D || p2U || p2D || p1R || p1L || p2R || p2L) {
      if (!drivingPlays) {
        driving.loop();
        drivingPlays = true;
      }
    } else {
      driving.stop();
      drivingPlays = false;
    }


    p1.collision();
    p2.collision();


    p1.display();
    p2.display();
    
    image(tree,width/3*2,height/2); // Displays tree on top of tanks so tanks can move "through" tree
    image(tree,width/3*2+100,height/2-100);
    image(tree,width/3*2+100,height/2+100);
    image(tree,width/3*2-75,height/2+50);

    if (frameCount%turretsEvery == 0) turrets.add(new Turret());

    for (int i = turrets.size()-1; i >= 0; i--) {
      if (frameCount%180 == turrets.get(i).shootAt) turrets.get(i).shoot();
      if (turrets.get(i).collision()) turrets.remove(turrets.get(i));
      else turrets.get(i).display();
    }

    if (frameCount%60 == 0) timer--;
    if (timer <= 0) gameOver();
    if (frameCount%120 == 0) score--;
    if (score < 0) score = 0;

    text("Goal: "+goal+"\nScore: "+score, width/16, height/30);
    text("Time Left: "+timer, width/2, height/30);
    text("Level: "+level, width-width/16, height/30);

    //score bar
    fill(0, 255, 0);
    noStroke();
    float c = map(score, 0, goal, 0, 200);
    rect(width/32, height/7, c, 20);
    stroke(0);
    noFill();
    rect(width/32, height/7, 200, 20);
    fill(0);
    
    if (score >= goal) {
      if (level == 1) levelUp = true;
      else {
        image(win, width/2, height/2, width/2, height/2);
        noLoop();
      }
    }
  }
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
    if (p1.cooldown == 0) {
      bullets.add(new Bullet(p1.location, p1.angle, 20, 100));
      pew1.play();
      p1.cooldown = 30;
    }
    break;
  case ENTER:
    if (p2.cooldown == 0) {
      bullets.add(new Bullet(p2.location, p2.angle, 20, 100));
      pew2.play();
      p2.cooldown = 30;
      break;
    }
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
  image(gameOver, width/2, height/2, width/3, height/3);
  noLoop();
}


void mousePressed() {
  if (levelUp) {
    goal = 100;
    timer = 90;
    score = 20;
    level = 2;
    turretsEvery = 90;

    levelUp = false;
  }
}
