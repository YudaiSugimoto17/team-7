class Stage_room1 extends Stage {
  boolean memoRead = false;       // メモを読んだ
  boolean cabinetOpened = false;  // 薬品棚を調べた
  boolean drawerOpened = false;   // 引き出しが開いた
  boolean cleared = false;        // 部屋クリア
  String message = "";
  int answerStep = 0;

  Stage_room1() {
  }

  void update() {
  }

  void draw() {
    background(210);

    fill(0);
    textSize(30);
    text("理科室", 330, 50);

    // 実験台
    fill(170,120,70);
    rect(250,250,220,80);

    // 薬品棚
    fill(180);
    rect(600,100,80,220);

    // メモ
    if (!memoRead) {
      fill(255);
      rect(120,100,40,40);
    }

    // ビーカー3つ
    fill(0,0,255);
    ellipse(180,380,40,40); //①
    fill(255,0,0);
    ellipse(350,380,40,40); //②
    fill(255,255,0);
    ellipse(520,380,40,40); //③

    // 鍵
    if (drawerOpened && !cleared) {
      fill(255,255,0);
      ellipse(360,280,20,20);
    }

    fill(0);
    textSize(18);
    text(message,20,470);
  }

  void mousePressed() {

    // メモ
    if (!memoRead) {
      if (mouseX>=120 && mouseX<=160 &&
          mouseY>=100 && mouseY<=140) {

        memoRead = true;
        message = "メモには『薬品棚を調べよ』と書かれている";
        return;
      }
    }

    // 薬品棚
    if (memoRead && !cabinetOpened) {
      if (mouseX>=600 && mouseX<=680 &&
          mouseY>=100 && mouseY<=320) {

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
          message="実験台の引き出しが開いた！";
        } else {
          answerStep=0;
        }
      }
    }

    // 鍵
    if (drawerOpened && !cleared) {
      if (mouseX>=350 && mouseX<=370 &&
          mouseY>=270 && mouseY<=290) {

        cleared=true;
        message="非常口の鍵①を手に入れた！";
      }
    }
  }

  boolean isCleared() {
    return cleared;
  }

  boolean clickBeaker1() {
    return dist(mouseX,mouseY,180,380)<=20;
  }

  boolean clickBeaker2() {
    return dist(mouseX,mouseY,350,380)<=20;
  }

  boolean clickBeaker3() {
    return dist(mouseX,mouseY,520,380)<=20;
  }
}
