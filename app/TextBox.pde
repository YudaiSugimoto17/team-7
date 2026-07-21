/**
 * TextBox.pde — 会話ウィンドウ（画面下部のナレーション表示）
 * 【担当】B（KATAHIRA Hiroto）
 *
 * 【役割】画面下部に表示される会話ウィンドウ。
 *         ナレーション、キャラのセリフ、ヒントを表示する。
 * 【Aとの連携】Game.draw() で textBox.draw() が呼ばれる。
 *              TextBox 表示中は他のクリックを無効化する。
 */
class TextBox {

  String[] queuedMessages;
  int currentIndex;
  String speaker;
  boolean isVisible;
  boolean onCompleteFlag;

  int boxHeight;
  int boxMarginX;
  int boxBottomMargin;

  TextBox() {
    this.queuedMessages = null;
    this.currentIndex = 0;
    this.speaker = null;
    this.isVisible = false;
    this.onCompleteFlag = false;
    this.boxHeight = 130;
    this.boxMarginX = 40;
    this.boxBottomMargin = 90;
  }

  // ----- メッセージ制御 -----

  /**
   * 会話を開始する。
   * @param speaker  話者名（null なら地の文）
   * @param messages セリフ配列（1要素 = 1ページ）
   */
  void showMessages(String speaker, String[] messages) {
    if (messages == null || messages.length == 0) return;
    this.speaker = speaker;
    this.queuedMessages = messages;
    this.currentIndex = 0;
    this.isVisible = true;
    this.onCompleteFlag = false;
  }

  /** 次のメッセージへ。最後なら閉じる。 */
  void next() {
    if (!isVisible) return;
    currentIndex++;
    if (currentIndex >= queuedMessages.length) {
      hide();
      onCompleteFlag = true;
    }
  }

  /** ウィンドウを閉じる。 */
  void hide() {
    isVisible = false;
    queuedMessages = null;
    currentIndex = 0;
  }

  /** 会話終了フラグを確認して消費する。 */
  boolean consumeComplete() {
    if (onCompleteFlag) {
      onCompleteFlag = false;
      return true;
    }
    return false;
  }

  // ----- クリック処理 -----

  /** 表示中ならクリックで次へ進める。 */
  boolean handleClick(int mx, int my) {
    if (!isVisible) return false;
    next();
    return true;
  }

  // ----- 描画 -----

  void draw() {
    if (!isVisible || queuedMessages == null) return;
    pushStyle();
    int bx = boxMarginX;
    int by = height - boxBottomMargin - boxHeight;
    int bw = width - boxMarginX * 2;
    int bh = boxHeight;

    // 背景
    noStroke();
    fill(30, 30, 35, 220);
    rect(bx, by, bw, bh, 16);

    // 枠線
    noFill();
    stroke(120, 120, 125, 100);
    strokeWeight(1);
    rect(bx, by, bw, bh, 16);

    // 話者名
    if (speaker != null) {
      fill(200, 200, 210);
      textAlign(CENTER, TOP);
      textSize(13);
      text(speaker, bx + bw / 2, by + 12);
    }

    // 本文
    fill(240, 235, 225);
    textAlign(CENTER, CENTER);
    textSize(16);
    int textY = by + bh / 2;
    if (speaker != null) textY += 8;
    text(queuedMessages[currentIndex], bx + bw / 2, textY);

    // ▼マーク
    float triX = bx + bw - 30;
    float triY = by + bh - 20;
    fill(240, 235, 225);
    noStroke();
    triangle(triX - 6, triY - 5, triX + 6, triY - 5, triX, triY + 5);
    popStyle();
  }
}
