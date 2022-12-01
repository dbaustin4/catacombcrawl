class RequireObject extends TextObject {
  private Collectable collectable;
  private GameObject replaceWith;
  private String targetScene;
  private GameObject replaceWith2;
  private String replaceBackgroundName;
  private boolean replaceBackground;
  
  public RequireObject(String identifier, int x, int y, int owidth, int oheight, 
                       String gameObjectImageFile, String text, 
                       Collectable collectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
  }
  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
                       String gameObjectImageFile, String text,
                       Collectable collectable, String targetScene) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.targetScene = targetScene;
  }
  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
                       String gameObjectImageFile, String text,
                       Collectable collectable, GameObject replaceWith, GameObject replaceWith2) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    this.replaceWith2 = replaceWith2;
  }
  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
                       String gameObjectImageFile, String text,
                       Collectable collectable, GameObject replaceWith, String replaceBackgroundName) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    this.replaceBackgroundName = replaceBackgroundName;
    replaceBackground = true;
  }
  
  @Override
  public void mouseClicked() {
    if(mouseIsHovering && inventoryManager.containsCollectable(collectable)) {
      if(this.soundFile != null){
        soundFile.play();
      }
      if(targetScene != null){
        sceneManager.goToScene(targetScene);
      }
      else {
        inventoryManager.removeCollectable(collectable);
        sceneManager.getCurrentScene().removeGameObject(this);
        if(replaceBackground){
          sceneManager.getCurrentScene().changeBackgroundImage(replaceBackgroundName);
        }
        sceneManager.getCurrentScene().addGameObject(replaceWith);
        if(replaceWith2 != null){
          sceneManager.getCurrentScene().addGameObject(replaceWith2);
        }
      }
      }
    else {
      super.mouseClicked();
    }
  } 
}
