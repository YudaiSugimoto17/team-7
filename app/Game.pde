class Game {

  SceneManager sceneManager;
  StageManager stageManager;
  FlagManager flagManager;
  ModalManager modalManager;

  Game() {
    sceneManager = new SceneManager();
    stageManager = new StageManager();
    flagManager = new FlagManager();
    modalManager = new ModalManager();
  }

  void update() {

  }

  void draw() {

    switch(sceneManager.getCurrentScene()) {

    case SceneManager.TITLE:
      drawTitle();
      break;

    case SceneManager.HUB:
      drawHub();
      break;

    case SceneManager.ROOM:
      drawRoom();
      break;

    case SceneManager.ALL_CLEAR:
      drawAllClear();
      break;
    }
  }

  void mousePressed() {

    if (sceneManager.getCurrentScene() == SceneManager.TITLE) {
      sceneManager.changeScene(SceneManager.HUB);
    }
  }

  void drawTitle() {

    background(50);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);

    text("脱出ゲーム", width / 2, height / 2);
    textSize(20);
    text("クリックして開始", width / 2, height / 2 + 70);
  }

  void drawHub() {

    background(180);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);

    text("廊下", width / 2, 100);
  }

  void drawRoom() {

    background(120);

    fill(255);
    textSize(40);

    text("ROOM", width / 2, height / 2);
  }

  void drawAllClear() {

    background(0);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);

    text("脱出成功！", width / 2, height / 2);
  }
}
