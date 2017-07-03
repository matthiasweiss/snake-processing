// size of every grid (20x20)
int grid = 20;

Snake snake = new Snake();
PVector food;

void settings() {
  size(400,400);
}

void setup() {
  frameRate(10);
  changeFoodLocation();
}

void draw() {
  // draw the bg, the food and the snake
  background(50);
  
  fill(200,50,50);
  rect(food.x, food.y, grid, grid);
  
  snake.update();
  snake.eat(food);
  snake.show();
}

// get random location on the grid
void changeFoodLocation() {
  int randX = (int) Math.floor(height/grid*Math.random());
  int randY = (int) Math.floor(height/grid*Math.random());
  food = new PVector(randX * grid, randY*grid);
}

// control the direction of the player
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && snake.yv < 1) {
      snake.go(0,-1);
    } else if (keyCode == DOWN && snake.yv > -1) {
      snake.go(0,1);
    } else if (keyCode == LEFT && snake.xv > -1) {
      snake.go(-1,0);
    } else if (keyCode == RIGHT && snake.xv < 1) {
      snake.go(1,0);
    }
  }
}


// the Snake itself
class Snake {
  
  int xv = 1;
  int yv = 0;
  
  PVector head;
  
  ArrayList<PVector> tail = new ArrayList<PVector>();
  
  Snake() {
    this.tail.add(new PVector(0, 0));
    this.head = this.tail.get(this.tail.size() - 1);
  }
  
  void update() {     
    // shift the coordinates in the list
    for (int i = 0; i < this.tail.size() - 1; i++) {
      PVector p = this.tail.get(i);
      PVector next = this.tail.get(i+1);
      p.x = next.x;
      p.y = next.y;
    }
    
    // move the head
    this.head.x += this.xv*grid;
    this.head.y += this.yv*grid;
    
    // draw every item in the list
    for (PVector p: this.tail) {
      rect(p.x, p.y, grid, grid); 
    }
    
    // let snake appear if it is off the screen
    if (this.head.x > width) this.head.x = 0;
    if (this.head.x < 0) this.head.x = width;
    if (this.head.y > height) this.head.y = 0;
    if (this.head.y < 0) this.head.y = height;
    
    // check if the snake hits itself
    this.gameover();
  }
  
  // if the head hits one of the items in the tail remove everything
  void gameover() {
    for (int i = 0; i < this.tail.size() - 1; i++) {
      PVector p = this.tail.get(i);
      if (dist(p.x, p.y, this.head.x, this.head.y) < 1) {
        PVector temp = this.head;
        this.tail.clear();
        this.tail.add(temp);
        this.head = temp;
      }
    }
  }
  
  void show() {
    fill(240);
    for (PVector p: this.tail) {
      rect(p.x, p.y, grid, grid);
    }
  }
  
  void eat(PVector food) {
    if (dist(this.head.x, this.head.y, food.x, food.y) < 1) {
      this.tail.add(0, new PVector(this.head.x + xv*grid, this.head.y + yv*grid));
      changeFoodLocation();
    }
  }
  
  void go(int x, int y) {
    this.xv = x;
    this.yv = y;
  }
}