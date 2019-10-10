class Crater {
  
  PVector location;
  int lifespan, angle;
  
  Crater(PVector loc) {
    location = loc.copy();
    
    lifespan = 255;
    angle = round(random(360));
  }
  
  void check() {
    lifespan--;
    if (lifespan <= 0) craters.remove(this);
  }
  
  void display() {
    pushMatrix();
    tint(255, lifespan);
    translate(location.x, location.y);
    rotate(radians(angle));
    image(cImg, 0, 0, 100, 100);
    noTint();
    popMatrix();
  }
  
}
