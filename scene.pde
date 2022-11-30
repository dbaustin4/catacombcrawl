class Scene {
  private String sceneName;
  private PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;
  
  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;
  
  public boolean first = true;
  private String img;
  
  public Scene(String sceneName, String backgroundImageFile) {
    this.sceneName = sceneName;
    this.backgroundImage = loadImage(backgroundImageFile);
    this.img = backgroundImageFile;
    gameObjects = new ArrayList<GameObject>();
    markedForDeathGameObjects = new ArrayList<GameObject>();
    recentlyAddedGameObjects = new ArrayList<GameObject>();
    sceneManager.addScene(this);
  }
  
  public void initialize() {
    if (first) {
      first = false;
     // this.backgroundImage = loadImage(img);
    }
  }

  public void changeBackgroundImage(String backgroundImageFile){
    this.backgroundImage = loadImage(backgroundImageFile);
  }
  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }
  
  public void removeGameObject(GameObject object) {
    markedForDeathGameObjects.add(object);
  }
  
  public void updateScene() {
    if(markedForDeathGameObjects.size() > 0) {
      for(GameObject object : markedForDeathGameObjects) {
        gameObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();
    }
    if(recentlyAddedGameObjects.size() > 0) {
      for(GameObject object : recentlyAddedGameObjects) {
        gameObjects.add(object);
      }
      recentlyAddedGameObjects  = new ArrayList<GameObject>();
    }
    this.mouseMoved();
  }
  
  public void draw(int wwidth, int wheight) {
    image(backgroundImage, 0, 0, wwidth, wheight);
    for(GameObject object : gameObjects) {
      object.draw();
    }
  }
  
  public void mouseMoved() {
    for(GameObject object : gameObjects) {
      object.mouseMoved();
    }
  }
  
  public void mouseClicked() {
    for(GameObject object : gameObjects) {
      object.mouseClicked();
    }
  }
  
  public String getSceneName() {
    return this.sceneName;
  }
}
