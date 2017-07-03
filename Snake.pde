class Snake {
  
  int xv = 1;
  int yv = 0;
  
  ArrayList<PVector> tail = new ArrayList<PVector>();
  
  Snake() {
    this.tail.add(new PVector(0, 0)); 
  }
  
  void update() {    
    this.head().x += this.xv*grid;
    this.head().y += this.yv*grid;
    
    // shift the coordinates in the list
    for (int i = 0; i < this.tail.size() - 1; i++) {
      PVector p = this.tail.get(i);
      PVector next = this.tail.get(i+1);
      p.x = next.x;
      p.y = next.y;
    }
    
    // draw every item in the list
    for (PVector p: this.tail) {
      rect(p.x, p.y, grid, grid); 
    }
    
    if (this.head().x > width) this.head().x = 0;
    if (this.head().x < 0) this.head().x = width;
    if (this.head().y > height) this.head().y = 0;
    if (this.head().y < 0) this.head().y = height;
  }
  
  // check if the snake hits itself
  void gameover() {
    for (int i = 0; i < this.tail.size() - 1; i++) {
      PVector p = this.tail.get(i);
      if (dist(this.head().x, this.head().y, p.x, p.y) < 5) {
        /* PVector tmp = this.head();
        this.tail.clear();
        this.tail.add(tmp); */
        println("LOST");
        
      }
    }
  }
  
  void show() {
    for (PVector p: this.tail) {
      rect(p.x, p.y, grid, grid);
    }
  }
  
  void eat(PVector food) {
    if (dist(this.head().x, this.head().y, food.x, food.y) < 5) {
      this.tail.add(0, new PVector(this.head().x + xv*grid, this.head().y + yv*grid));
      
      // global method
      setFoodLocation();
    }
  }
  
  void go(int x, int y) {
    this.xv = x;
    this.yv = y;
  }
  
  PVector head() {
    return this.tail.get(this.tail.size() - 1); 
  }
}