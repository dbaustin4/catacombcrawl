int wwidth = 1280;
int wheight = 720;
import processing.sound.*;
SoundFile file; 

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  //file = new SoundFile(this, "soundtrack.mp3");
  //file.loop();

  Collectable scythe = new Collectable("scythe", "scythe.png");
  Collectable ruby = new Collectable("ruby", "ruby.png");
  Collectable cross = new Collectable ("cross", "cross.png");
  Collectable mirror = new Collectable ("mirror", "mirror.png");

  //Room transitions
  //MoveToSceneObject object7 = new MoveToSceneObject("goToScene05_scene02", 906, 561, 255, 150, "enter.png", "scene05");


  CollectableObject object6 = new CollectableObject("mirror_scene01", 1050, 496, 105, 105, mirror);
  CollectableObject object11 = new CollectableObject("cross_scene04", 250, 436, 60, 60, cross);
  

  //scene 1 to 4 is the first room
  Scene scene01 = new Scene("scene01", "start.jpg");
  RequireObject loupe01 = new RequireObject("requiresCross_scene01", 906, 561, 255, 150, "chestClosed.png", "The chest appears to be locked.", cross, object6);
  loupe01.setHoverImage("chestClosed.png");
  scene01.addGameObject(loupe01);
  TextObject loupe02 = new TextObject("largeText_scene01", 506, 460, 250, 250, "book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe02.setHoverImage("book.png");
  scene01.addGameObject(loupe02);
  MoveToSceneObject object2 = new MoveToSceneObject("goToScene02_scene01", 1180, 300, 50, 50, "arrowRight.png", "scene02");
  scene01.addGameObject(object2);
  MoveToSceneObject object9 = new MoveToSceneObject("goToScene03_scene01", 50, 300, 50, 50, "arrowLeft.png", "scene03");
  scene01.addGameObject(object9);
  MoveToSceneObject object10 = new MoveToSceneObject("goToScene04_scene01", 308, 645, 50, 50, "arrowDown.png", "scene04");
  scene01.addGameObject(object10);


  Scene scene02 = new Scene("scene02", "tutroom.jpg");
  MoveToSceneObject object3 = new MoveToSceneObject("goToScene01_scene02", 50, 300, 50, 50, "arrowLeft.png", "scene01");
  scene02.addGameObject(object3);
  MoveToSceneObject object4 = new MoveToSceneObject("goBack_scene03", 308, 645, 50, 50, "arrowDown.png", "scene03");
  scene02.addGameObject(object4);
  MoveToSceneObject object12 = new MoveToSceneObject("goToScene04_scene02", 1180, 300, 50, 50, "arrowRight.png", "scene04");
  scene02.addGameObject(object12);
  RequireObject loupe03 = new RequireObject("requiresScythe_scene02", 250, 396, 60, 60, "chestClosed.png", "Looks like a scythe fits in here", scythe, object11);
  scene02.addGameObject(loupe03);


  Scene scene03 = new Scene("scene03", "chamber.jpg");
  MoveToSceneObject object5 = new MoveToSceneObject("goBack_scene02", 308, 645, 50, 50, "arrowDown.png", "scene02");
  scene03.addGameObject(object5);
  MoveToSceneObject object13 = new MoveToSceneObject("goToScene01_scene03", 1180, 300, 50, 50, "arrowRight.png", "scene01");
  scene03.addGameObject(object13);
  MoveToSceneObject object16 = new MoveToSceneObject("goToScene04_scene03", 50, 300, 50, 50, "arrowLeft.png", "scene04");
  scene03.addGameObject(object16);
  MoveToSceneObject object19 = new MoveToSceneObject("goToScene05_scene03", 1050, 496, 20, 20, "mirror.png", "scene05");
  scene03.addGameObject(object19);
  RequireObject loupe04 = new RequireObject("requiresMirror_scene03", 1025, 496, 80, 80, "gem.png", "The light could be reflected somehow...", mirror, object6); //instead of placing a mirror it changes the scene background
  scene03.addGameObject(loupe04);



  Scene scene04 = new Scene("scene04", "prison.jpg");
  MoveToSceneObject object14 = new MoveToSceneObject("goBack_scene01", 308, 645, 50, 50, "arrowDown.png", "scene01");
  scene04.addGameObject(object14);
  MoveToSceneObject object15 = new MoveToSceneObject("goToScene03_scene04", 1180, 300, 50, 50, "arrowRight.png", "scene03");
  scene04.addGameObject(object15);
  MoveToSceneObject object17 = new MoveToSceneObject("goToScene02_scene03", 50, 300, 50, 50, "arrowLeft.png", "scene02");
  scene04.addGameObject(object17);
  CollectableObject object18 = new CollectableObject("scythe_scene04", 600, 400, 50, 50, scythe);
  scene04.addGameObject(object18);


  Scene scene05 = new Scene("scene05", "chamber.jpg");
  MoveToSceneObject object20 = new MoveToSceneObject("goToScene06_scene05", 1180, 300, 50, 50, "arrowRight.png", "scene06");
  scene05.addGameObject(object20);
  MoveToSceneObject object21 = new MoveToSceneObject("goToScene07_scene05", 50, 300, 50, 50, "arrowLeft.png", "scene07");
  scene05.addGameObject(object21);
  MoveToSceneObject object22 = new MoveToSceneObject("goToScene08_scene05", 308, 645, 50, 50, "arrowDown.png", "scene08");
  scene05.addGameObject(object22);
  
  
  Scene scene06 = new Scene("scene06", "start.jpg");
  MoveToSceneObject object23 = new MoveToSceneObject("goToScene07_scene06", 1180, 300, 50, 50, "arrowRight.png", "scene07");
  scene06.addGameObject(object23);
  MoveToSceneObject object24 = new MoveToSceneObject("goToScene05_scene06", 50, 300, 50, 50, "arrowLeft.png", "scene05");
  scene06.addGameObject(object24);
  MoveToSceneObject object25 = new MoveToSceneObject("goToScene08_scene06", 308, 645, 50, 50, "arrowDown.png", "scene08");
  scene06.addGameObject(object25);
  TextObject loupe05 = new TextObject("largeText_scene01", 506, 460, 250, 250, "book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe05.setHoverImage("book.png");
  scene06.addGameObject(loupe05);
  TextObject loupe06 = new TextObject("smallText_scene01", 906, 561, 255, 150, "chestOpen.png", "Of course it is empty.");
  loupe06.setHoverImage("chestOpen.png");
  scene06.addGameObject(loupe06);
  
  
  Scene scene07 = new Scene("scene07", "tutroom.jpg");
  MoveToSceneObject object26 = new MoveToSceneObject("goToScene08_scene07", 1180, 300, 50, 50, "arrowRight.png", "scene08");
  scene07.addGameObject(object26);
  MoveToSceneObject object27 = new MoveToSceneObject("goToScene06_scene07", 50, 300, 50, 50, "arrowLeft.png", "scene06");
  scene07.addGameObject(object27);
  MoveToSceneObject object28 = new MoveToSceneObject("goToScene05_scene07", 308, 645, 50, 50, "arrowDown.png", "scene05");
  scene07.addGameObject(object28);
  GameObject object32 = new GameObject("puzzleDoor", 380, 100, 550, 550, "puzzleWall.png");
  scene07.addGameObject(object32);
  
  
  Scene scene08 = new Scene("scene08", "prison.jpg");
  MoveToSceneObject object29 = new MoveToSceneObject("goToScene08_scene08", 1180, 300, 50, 50, "arrowRight.png", "scene08");
  scene08.addGameObject(object29);
  MoveToSceneObject object30 = new MoveToSceneObject("goToScene07_scene08", 50, 300, 50, 50, "arrowLeft.png", "scene07");
  scene08.addGameObject(object30);
  MoveToSceneObject object31 = new MoveToSceneObject("goToScene05_scene08", 308, 645, 50, 50, "arrowDown.png", "scene05");
  scene08.addGameObject(object31);
  CollectableObject object8 = new CollectableObject("ruby_scene02", 600, 400, 50, 50, ruby); //anubis eye for the door
  scene08.addGameObject(object8);


  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
  sceneManager.addScene(scene06);
  sceneManager.addScene(scene07);
  sceneManager.addScene(scene08);
}

void draw()
{
  sceneManager.getCurrentScene().draw(wwidth, wheight);
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}
