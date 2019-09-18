class Bullet {
  
  PVector location, velocity;
  int lifespan;
  
  Bullet(PVector loc, int angle, int speed, int ls) {
    location = loc.copy();
    velocity = new PVector(cos(radians(angle+90)),sin(radians(angle+90)));
    velocity.mult(speed);
    
    lifespan = ls;
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
    if (location.y -8 <= 0) {
      velocity.y = -velocity.y;
      location.y = 8;
    }
    
    lifespan--; //<>//
    println(lifespan);
  }
  
  void display() {
    circle(location.x, location.y, 16);
  }
}
