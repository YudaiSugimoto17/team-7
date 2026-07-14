class FlagManager {

  boolean hasExitKey1;
  boolean hasExitKey2;

  boolean room1Cleared;
  boolean room2Cleared;

  FlagManager() {
    reset();
  }

  void reset() {
    hasExitKey1 = false;
    hasExitKey2 = false;

    room1Cleared = false;
    room2Cleared = false;
  }

  boolean canEscape() {
    return hasExitKey1 && hasExitKey2;
  }
}
