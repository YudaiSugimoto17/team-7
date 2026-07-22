/**
 * Inventory.pde — 持ち物欄（画面下部の7スロット）
 * 【担当】B（KATAHIRA Hiroto）
 *
 * 【役割】画面下部の7つのアイテムスロットを管理する。
 * 【Aとの連携】Game.draw() 内で inventory.draw() が呼ばれる。
 */
class Inventory {

  Item[] items;
  int selectedIndex;
  int maxSlots;
  int barHeight;
  int slotSize;
  int slotPadding;

  Inventory() {
    this.maxSlots = 5;
    this.items = new Item[maxSlots];
    this.selectedIndex = -1;
    this.barHeight = 150;
    this.slotSize = 120;
    this.slotPadding = 20;
  }

  // ----- アイテム操作 -----

  boolean addItem(Item item) {
    for (int i = 0; i < maxSlots; i++) {
      if (items[i] == null) {
        items[i] = item;
        return true;
      }
    }
    return false;
  }

  void removeItem(String id) {
    for (int i = 0; i < maxSlots; i++) {
      if (items[i] != null && items[i].id.equals(id)) {
        items[i] = null;
        if (selectedIndex == i) selectedIndex = -1;
        return;
      }
    }
  }

  boolean hasItem(String id) {
    for (int i = 0; i < maxSlots; i++) {
      if (items[i] != null && items[i].id.equals(id)) return true;
    }
    return false;
  }

  Item getSelectedItem() {
    if (selectedIndex >= 0 && selectedIndex < maxSlots) {
  return items[selectedIndex];}
    return null;
  }

  void clearSelection() {
    selectedIndex = -1;
  }

  void clear() {
    for (int i = 0; i < maxSlots; i++) items[i] = null;
    selectedIndex = -1;
  }

  // スロットの左端X座標を計算する共通メソッド。
  // 以前は getSlotAt() では中央揃えで計算した値、
  // draw() では決め打ちの 100 を使っていて、
  // 見た目のスロット位置とクリック判定の位置がズレていた
  // （アイコンをクリックしても反応しない不具合の原因）。
  // 両方からこのメソッドを呼ぶようにして、ズレが起きないようにした。
  int slotsStartX() {
    int totalWidth = maxSlots * slotSize + (maxSlots - 1) * slotPadding;
    return (width - totalWidth) / 2;
  }

  // ----- クリック処理 -----

  void selectSlot(int index) {
    if (index < 0 || index >= maxSlots) return;
    if (items[index] == null) return;
    selectedIndex = (selectedIndex == index) ? -1 : index;
  }

  int getSlotAt(int mx, int my) {
    int bY = height - barHeight;
    if (my < bY || my > height) return -1;
    int startX = slotsStartX();
    for (int i = 0; i < maxSlots; i++) {
      int sx = startX + i * (slotSize + slotPadding);
      int sy = bY + (barHeight - slotSize) / 2;
      if (mx >= sx && mx < sx + slotSize && my >= sy && my < sy + slotSize) return i;
    }
    return -1;
  }

  boolean isInBar(int mx, int my) {
    return (my >= height - barHeight);
  }

  boolean handleClick(int mx, int my) {
    if (!isInBar(mx, my)) return false;
    int slot = getSlotAt(mx, my);
    if (slot >= 0) {
      selectSlot(slot);
      return true;
    }
    return false;
  }

  // ----- 描画 -----

  void draw() {
    int bY = height - barHeight;

    // バー背景
    fill(180);
    noStroke();
    rect(0, bY, width, barHeight);
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    text("持ち物", 20, bY+20);
    //アイテム枠

  // スロット
  int startX = slotsStartX();
  for (int i = 0; i < maxSlots; i++) {
    int sx = startX + i * (slotSize + slotPadding);
    int sy = bY + (barHeight - slotSize) / 2;

    if (i == selectedIndex) {
      stroke(232, 161, 58);
      strokeWeight(3);
      fill(60, 55, 45, 180);
    } else {
      stroke(150, 150, 150, 120);
      strokeWeight(1);
      fill(50, 50, 55, 150);
    }
    rect(sx, sy, slotSize, slotSize, 8);

    if (items[i] != null) {
      if (items[i].icon != null) {
        imageMode(CORNER);
        image(items[i].icon, sx + 10, sy + 10, slotSize - 20, slotSize - 20);
      } else {
        fill(50, 50, 55, 150);
        textAlign(CENTER, CENTER);
        textSize(11);
        text(items[i].name, sx + slotSize / 2, sy + slotSize / 2);
      }
    }
  }
}
}
