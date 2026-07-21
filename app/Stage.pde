abstract class Stage {
 
  // Game から結線される共有インスタンス（各部屋で持ち物・会話ウィンドウを使うため）
  Inventory inventory;
  TextBox textBox;
 
  abstract void update();
 
  abstract void draw();
 
  abstract void mousePressed();
 
  abstract boolean isCleared();
 
  // 持ち物欄のアイテムがクリックされたときの処理（部屋ごとに反応を実装する）
  abstract void onInventoryItemClicked(Item item);
 
}
