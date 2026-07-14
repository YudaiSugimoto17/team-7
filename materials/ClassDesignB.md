# 担当B　クラス設計
担当者：KATAHIRA Hiroto
***
## 【Item】

## 属性
  - String id
  - String name
  - PImage icon
  
## メソッド
  - Item()

---

## 【Hotspot】

## 属性
  - String id
  - int x, y, w, h
  - String type
  - String requiredItem
  - String gainItem
  - String[] dialogue
  - String[] usedDialogue
  - String needDialogue
  - String flagToSet
  - boolean consumeItem
  - String destination
  - boolean used
  - boolean visible

## メソッド
  - Hotspot()
  - boolean contains()
  - void drawDebug()
  - void reset()

---

## 【Inventory】

## 属性
  - Item[] items
  - int selectedIndex
  - int maxSlots
  - int barHeight
  - int slotSize
  - int slotPadding

## メソッド
  - Inventory()
  - boolean addItem()
  - void removeItem()
  - boolean hasItem()
  - Item getSelectedItem()
  - void clearSelection()
  - void clear()
  - void selectSlot()
  - int getSlotAt()
  - boolean isInBar()
  - boolean handleClick()
  - void draw()

---

## 【TextBox】

## 属性
  - String[] queuedMessages
  - int currentIndex
  - String speaker
  - boolean isVisible
  - boolean onCompleteFlag
  - int boxHeight
  - int boxMarginX
  - int boxBottomMargin

## メソッド
  - TextBox()
  - void showMessages()
  - void next()
  - void hide()
  - boolean consumeComplete()
  - boolean handleClick()
  - void draw()



