class SceneManager {

  static final int TITLE = 0;
  static final int HUB = 1;
  static final int ROOM = 2;
  static final int ALL_CLEAR = 3;

  int currentScene;

  SceneManager() {
    currentScene = TITLE;
  }

  void changeScene(int nextScene) {
    currentScene = nextScene;
  }

  int getCurrentScene() {
    return currentScene;
  }
}