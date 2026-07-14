class Stage_room2 extends Stage {
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
  Stage_room2() {
    bg=loadImage("library.jpeg");
    paperImg = loadImage("paper.png");
    keyImg = loadImage("key.png");
    booksImg = loadImage("books.png");
    paper2Img=loadImage("memo1.png");
    memoImg=loadImage("memo.png");
  }

  void update() {
  }

  void draw() {
    background(0);
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
    //紙（まだ取っていない）
    if (!paperRead) {
      image(paperImg, 600, 490, 80, 80);
    }
    //鍵
    if (shelfOpened && !cleared) {
      image(keyImg, 870, 330, 40, 40);
    }
    //持ち物
    fill(180);
    rect(0, 570, width, 150);
    if (paperRead) {
      image(paperImg, 50, 640, 40, 40);
    }
    if (paper2Read) {
  image(memoImg, 110, 640, 40, 40);
}
    //本
    image(booksImg, 220, 190, 100, 100);

    fill(255);
    text(message, 250, 660);
    // 2枚目の紙
    if (paper2Found && !paper2Read) {
      image(memoImg, 320, 430, 60, 60);
    }
  }
  void drawPaper() {
    drawLibrary();
    fill(230);
    rect(200, 80, 880, 500, 20);
    image(paperImg, 455, 160, 370, 400);
    fill(0);
    textSize(20);
    text("クリックで戻る", 240, 560);
  }

  void drawBooks() {
    drawLibrary();
    fill(230);
    rect(200, 80, 880, 500, 20);
    image(booksImg, 390, 100, 500, 500);
    fill(0);
    textSize(20);
    text("クリックで戻る", 240, 560);
  }

  void drawKey() {
    drawLibrary();
    fill(230);
    rect(200, 80, 880, 500, 20);
    image(keyImg, 490, 150, 300, 300);
    fill(0);
    textSize(30);
    text("青い本棚が動いた！", 240, 130);
    text("奥から小さな鍵を見つけた。", 240, 180);
    textSize(50);
    text("鍵を入手する", 500, 520);
  }
  void drawPaper2() {
    drawLibrary();
    fill(230);
    rect(200, 80, 880, 500, 20);
    image(paper2Img, 377, 135, 525, 450);
    fill(0);
    textSize(20);
    text("クリックで戻る", 240, 560);
  }

  void mousePressed() {
    switch(screen) {
    case 0:
      if (!paperRead) {
        if (mouseX>=600 && mouseX<=680 &&
          mouseY>=490 && mouseY<=570) {
          paperRead = true;
          screen=1;
          return;
        }
      }
      //積み上げた本
      if (paperRead &&
        mouseX>=220 && mouseX<=320 &&
        mouseY>=190 && mouseY<=290) {
        booksChecked=true;
        screen=2;
        return;
      }

      //青い本棚
      if (paper2Read && !shelfOpened &&
        mouseX>=1020 && mouseX<=1280 &&
        mouseY>=220 && mouseY<=310) {
        shelfOpened=true;
        message="カチッ…本棚が動いた！";
        screen=4;
        return;
      }
      //鍵
      if (shelfOpened && !cleared &&
        mouseX>=490 && mouseX<=790 &&
        mouseY>=150 && mouseY<=450) {
        cleared=true;
        message="鍵を手に入れた！";
      }
      // 2枚目の紙
      if (paper2Found && !paper2Read) {
        if (mouseX>=320 && mouseX<=380 &&
          mouseY>=430 && mouseY<=490) {
          paper2Read = true;
          screen = 3;
          return;
        }
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
      if (mouseX>=600 && mouseX<=680 &&
        mouseY>=250 && mouseY<=330) {
        cleared = true;
        message = "鍵を手に入れた！";
        screen=0;
      }
      break;
    }
  }

  boolean isCleared() {
    return cleared;
  }
}
