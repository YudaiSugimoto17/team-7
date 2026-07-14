Game game;

void setup() {
  size(1280, 720);
  game = new Game();
}

void draw() {
  game.update();
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}
