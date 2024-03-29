import processing.sound.*;
SoundFile driving, pew1, pew2, hit;

Player p1, p2;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Turret> turrets = new ArrayList<Turret>();
ArrayList<Crater> craters = new ArrayList<Crater>();

PImage tImg, cImg; //turret og crater billede
PImage gameOver, levelUpImg, win, background, tree, water, startScreen;

boolean p1L, p1R, p1U, p1D; //hvis wasd er trykkede
boolean p2L, p2R, p2U, p2D; //hvis piletasterne er trykkede

boolean drivingPlays;

int score = 10, timer = 90, goal = 50, level = 1, turretsEvery = 180;
boolean levelUp, start = true;

PFont font;

void setup() {
  fullScreen();
  noCursor();
  imageMode(CENTER);
  textAlign(CENTER, TOP);
  fill(0);
  font = loadFont("Digitaltech-rm0K.vlw");
  textFont(font, 50);
  tImg = loadImage("Turret.gif");
  cImg = loadImage("Crater.png");
  gameOver = loadImage("Game Over.png");
  levelUpImg = loadImage("Level Up.png");
  win = loadImage("You Win.png");
  background = loadImage("Background.png");
  tree = loadImage("Tree.png");
  water = loadImage("Water.png");
  startScreen = loadImage("Startscreen.png");

  driving = new SoundFile(this, "Tank_Driving.wav");
  pew1 = new SoundFile(this, "Pew Pew.wav");
  pew2 = new SoundFile(this, "Pew Pew.wav");
  hit = new SoundFile(this, "Hitsound.wav");
  p1 = new Player(new PVector(width/4, height/4), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width/2, height-height/3), loadImage("Rødtank.png"));
}


void draw() {
  background(background);

  //manual
  if (start) {
    image(startScreen, width/2, height/2, width, height);
    //levelup
  } else if (levelUp) {
    image(water, width/2, height/2);
    image(levelUpImg, width/2, height/2);
    text("Press mousebutton to continue", width/2, height/2+height/8);
  } else {

    //bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      bullets.get(i).move();
      if (bullets.get(i).lifespan > 0) bullets.get(i).display();
      else bullets.remove(bullets.get(i));
    }
    
    //crater
    for (int i = craters.size()-1; i >= 0; i--) {
      craters.get(i).display();
      craters.get(i).check();
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


    if (frameCount%turretsEvery == 0) turrets.add(new Turret());

    //turrets
    for (int i = turrets.size()-1; i >= 0; i--) {
      if (frameCount%180 == turrets.get(i).shootAt) turrets.get(i).shoot();
      if (turrets.get(i).collision()) turrets.remove(turrets.get(i));
      else turrets.get(i).display();
    }

    //vandet er gennemsigtigt
    tint(255, 200);
    image(water, width/2, height/2);
    noTint();

    image(tree, width/3*2, height/2); // Displays tree on top of tanks so tanks can move "through" tree
    image(tree, width/3*2+100, height/2-100);
    image(tree, width/3*2+100, height/2+100);
    image(tree, width/3*2-75, height/2+50);

    if (frameCount%60 == 0) timer--;
    if (timer <= 0) gameOver();
    if (frameCount%120 == 0) score--;
    if (score < 0) score = 0;

    //background in top
    fill(0);
    noStroke();
    rect(0, 0, width, height/10);
    
    fill(255);
    
    text("Score: "+score+"/"+goal, width/16, height/30);
    text("Time Left: "+timer, width/2, height/30);
    text("Level: "+level, width-width/16, height/30);

    //score bar
    fill(0, 255, 0);
    float c = map(score, 0, goal, 0, 200);
    rect(width/8, height/27, c, 30);
    stroke(255);
    strokeWeight(1);
    noFill();
    rect(width/8, height/27, 200, 30);
    fill(0);

    if (score >= goal) {
      if (level == 1) {
        levelUp = true;
        driving.stop();
      } else {
        image(win, width/2, height/2, width/2, height/2);
        text("Press esc to exit", width/2, height/2+height/4);
        driving.stop();
        noLoop();
      }
    }
  }
}

void movePlayers() {
  if (p1L) p1.angle -= 4;
  if (p1R) p1.angle += 4;
  if (p1U) p1.move(1);
  if (p1D) p1.move(-1);


  if (p2L) p2.angle -= 4;
  if (p2R) p2.angle += 4;
  if (p2U) p2.move(1);
  if (p2D) p2.move(-1);
}


void keyPressed() {
  if (!levelUp) {
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
        bullets.add(new Bullet(p1.location, p1.angle, 20, color(0, 0, 200)));
        pew1.play();
        p1.cooldown = 30;
      }
      break;
    case ENTER:
      if (p2.cooldown == 0) {
        bullets.add(new Bullet(p2.location, p2.angle, 20, color(200, 0, 0)));
        pew2.play();
        p2.cooldown = 30;
        break;
      }
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
  text("Press esc to exit", width/2, height/2+height/5);
  driving.stop();
  noLoop();
}


void mousePressed() {
  if (start) {
    start = false;
  }
  if (levelUp) {
    for (int i = turrets.size()-1; i >= 0; i--) {
      turrets.remove(turrets.get(i));
    }

    goal = 100;
    timer = 90;
    score = 20;
    level = 2;
    turretsEvery = 60;

    levelUp = false;
  }
}
