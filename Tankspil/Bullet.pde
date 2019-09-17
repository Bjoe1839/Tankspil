class Bullet {
  
  PVector location, velocity;
  
  Bullet(PVector loc, PVector vel, int speed) {
    location = loc;
    velocity = vel;
    velocity.mult(speed);
  }
  
  void move() {
    location.add(velocity);
  }
  
  void display() {
    circle(location.x, location.y, 5);
  }
}
