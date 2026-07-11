# Stage Interface

各部屋のステージクラスは以下の抽象クラスを継承して実装する。

```java
abstract class Stage {

  abstract void update();

  abstract void draw();

  abstract void mousePressed();

  abstract boolean isCleared();

}
```

## ルール

- Stage_room1, Stage_room2 は Stage を継承する
- isCleared() が true の場合、その部屋はクリア済みとみなす
- isCleared() が true になった後は true を維持する
- エンジン層は isCleared() のみ参照する
- 謎解き用アイテム・フラグ管理は各部屋担当が実装する
- 非常口の鍵管理はエンジン層が実装する