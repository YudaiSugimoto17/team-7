/**
 * Item.pde — アイテムのデータクラス
 * 【担当】B（KATAHIRA Hiroto）
 */
class Item {
  String id;      // 識別子（"key1", "memo" など）
  String name;    // 表示名（"非常口の鍵①" など）
  PImage icon;    // アイコン画像（null ならテキスト表示）
  PImage largeImage;  //拡大表示用

  Item(String id, String name, PImage icon,PImage largeImage) {
    this.id = id;
    this.name = name;
    this.icon = icon;
    this.largeImage=largeImage;
  }

  //
  Item(String id, String name,PImage icon) {
    this(id, name, icon, icon);
  }
  // 画像なし
  Item(String id, String name) {
    this(id, name, null, null);
  }
}
