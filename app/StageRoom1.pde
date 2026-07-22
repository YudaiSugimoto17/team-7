class StageRoom1 extends Stage {
  boolean memoRead = false;       // メモを読んだ
  boolean cabinetOpened = false;  // 薬品棚を調べた
  boolean drawerOpened = false;   // 引き出しが開いた
  boolean cleared = false;        // 部屋クリア
  int answerStep = 0;

  PImage bg;
  PImage beakerBlue;
  PImage beakerRed;
  PImage beakerYellow;
  PImage keyImg;

  // メモ（左の実験台の上の小さな紙）
  int memoX = 130, memoY = 460, memoW = 40, memoH = 40;

  // 薬品棚（画像内の実際のガラス扉キャビネット部分。図形は描かず透明な当たり判定のみ）
  int cabinetX = 700, cabinetY = 130, cabinetW = 330, cabinetH = 420;

  // ビーカー3つ（右の実験台の上に並べる）
  int beaker1X = 600, beaker1Y = 500;  // 青
  int beaker2X = 760, beaker2Y = 500;  // 赤
  int beaker3X = 920, beaker3Y = 500;  // 黄

  // 鍵（正解後に出現）
  int keyX = 900, keyY = 460;

  // クリック可能領域をHotspotクラスで管理する。
  Hotspot memoHotspot;
  Hotspot cabinetHotspot;
  Hotspot beaker1Hotspot;
  Hotspot beaker2Hotspot;
  Hotspot beaker3Hotspot;
  Hotspot keyHotspot;

  StageRoom1() {
    bg = loadImage("science room.jpg");
    beakerBlue = loadImage("ビーカー青.png");
    beakerRed = loadImage("ビーカー赤.png");
    beakerYellow = loadImage("ビーカー黄.png");
    keyImg = loadImage("key.png");

    if (bg == null) println("★警告: data/science room.jpg が読み込めません（ファイルが無いか名前違い）");
    if (beakerBlue == null) println("★警告: data/ビーカー青.png が読み込めません");
    if (beakerRed == null) println("★警告: data/ビーカー赤.png が読み込めません");
    if (beakerYellow == null) println("★警告: data/ビーカー黄.png が読み込めません");
    if (keyImg == null) println("★警告: data/key.png が読み込めません");

    memoHotspot    = new Hotspot("memo", memoX, memoY, memoW, memoH);
    cabinetHotspot = new Hotspot("cabinet", cabinetX, cabinetY, cabinetW, cabinetH);
    beaker1Hotspot = new Hotspot("beaker1", beaker1X - 35, beaker1Y - 35, 70, 70);
    beaker2Hotspot = new Hotspot("beaker2", beaker2X - 35, beaker2Y - 35, 70, 70);
    beaker3Hotspot = new Hotspot("beaker3", beaker3X - 35, beaker3Y - 35, 70, 70);
    keyHotspot     = new Hotspot("key", keyX - 40, keyY - 40, 80, 80);
  }

  void update() {
  }

  void draw() {
    if (bg != null) {
      image(bg, 0, 0, width, height);
    } else {
      background(210);
    }

    fill(255);
    stroke(0);
    textSize(30);
    text("理科室", 330, 50);
    noStroke();

    if (!memoRead) {
      fill(255);
      stroke(120);
      rect(memoX, memoY, memoW, memoH);
      noStroke();
    }

    imageMode(CENTER);
    if (beakerBlue != null)   image(beakerBlue, beaker1X, beaker1Y, 70, 70);
    else { fill(0, 0, 255); ellipse(beaker1X, beaker1Y, 40, 40); }

    if (beakerRed != null)    image(beakerRed, beaker2X, beaker2Y, 70, 70);
    else { fill(255, 0, 0); ellipse(beaker2X, beaker2Y, 40, 40); }

    if (beakerYellow != null) image(beakerYellow, beaker3X, beaker3Y, 70, 70);
    else { fill(255, 255, 0); ellipse(beaker3X, beaker3Y, 40, 40); }
    imageMode(CORNER);

    if (drawerOpened && !cleared) {
      float pulse = (sin(frameCount * 0.08) + 1) / 2;
      noFill();
      stroke(255, 255, 100, 100 + pulse * 100);
      strokeWeight(3 + pulse * 3);
      ellipse(keyX, keyY, 60 + pulse * 20, 60 + pulse * 20);
      noStroke();

      if (keyImg != null) {
        imageMode(CENTER);
        image(keyImg, keyX, keyY, 40, 40);
        imageMode(CORNER);
      } else {
        fill(255, 255, 0);
        ellipse(keyX, keyY, 20, 20);
      }
    }
  }

  void mousePressed() {

    if (!memoRead) {
      if (memoHotspot.contains(mouseX, mouseY)) {

        memoRead = true;
        textBox.showMessages(null, new String[]{"メモには『薬品棚を調べよ』と書かれている"});
        return;
      }
    }

    if (memoRead && !cabinetOpened) {
      if (cabinetHotspot.contains(mouseX, mouseY)) {

        cabinetOpened = true;
        textBox.showMessages(null, new String[]{"薬品棚に『青→赤→黄』と書かれたラベルを見つけた"});
        return;
      }
    }

    if (cabinetOpened && !drawerOpened) {

      if (beaker1Hotspot.contains(mouseX, mouseY)) {
        if (answerStep==0) answerStep=1;
        else answerStep=0;
      }

      if (beaker2Hotspot.contains(mouseX, mouseY)) {
        if (answerStep==1) answerStep=2;
        else answerStep=0;
      }

      if (beaker3Hotspot.contains(mouseX, mouseY)) {
        if (answerStep==2) {
          drawerOpened=true;
          textBox.showMessages(null, new String[]{"正解だ！実験台の上に鍵が現れた！"});
        } else {
          answerStep=0;
        }
      }
    }

    if (drawerOpened && !cleared) {
      if (keyHotspot.contains(mouseX, mouseY)) {

        cleared=true;
        inventory.addItem(new Item("key1", "非常口の鍵①", keyImg));
      }
    }
  }

  boolean isCleared() {
    return cleared;
  }

  void onInventoryItemClicked(Item item) {
    if (item.id.equals("key1")) {
      textBox.showMessages(null, new String[]{"非常口の鍵①だ。理科室の引き出しで見つけた。"});
    }
  }
}
