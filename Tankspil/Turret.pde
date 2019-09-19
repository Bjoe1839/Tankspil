class Turret {

  PVector location, aim;
  int shootAt;
  

  Turret() {
    location = new PVector(random(50, width-50), random(height/6, height-50));
    shootAt = round(random(180));
  }

  void shoot() {
    int target = ceil(random(2));
    PVector t;
    if (target == 1) t = p1.location.copy();
    else t = p2.location.copy();

    aim = PVector.sub(t, location);
    
    bullets.add(new Bullet(location, round(degrees(aim.heading()))-90, 10, 100));
  }

  boolean collision() {
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).lifespan < 95) {
        if (dist(bullets.get(i).location.x, bullets.get(i).location.y, location.x, location.y) < 58) {
          bullets.remove(bullets.get(i));
          score += 5;
          return true;
        }
      }
    }
    return false;
  }


  void display() {
    image(tImg, location.x, location.y);
  }
}
