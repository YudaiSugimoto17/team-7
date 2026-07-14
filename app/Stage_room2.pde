class Stage_room2 extends Stage {
  boolean paperRead = false;      // 紙を読んだ
  boolean bookmarkFound = false;  // しおりを入手
  boolean shelfOpened = false;    // 本棚が開いた
  boolean cleared = false;        // 部屋クリア
  String message = "";
  int answerStep = 0;
  Stage_room2() {
    // 本棚を押した順番
  }

  void update() {
  }

  void draw() {
    background(240);
    fill(0);
    textSize(30);
    text("library", 330, 50);
    // 机
    fill(170, 120, 70);
    rect(100, 300, 200, 100);
    // 本棚
    fill(150, 100, 50);
    rect(450, 100, 250, 350);
    // 紙
    if (!paperRead) {
      fill(255);
      rect(180, 320, 40, 40);
    }
    // 本
    fill(255);
    rect(470, 120, 60, 40); // 本①
    rect(470, 180, 60, 40); // 本②
    rect(470, 240, 60, 40); // 本③

    fill(0);
    text(message, 30, 500);
    // 鍵
    if (shelfOpened && !cleared) {
      fill(255, 255, 0);
      ellipse(640, 400, 30, 30);
    }
  }
  void mousePressed() {
    if (!paperRead) {
      if (mouseX>=180 && mouseX<=220 &&
        mouseY>=320 && mouseY<=360) {
        paperRead = true;
        message =
          "『知識は五十音から始まる』\n「あ」から始まる本を探せ";
        return;
      }
    }
    if (paperRead && !bookmarkFound) {
      if (mouseX>=480 && mouseX<=650 &&
        mouseY>=120 && mouseY<=170) {
        bookmarkFound = true;
        message =
          "しおりを見つけた\n『123　本棚の番号を見よ』";
        return;
      }
    }
    if (bookmarkFound && !shelfOpened) {
      //①
      if (clickBook1()) {
        if (answerStep==0) {
          answerStep=1;
        } else {
          answerStep=0;
        }
      }
      //②
      if (clickBook2()) {
        if (answerStep==1) {
          answerStep=2;
        } else {
          answerStep=0;
        }
      }
      //③
      if (clickBook3()) {
        if (answerStep==2) {
          shelfOpened=true;
          message="カチッ！本棚が動いた！";
        } else {
          answerStep=0;
        }
      }
    }
    if (shelfOpened && !cleared) {
      // 鍵
      if (mouseX >= 620 && mouseX <= 660 &&
        mouseY >= 380 && mouseY <= 420) {
        cleared = true;
        message = "非常口の鍵①を手に入れた！";
      }
    }
  }
  boolean isCleared() {
    return cleared;
  }
  boolean clickBook1() {
    return mouseX >= 470 && mouseX <= 530 &&
      mouseY >= 120 && mouseY <= 160;
  }

  boolean clickBook2() {
    return mouseX >= 470 && mouseX <= 530 &&
      mouseY >= 180 && mouseY <= 220;
  }

  boolean clickBook3() {
    return mouseX >= 470 && mouseX <= 530 &&
      mouseY >= 240 && mouseY <= 280;
  }
}
