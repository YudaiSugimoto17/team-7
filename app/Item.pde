/**
 * Item.pde — アイテムのデータクラス
 * 【担当】B（KATAHIRA Hiroto）
 */
class Item {
  String id;      // 識別子（"key1", "memo" など）
  String name;    // 表示名（"非常口の鍵①" など）
  PImage icon;    // アイコン画像（null ならテキスト表示）

  Item(String id, String name, PImage icon) {
    this.id = id;
    this.name = name;
    this.icon = icon;
  }

  // 画像なし版（プロトタイプ用）
  Item(String id, String name) {
    this.id = id;
    this.name = name;
    this.icon = null;
  }
}
