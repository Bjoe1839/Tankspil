class Player {

  PImage img;

  PVector location, velocity;
  int angle;

  Player(PVector loc, PImage image) {
    location = loc;
    img = image;
  }

  void move(int f) {
    velocity = new PVector(cos(radians(angle+90)), sin(radians(angle+90)));
    velocity.mult(f*5);
    location.add(velocity);
    
    if (location.x > width || location.x < 0) location.sub(velocity);
    if (location.y > height || location.y < 0) location.sub(velocity);
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(angle));
    image(img, 0, 0, 100, 100);
    popMatrix();
  }
}
