/**
 * Hotspot.pde — 部屋内のクリック可能領域
 * 【担当】B（KATAHIRA Hiroto）
 * 
 * 【役割】
 *   部屋の中の「クリックしたら何か起きる場所」を表す。
 *   位置（矩形）と、アクション情報（セリフ・取得アイテム等）を持つ。
 *   処理の分岐は Stage の mousePressed() 内で行う。
 */
class Hotspot {

  // ===== 識別と位置 =====
  String id;            // ユニーク識別子（"shelf", "safe" など）
  int x, y, w, h;       // クリック判定の矩形（ピクセル座標）

  // ===== 動作の種別 =====
  //   "look"   : セリフを表示するだけ
  //   "action" : アイテム取得やフラグ設定を伴う
  //   "puzzle" : パスコード入力など謎を起動
  //   "door"   : 別の場所への移動
  String type;

  // ===== アクションの中身 =====
  String requiredItem;    // 使用に必要なアイテム id（null なら制限なし）
  String gainItem;        // 成功時に手に入るアイテム id
  String[] dialogue;      // クリック時のセリフ配列
  String[] usedDialogue;  // 使用済みの場合のセリフ
  String needDialogue;    // 必要アイテムがない時のセリフ
  boolean consumeItem;    // true なら使用後にアイテムを消費
  String destination;     // type="door" の場合の移動先
  String flagToSet;

  // ===== 状態 =====
  boolean used;           // 一度アクションを実行したか
  boolean visible;        // 表示中か

  // ===== コンストラクタ =====
  Hotspot(String id, int x, int y, int w, int h) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = "look";
    this.requiredItem = null;
    this.gainItem = null;
    this.dialogue = null;
    this.usedDialogue = null;
    this.needDialogue = null;
    this.consumeItem = false;
    this.destination = null;
    this.flagToSet = null;
    this.used = false;
    this.visible = true;
  }

  /**
   * 指定座標がこの領域内にあるか判定する。
   */
  boolean contains(int mx, int my) {
    return (mx >= x && mx < x + w && my >= y && my < y + h);
  }

  /**
   * デバッグ用：領域を枠線で可視化する。
   */
  void drawDebug() {
    if (!visible) return;
    noFill();
    strokeWeight(2);
    if (type.equals("look"))        stroke(100, 180, 255, 120);
    else if (type.equals("action")) stroke(232, 161, 58, 150);
    else if (type.equals("puzzle")) stroke(100, 255, 100, 120);
    else if (type.equals("door"))   stroke(200, 130, 200, 150);
    else                            stroke(200, 200, 200, 100);
    rect(x, y, w, h, 4);
    fill(255, 200);
    textAlign(CENTER, BOTTOM);
    textSize(10);
    text(id, x + w / 2, y - 2);
  }

  /**
   * 状態をリセットする。
   */
  void reset() {
    this.used = false;
  }
}
