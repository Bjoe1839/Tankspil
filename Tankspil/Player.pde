class Player {

  PImage img;

  PVector location, velocity;
  int angle;
  
  int cooldown;

  Player(PVector loc, PImage image) {
    location = loc;
    img = image;
  }

  void move(int f) {
    velocity = new PVector(cos(radians(angle+90)), sin(radians(angle+90)));
    velocity.mult(f*7);
    location.add(velocity);

    if (location.x + 65 > width) location.sub(velocity);
    if (location.x - 65 < 0) location.sub(velocity);
    if (location.y + 65 > height) location.sub(velocity);
    if (location.y - 65 < 0) location.sub(velocity);
  }

  void collision() {
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).lifespan < 95) { //der skal gå noget tid før et bullet kan ramme noget fordi det spawner fra en player
        if (dist(bullets.get(i).location.x, bullets.get(i).location.y, location.x, location.y) < 58) {
          bullets.remove(bullets.get(i));
          score -= 3;
          oof.play();
        }
      }
    }
    
    cooldown--;
    if (cooldown < 0) cooldown = 0;
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(angle));
    image(img, 0, 0, 100, 100);
    popMatrix();
    
    //cooldown bar
    float c = map(cooldown, 0, 30, -50, 50);
    stroke(0, 255, 0);
    strokeWeight(5);
    line(location.x-50, location.y-70, location.x-c, location.y-70);
  }
}
