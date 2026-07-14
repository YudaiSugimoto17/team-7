class ModalManager {

  boolean visible;
  String message;

  ModalManager() {
    visible = false;
    message = "";
  }

  void show(String msg) {
    visible = true;
    message = msg;
  }

  void hide() {
    visible = false;
  }

  void draw() {

    if (!visible) return;

    fill(0, 180);
    rect(100, 450, 600, 120);

    fill(255);
    textAlign(CENTER, CENTER);
    text(message, 400, 510);
  }
}