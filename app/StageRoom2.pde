class StageRoom2 extends Stage {
  boolean paperRead = false;      // 紙を読んだ
  boolean booksChecked=false;
  boolean shelfOpened = false;    // 本棚が開いた
  boolean cleared = false;        // 部屋クリア
  boolean paper2Found = false;   // 2枚目の紙が落ちた
  boolean paper2Read = false;    // 2枚目の紙を読んだ
  String message = "";
  int answerStep = 0;
  PImage bg;
  PImage keyImg;
  PImage paperImg;
  PImage booksImg;
  PImage paper2Img;
  PImage memoImg;
  int screen = 0;

  Hotspot paperHotspot;
  Hotspot booksHotspot;
  Hotspot memo2Hotspot;
  Hotspot shelfHotspot;

  StageRoom2() {
    bg=loadImage("library.jpeg");
    paperImg = loadImage("paper.png");
    keyImg = loadImage("key.png");
    booksImg = loadImage("books.png");
    paper2Img=loadImage("memo1.png");
    memoImg=loadImage("memo.png");

    paperHotspot = new Hotspot("paper", 600, 470, 80, 80);
    booksHotspot = new Hotspot("books", 220, 190, 100, 100);
    memo2Hotspot = new Hotspot("memo2", 320, 430, 60, 60);
    shelfHotspot = new Hotspot("shelf", 1020, 220, 260, 90);
  }

  void update() {
  }

  void draw() {
    switch(screen) {
    case 0:
      drawLibrary();
      break;
    case 1:
      drawPaper();
      break;
    case 2:
      drawBooks();
      break;
    case 3:
      drawPaper2();
      break;
    case 4:
      drawKey();
      break;
    }
  }
  void drawLibrary() {
    image(bg, 0, -80, width, 650);
    if (!paperRead) {
      image(paperImg, 600, 470, 80, 80);
    }
    image(booksImg, 220, 190, 100, 100);
    if (paper2Found && !paper2Read) {
      image(memoImg, 320, 430, 60, 60);
    }
    if (shelfOpened && !cleared) {
      float pulse = (sin(frameCount * 0.08) + 1) / 2;
      noFill();
      stroke(255, 255, 100, 100 + pulse * 100);
      strokeWeight(3 + pulse * 3);
      ellipse(890, 350, 60 + pulse * 20, 60 + pulse * 20);
      noStroke();
      image(keyImg, 870, 330, 40, 40);
    }
  }

  void drawPopupFrame() {
    fill(230);
    rect(200, 80, 880, 470, 20);
  }

  void drawPaper() {
    drawLibrary();
    drawPopupFrame();
    image(paperImg, 455, 150, 370, 370);
    fill(0);
    textSize(20);
    text("クリックで戻る", 280, 540);
  }

  void drawBooks() {
    drawLibrary();
    drawPopupFrame();
    image(booksImg, 415, 95, 450, 450);
    fill(0);
    textSize(20);
    text("クリックで戻る", 280, 540);
  }

  void drawKey() {
    drawLibrary();
    drawPopupFrame();
    image(keyImg, 490, 150, 300, 300);
    fill(0);
    textAlign(CENTER, TOP);
    textSize(30);
    text("青い本棚が動いた！", 450, 130);
    text("奥から小さな鍵を見つけた。", 450, 180);
    textSize(50);
    if (!cleared) {
      text("鍵を入手する（クリックで閉じる）", 640, 485);
    } else {
      text("鍵2（クリックで閉じる）", 500, 485);
    }
  }
  void drawPaper2() {
    drawLibrary();
    drawPopupFrame();
    image(paper2Img, 377, 115, 525, 430);
    fill(0);
    textSize(20);
    text("クリックで戻る", 280, 540);
  }

  void mousePressed() {
    switch(screen) {
    case 0:
      if (!paperRead) {
        if (paperHotspot.contains(mouseX, mouseY)) {
          paperRead = true;
          inventory.addItem(
            new Item("paper", "紙", paperImg)
            );
          textBox.showMessages(null, new String[]{"紙を手に入れた"});
          screen=1;
          return;
        }
      }
      if (paperRead && booksHotspot.contains(mouseX, mouseY)) {
        booksChecked=true;
        screen=2;
        return;
      }
      if (paper2Found && !paper2Read) {
        if (memo2Hotspot.contains(mouseX, mouseY)) {
          paper2Read = true;
          inventory.addItem(
            new Item("memo", "メモ", memoImg)
            );
          textBox.showMessages(null, new String[]{"メモを手に入れた"});
          screen = 3;
          return;
        }
      }
      if (paper2Read && !shelfOpened && shelfHotspot.contains(mouseX, mouseY)) {
        shelfOpened=true;
        textBox.showMessages(null, new String[]{"カチッ…本棚が動いた！"});
        screen=4;
        return;
      }
      break;

    case 1:
      screen=0;
      break;

    case 2:
      paper2Found = true;
      screen=0;
      break;

    case 3:
      screen=0;
      break;

    case 4:
      if (!cleared) {
        cleared = true;
        inventory.addItem(
          new Item("key1", "鍵2", keyImg)
          );
        textBox.showMessages(null, new String[]{"鍵を手に入れた！"});
      }
      screen = 0;
      break;
    }
  }

  boolean isCleared() {
    return cleared;
  }

  void onInventoryItemClicked(Item item) {
    if (screen != 0) return;

    if (item.id.equals("paper")) {
      screen = 1;
    } else if (item.id.equals("memo")) {
      screen = 3;
    } else if (item.id.equals("key1")) {
      screen = 4;
    }
  }
}
