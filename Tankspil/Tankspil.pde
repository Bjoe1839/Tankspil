Player p1, p2;

void setup() {
  fullScreen();
  imageMode(CENTER);
  
  p1 = new Player(new PVector(width/4, height/2), loadImage("Blåtank.png"));
  p2 = new Player(new PVector(width*3/4, height/2), loadImage("Rødtank.png"));
}

void draw() {
  background(255);
  p1.display();
  p2.display();
}



void keyPressed() {
  switch(key) {
    case 'a':
    case 'A':
    println("TEST");
    break;
    
    
    
    
    
    
  }
  
}
