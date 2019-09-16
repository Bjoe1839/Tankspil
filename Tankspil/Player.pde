class Player {
  
  PImage img;
  
  PVector location, velocity;
  
  Player(PVector loc, PImage image) {
    location = loc;
    img = image;
  }
  
  void move() {
    
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    //rotate();
    image(img, 0, 0, 100, 100);
    popMatrix();
  }
  
}
