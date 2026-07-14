PFont font;
Game game;

void setup() {
  size(1280, 720);
  font = createFont("MS Gothic", 24);
  textFont(font);
  game = new Game();
}

void draw() {
  game.update();
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}
