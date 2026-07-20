class StageRoom1 extends Stage {
  boolean memoRead = false;       // メモを読んだ
  boolean cabinetOpened = false;  // 薬品棚を調べた
  boolean drawerOpened = false;   // ロッカーが開いた
  boolean cleared = false;        // 部屋クリア
  String message = "";
  int answerStep = 0;
  PImage bg;
  PImage memo;
  PImage beaker1;
  PImage beaker2;
  PImage beaker3;

  StageRoom1() {
    bg = loadImage("science room.jpeg");
    memo = loadImage("memo.png");
    beaker1 = loadImage("ビーカー青.png");
    beaker2 = loadImage("ビーカー赤.png");
    beaker3 = loadImage("ビーカー黄.png");
  }

  void update() {
  }

  void draw() {
    image(bg, 0, 0, width, height);
     fill(180);
    rect(0, 570, width, 150);

    fill(0);
    textSize(30);
    text("理科室", 130, 50);

    // メモ
    if (!memoRead) {
      image(memo, 760, 490, 40, 40);
    }

    // ビーカー3つ
    image(beaker1, 540, 440, 40, 40);
    image(beaker2, 710, 440, 40, 40);
    image(beaker3, 880, 440, 40, 40);
    

    fill(0);
    textSize(18);
    text(message,250,470);
  }

  void mousePressed() {

    // メモ
    if (!memoRead) {
      if (mouseX>=760 && mouseX<=800 &&
          mouseY>=490 && mouseY<=530) {

        memoRead = true;
        message = "メモには『薬品棚を調べよ』と書かれている";
        return;
      }
    }

    // 薬品棚
    if (memoRead && !cabinetOpened) {
      if (mouseX>=640 && mouseX<=1140 &&
          mouseY>=180 && mouseY<=380) {

        cabinetOpened = true;
        message = "薬品棚に『青→赤→黄』と書かれたラベルを見つけた";
        return;
      }
    }

    // ビーカーの順番
    if (cabinetOpened && !drawerOpened) {

      if (clickBeaker1()) {
        if (answerStep==0) answerStep=1;
        else answerStep=0;
      }

      if (clickBeaker2()) {
        if (answerStep==1) answerStep=2;
        else answerStep=0;
      }

      if (clickBeaker3()) {
        if (answerStep==2) {
          drawerOpened=true;
          message="ロッカーが開いた！";
        } else {
          answerStep=0;
        }
      }
    }

    // 鍵
    if (drawerOpened && !cleared) {
      if (mouseX>=270 && mouseX<=350 &&
          mouseY>=130 && mouseY<=390) {

        cleared=true;
        message="非常口の鍵①を手に入れた！";
      }
    }
  }

  boolean isCleared() {
    return cleared;
  }

  boolean clickBeaker1() {
    return dist(mouseX,mouseY,560,460)<=20;
  }

  boolean clickBeaker2() {
    return dist(mouseX,mouseY,730,460)<=20;
  }

  boolean clickBeaker3() {
    return dist(mouseX,mouseY,900,460)<=20;
  }
}
