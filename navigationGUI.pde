class navigationGUI {
  SoundFile uiEffect  = new SoundFile(catacombcrawl.this, "UI.wav");
  private ArrayList<String> navObjectsNames = new ArrayList<String>();
  //private ArrayList<MoveToSceneObject> navObjects = new ArrayList<MoveToSceneObject>();
  private String n;
  //images used for the arrows
  private String arrowLeftImage = "arrowLeft.png";
  private String arrowRightImage = "arrowRight.png";
  private String arrowDownImage = "arrowDown.png";

  //variables for targets for each arrow (per instance)
  private String identifier;
  private Scene scene;
  private String targetLeft;
  private String targetRight;
  private String targetDown;


  // syntax (Room Name, Scene, Target scene left, target scene right, target scene backwards)
  public navigationGUI(String indentifier, Scene scene, String targetLeft, String targetRight, String targetDown){
    this.identifier = indentifier;
    this.scene = scene;
    this.targetLeft = targetLeft;
    this.targetRight = targetRight;
    this.targetDown = targetDown;
    this.navObjectsNames.add(indentifier + "_Left");
    this.navObjectsNames.add(indentifier + "_Right");
    this.navObjectsNames.add(indentifier + "_Down");
  }

  public void addNavigationGUI(){
    MoveToSceneObject obj1 = new MoveToSceneObject(navObjectsNames.get(0), 2, 358, 50, 50, arrowLeftImage, targetLeft);
    scene.addGameObject(obj1);
    obj1.addSoundFile(uiEffect);
    MoveToSceneObject obj2  = new MoveToSceneObject(navObjectsNames.get(1) , 1231, 358, 50, 50, arrowRightImage, targetRight);
    scene.addGameObject(obj2);
    obj2.addSoundFile(uiEffect);
    //MoveToSceneObject obj3  = new MoveToSceneObject(navObjectsNames.get(2) , 308, 645, 50, 50, arrowDownImage, targetDown);
    //scene.addGameObject(obj3);
  }
}