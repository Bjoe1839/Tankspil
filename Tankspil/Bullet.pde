class Bullet {
  
  PVector location, velocity;
  int lifespan;
  color c;
  
  Bullet(PVector loc, int angle, int speed, color col) {

    location = loc.copy();
    velocity = new PVector(cos(radians(angle+90)),sin(radians(angle+90)));
    velocity.mult(speed);
    
    lifespan = 100;
    
    c = col;
  }
  
  void move() {
    location.add(velocity);
    
    if (location.x +8 >= width) {
      velocity.x = -velocity.x;
      location.x = width-8;
    }
    if (location.x -8 <= 0) {
      velocity.x = -velocity.x;
      location.x = 8;
    }
    if (location.y +8 >= height) {
      velocity.y = -velocity.y;
      location.y = height-8;
    }
    if (location.y -8 <= height/10) {
      velocity.y = -velocity.y;
      location.y = height/10+8;
    }
    
    lifespan--; //<>//
  }
  
  void display() {
    noStroke();
    fill(c);
    circle(location.x, location.y, 16);
  }
}
