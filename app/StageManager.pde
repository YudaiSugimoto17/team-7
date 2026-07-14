class StageManager {

  Stage currentStage;

  StageManager() {
    currentStage = null;
  }

  void setStage(Stage stage) {
    currentStage = stage;
  }

  void clearStage() {
    currentStage = null;
  }

  Stage getCurrentStage() {
    return currentStage;
  }

}