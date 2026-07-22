class Game {

  SceneManager sceneManager;
  StageManager stageManager;
  FlagManager flagManager;
  ModalManager modalManager;
  Inventory inventory;
  TextBox textBox;
  PImage hubBg;

  Game() {
    sceneManager = new SceneManager();
    stageManager = new StageManager();
    flagManager = new FlagManager();
    modalManager = new ModalManager();
    inventory = new Inventory();
    textBox = new TextBox();

    hubBg = loadImage("hallway.jpeg");
    if (hubBg == null) println("★警告: data/hallway.jpeg が読み込めません（ファイルが無いか名前違い）");
  }

  void update() {

    if (sceneManager.getCurrentScene() == SceneManager.ROOM &&
      stageManager.getCurrentStage() != null) {

      stageManager.getCurrentStage().update();

      // 理科室（StageRoom1）クリア
      if (stageManager.getCurrentStage() instanceof StageRoom1 &&
        stageManager.getCurrentStage().isCleared() &&
        !flagManager.hasExitKey1) {

        flagManager.room1Cleared = true;
        flagManager.hasExitKey1 = true;

        modalManager.show("非常口の鍵①を手に入れた");

        stageManager.clearStage();
        sceneManager.changeScene(SceneManager.HUB);
      }

      // 図書室（StageRoom2）クリア
      if (stageManager.getCurrentStage() instanceof StageRoom2 &&
        stageManager.getCurrentStage().isCleared() &&
        !flagManager.hasExitKey2) {

        flagManager.room2Cleared = true;
        flagManager.hasExitKey2 = true;

        modalManager.show("非常口の鍵②を手に入れた");

        stageManager.clearStage();
        sceneManager.changeScene(SceneManager.HUB);
      }
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

    // 持ち物欄・会話ウィンドウは部屋の中でのみ表示
    if (sceneManager.getCurrentScene() == SceneManager.ROOM) {
      inventory.draw();
      textBox.draw();
    }

    modalManager.draw();
  }

  void mousePressed() {

    // 会話ウィンドウ表示中はそちらのクリックを最優先する
    if (textBox.isVisible) {
      textBox.handleClick(mouseX, mouseY);
      return;
    }

    // モーダルが表示中なら閉じる
    if (modalManager.visible) {
      modalManager.hide();
      return;
    }

    // タイトル
    if (sceneManager.getCurrentScene() == SceneManager.TITLE) {
      sceneManager.changeScene(SceneManager.HUB);
      return;
    }

    // HUB（廊下）
    if (sceneManager.getCurrentScene() == SceneManager.HUB) {

      // 図書室（StageRoom2の内容：本棚・紙・鍵）
      if (mouseX >= 150 && mouseX <= 400 &&
        mouseY >= 250 && mouseY <= 350) {

        if (flagManager.room2Cleared) {
          modalManager.show("図書室はもう調べ終えた");
          return;
        }
        enterStage(new StageRoom2());
        return;
      }

      // 理科室（StageRoom1の内容：薬品棚・ビーカー）
      if (mouseX >= 500 && mouseX <= 750 &&
        mouseY >= 250 && mouseY <= 350) {

        if (flagManager.room1Cleared) {
          modalManager.show("理科室はもう調べ終えた");
          return;
        }
        enterStage(new StageRoom1());
        return;
      }

      // 非常口
      if (mouseX >= 850 && mouseX <= 1100 &&
        mouseY >= 250 && mouseY <= 350) {

        if (flagManager.canEscape()) {

          sceneManager.changeScene(
            SceneManager.ALL_CLEAR
            );
        } else {

          modalManager.show(
            "非常口を開けるには鍵が2つ必要だ"
            );
        }
        return;
      }
    }

    // ROOM（部屋の中）
    if (sceneManager.getCurrentScene() == SceneManager.ROOM &&
      stageManager.getCurrentStage() != null) {

      // 持ち物欄をクリックした場合、選択されたアイテムを部屋に通知する
      if (inventory.handleClick(mouseX, mouseY)) {
        Item selected = inventory.getSelectedItem();
        if (selected != null) {
          stageManager.getCurrentStage().onInventoryItemClicked(selected);
          // 選択状態をここで解除する。selectSlot()はクリックのたびに
          // 選択ON/OFFをトグルする仕組みなので、解除しないままだと
          // 同じアイテムを2回目にクリックした時に「選択解除」の方の
          // トグルになってしまい、onInventoryItemClickedが呼ばれず
          // 何度でも見返せない不具合になっていた。
          inventory.clearSelection();
        }
        return;
      }

      // 「戻る」ボタン（画面右下）
      if (mouseX >= width - 140 && mouseX <= width - 20 &&
        mouseY >= height - 70 && mouseY <= height - 20) {

        stageManager.clearStage();
        sceneManager.changeScene(SceneManager.HUB);
        return;
      }

      stageManager.getCurrentStage().mousePressed();
    }
  }

  // 部屋に入る際、共有のInventory/TextBoxを結線してからStageManagerに渡す
  void enterStage(Stage stage) {
    stage.inventory = inventory;
    stage.textBox = textBox;
    stageManager.setStage(stage);
    sceneManager.changeScene(SceneManager.ROOM);
  }

  void drawTitle() {

    background(50);

    fill(255);

    textAlign(CENTER, CENTER);
    textSize(50);

    text("脱出ゲーム", width/2, height/2);

    textSize(20);
    text("クリックして開始", width/2, height/2 + 60);
  }

  void drawHub() {

    if (hubBg != null) {
      image(hubBg, 0, 0, width, height);
    } else {
      background(180);
    }

    fill(255);
    stroke(0);
    strokeWeight(2);

    textAlign(CENTER, CENTER);
    textSize(40);

    text("廊下", width/2, 100);
    noStroke();

    fill(220);
    stroke(0);
    strokeWeight(1);

    rect(150, 250, 250, 100);
    rect(500, 250, 250, 100);
    rect(850, 250, 250, 100);
    noStroke();

    fill(0);

    textSize(30);

    text("図書室", 275, 300);
    text("理科室", 625, 300);
    text("非常口", 975, 300);

    // クリア済みの部屋には印を出す
    fill(0, 150, 0);
    textSize(16);
    if (flagManager.room2Cleared) text("（調査済み）", 275, 330);
    if (flagManager.room1Cleared) text("（調査済み）", 625, 330);
  }

  void drawRoom() {

    if (stageManager.getCurrentStage() != null) {
      stageManager.getCurrentStage().draw();
    }

    fill(220);
    rect(width - 140, height - 70, 120, 50);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);

    text("戻る", width - 80, height - 45);
  }

  void drawAllClear() {

    background(0);

    fill(255);

    textAlign(CENTER, CENTER);
    textSize(50);

    text("脱出成功！", width/2, height/2);
  }
}
