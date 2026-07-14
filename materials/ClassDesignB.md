# 担当B　クラス設計
担当者：KATAHIRA Hiroto
## 【Item】

## 属性
  - String id
  - String name
  - PImage icon
  
## メソッド
  - Item()

## メモ
アイテム1つ分のデータを持つクラス。
Stage内で new して Inventory.addItem() に渡す。


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

## メモ
部屋内のクリック可能領域を表すクラス。
contains() でクリック位置が領域内かを判定する。
処理の分岐は Stage の mousePressed() 内で行う

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

## メモ
画面下部の7スロットのアイテム欄を管理するクラス。

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

## メモ
画面下部の会話ウィンドウを管理するクラス。
isVisible が true の間は他の操作を無効化する。


