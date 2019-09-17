class Player {
  
  PImage img;
  
  PVector location, velocity;
  int angle;
  
  Player(PVector loc, PImage image) {
    location = loc;
    img = image;
  }
  
  void move() {
    
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(angle));
    image(img, 0, 0, 100, 100);
    popMatrix();
  }
  
}
