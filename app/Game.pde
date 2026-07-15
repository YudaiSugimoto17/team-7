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

    if (sceneManager.getCurrentScene() == SceneManager.ROOM &&
        stageManager.getCurrentStage() != null) {

      stageManager.getCurrentStage().update();
    }
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

    // タイトル → HUB
    if (sceneManager.getCurrentScene() == SceneManager.TITLE) {
      sceneManager.changeScene(SceneManager.HUB);
      return;
    }

    // HUB
    if (sceneManager.getCurrentScene() == SceneManager.HUB) {

      // 図書室
      if (mouseX >= 150 && mouseX <= 400 &&
          mouseY >= 250 && mouseY <= 350) {

        stageManager.setStage(new Stage_room1());
        sceneManager.changeScene(SceneManager.ROOM);
        return;
      }

      // 理科室
      if (mouseX >= 500 && mouseX <= 750 &&
          mouseY >= 250 && mouseY <= 350) {

        stageManager.setStage(new Stage_room2());
        sceneManager.changeScene(SceneManager.ROOM);
        return;
      }

      // 非常口
      if (mouseX >= 850 && mouseX <= 1100 &&
          mouseY >= 250 && mouseY <= 350) {

        if (flagManager.canEscape()) {
          sceneManager.changeScene(SceneManager.ALL_CLEAR);
        } else {
          modalManager.show("鍵が足りない");
        }
        return;
      }
    }

  // ROOM
    if (sceneManager.getCurrentScene() == SceneManager.ROOM &&
        stageManager.getCurrentStage() != null) {

      stageManager.getCurrentStage().mousePressed();
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

    textAlign(CENTER, CENTER);

    fill(0);
    textSize(40);
    text("廊下", width / 2, 100);

    fill(220);

    rect(150, 250, 250, 100);
    rect(500, 250, 250, 100);
    rect(850, 250, 250, 100);

    fill(0);
    textSize(30);

    text("図書室", 275, 300);
    text("理科室", 625, 300);
    text("非常口", 975, 300);
  }

  void drawRoom() {

    if (stageManager.getCurrentStage() != null) {
      stageManager.getCurrentStage().draw();
    }
  }

  void drawAllClear() {

    background(0);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);

    text("脱出成功！", width / 2, height / 2);
  }
}
