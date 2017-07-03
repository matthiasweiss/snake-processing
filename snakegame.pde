int grid = 20;

Snake snake = new Snake();
PVector food;

void setup() {
  size(400,400);
  frameRate(10);
  setFoodLocation();
}

void draw() {
  background(50);
  
  fill(200,50,50);
  rect(food.x, food.y, grid, grid);
  
  fill(240);
  snake.update();
  snake.gameover();
  snake.eat(food);
  snake.show();
}

// get random location on the grid
void setFoodLocation() {
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