class Resource {
float x, y;
int value;
int size = 10; 

  Resource(float x, float y, int value) {
    this.x = x;
    this.y = y;
    this.value = value; 
  }

  void update(){
    display();
    if(dist(x,y, player.x, player.y) < size){
      player.addResources(this.value);
      this.value = 0; 
    }
  }

  void display() {
    fill(0, 255, 0);
    ellipse(x, y, size, size);
  }

  int getValue(){
    return this.value;
  }
}


