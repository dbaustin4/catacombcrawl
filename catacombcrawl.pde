int wwidth = 1280;
int wheight = 720;
boolean skippedMovie = false;
boolean devmode = true;
boolean devnav = false;

import processing.sound.*;
SoundFile file;
import processing.video.*;
Movie openingMovie;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  openingMovie = new Movie(this, "openingMovie.mov");
  openingMovie.play();
  //file = new SoundFile(this, "soundtrack.mp3");
  //file.loop();
  
  //PFont egypt;
  //egypt = createFont("gyp");
  Collectable scythe = new Collectable("scythe", "scythe.png");
  Collectable ruby = new Collectable("ruby", "ruby.png");
  Collectable cross = new Collectable ("cross", "cross.png");
  Collectable mirror = new Collectable ("mirror", "mirror.png");

  CollectableObject mirrorObject = new CollectableObject("mirror_riddleScene", 1050, 496, 105, 105, mirror);
  CollectableObject crossObject = new CollectableObject("cross_lightScene", 250, 436, 60, 60, cross);
  

  //scene 1 to 4 is the first room
  // riddle Scene
  Scene riddleScene = new Scene("riddleScene", "riddleSceneBG.jpg");
  RequireObject loupe01 = new RequireObject("requiresCross_riddleScene", 906, 561, 255, 150, "chestClosed.png", "The chest appears to be locked.", cross, mirrorObject);
  loupe01.setHoverImage("chestClosed.png");
  riddleScene.addGameObject(loupe01);
  TextObject loupe02 = new TextObject("largeText_riddleScene", 506, 460, 250, 250, "book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe02.setHoverImage("book.png");
  riddleScene.addGameObject(loupe02);

  // puzzle Scene
  Scene puzzleScene = new Scene("puzzleScene", "puzzleSceneBG.jpg");
  RequireObject loupe03 = new RequireObject("requiresScythe_puzzleScene", 250, 396, 60, 60, "chestClosed.png", "Looks like a scythe fits in here", scythe, crossObject);
  puzzleScene.addGameObject(loupe03);

  //light Scene
  Scene lightScene = new Scene("lightScene", "lightSceneBG.jpg");
  MoveToSceneObject goToAct2MirrorObject = new MoveToSceneObject("goTolightScene_act2_lightScene", 1040, 496, 20, 20, "mirror.png", "lightScene_act2");
  lightScene.addGameObject(goToAct2MirrorObject);
  RequireObject loupe04 = new RequireObject("requiresMirror_lightScene", 985, 496, 130, 130, "gem.png", "The light could be reflected somehow...", mirror, goToAct2MirrorObject); //instead of placing a mirror it changes the scene background
  lightScene.addGameObject(loupe04);

  //statue Scene
  Scene statueScene = new Scene("statueScene", "statueSceneBG.jpg");
  CollectableObject scytheObject = new CollectableObject("scythe_lightScene", 600, 400, 50, 50, scythe);
  statueScene.addGameObject(scytheObject);



  //scenes 5 - 10 are the same room but after some changes have taken effect
  //riddle Scene act2
  Scene riddleScene_act2 = new Scene("riddleScene_act2", "riddleSceneBG.jpg");
  TextObject loupe05 = new TextObject("largeText_riddleScene", 506, 460, 250, 250, "book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe05.setHoverImage("book.png");
  riddleScene_act2.addGameObject(loupe05);
  TextObject loupe06 = new TextObject("smallText_riddleScene", 906, 561, 255, 150, "chestOpen.png", "Of course it is empty.");
  loupe06.setHoverImage("chestOpen.png");
  riddleScene_act2.addGameObject(loupe06);

  
  //puzzle Scene act2
  Scene puzzleScene_act2 = new Scene("puzzleScene_act2", "puzzleSceneBG.jpg");

  
  //statue Scene act2
  Scene statueScene_act2 = new Scene("statueScene_act2", "statueSceneBG.jpg");
  MoveToSceneObject goToAct3RubyObject = new MoveToSceneObject("ruby_statueScene_act2", 600, 400, 50, 50, "ruby.png", "puzzleScene_act3"); //anubis eye for the door
  statueScene_act2.addGameObject(goToAct3RubyObject);
  //CollectableObject goToAct3RubyObject = new CollectableObject("ruby_puzzleScene", 600, 400, 50, 50, ruby); //anubis eye for the door
  //statueScene_act2.addGameObject(goToAct3RubyObject);


  //light Scene act2
  Scene lightScene_act2 = new Scene("lightScene_act2", "lightSceneBG.jpg");
  

  //puzzle scene act3
  //scene 9 and 10 you can only read the riddles and solve the puzzle door
  Scene puzzleScene_act3 = new Scene("puzzleScene_act3", "puzzleSceneBG.jpg");
  GameObject puzzleWallObject = new PuzzleDoor("puzzleDoor", 380, 100, 550, 550, "puzzleWall.png");
  puzzleScene_act3.addGameObject(puzzleWallObject);
  MoveToSceneObject navPuzzleScene_act3 = new MoveToSceneObject("goToriddleScene_act3_puzzleScene_act3", 50, 300, 50, 50, "arrowLeft.png", "riddleScene_act3");
  puzzleScene_act3.addGameObject(navPuzzleScene_act3);

  //riddle scene act3
  Scene riddleScene_act3 = new Scene("riddleScene_act3", "riddleSceneBG.jpg");
  TextObject loupe07 = new TextObject("largeText_riddleScene", 506, 460, 250, 250, "book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere!");
  loupe07.setHoverImage("book.png");
  riddleScene_act3.addGameObject(loupe05);
  TextObject loupe08 = new TextObject("smallText_riddleScene", 906, 561, 255, 150, "chestOpen.png", "Of course it is empty.");
  loupe08.setHoverImage("chestOpen.png");
  riddleScene_act3.addGameObject(loupe06);
  MoveToSceneObject navRiddleScene_act3 = new MoveToSceneObject("goTopuzzleScene_act3_riddleScene_act3", 1180, 300, 50, 50, "arrowRight.png", "puzzleScene_act3");
  riddleScene_act3.addGameObject(navRiddleScene_act3);

  //Room transitions
        /*                 layout
                        Riddle Scene
                      |--------------|
                      |              |
         Light Scene  |              |   Puzzle Scene
                      |              |
                      |--------------|
                        Statue Scene
         */
        //                                                (identifier,     scene name , left arrow,   right arrow,   bottom arrow)
        //Scenes 1-4 (prechanges)
        //navigation riddleScene
        navigationGUI navRiddleScene = new navigationGUI("navRiddleScene", riddleScene, "lightScene", "puzzleScene", "statueScene");
        navRiddleScene.addNavigationGUI();
        //navigation puzzleScene
        navigationGUI navPuzzleScene = new navigationGUI("navPuzzleScene", puzzleScene, "riddleScene", "statueScene", "lightScene");
        navPuzzleScene.addNavigationGUI();
        //navigation statueScene
        navigationGUI navStatueScene = new navigationGUI("navStatueScene", statueScene, "puzzleScene", "lightScene", "riddleScene");
        navStatueScene.addNavigationGUI();
        //navigation lightScene
        navigationGUI navLightScene = new navigationGUI("navLightScene", lightScene, "statueScene", "riddleScene", "puzzleScene");
        navLightScene.addNavigationGUI();

        
        //Scenes 5-8 (postchange)
        //navigation riddleScene_act2
        navigationGUI navRiddleScene_act2 = new navigationGUI("navRiddleScene_act2", riddleScene_act2, "lightScene_act2", "puzzleScene_act2", "statueScene_act2");
        navRiddleScene_act2.addNavigationGUI();
        //navigation puzzleScene_act2
        navigationGUI navPuzzleScene_act2 = new navigationGUI("navPuzzleScene_act2", puzzleScene_act2, "riddleScene_act2", "statueScene_act2", "lightScene_act2");
        navPuzzleScene_act2.addNavigationGUI();
        //navigation statueScene_act2
        navigationGUI navStatueScene_act2 = new navigationGUI("navStatueScene_act2", statueScene_act2, "puzzleScene_act2", "lightScene_act2", "riddleScene_act2");
        navStatueScene_act2.addNavigationGUI();
        //navigation lightScene_act2
        navigationGUI navLightScene_act2 = new navigationGUI("navLightScene_act2", lightScene_act2, "statueScene_act2", "riddleScene_act2", "puzzleScene_act2");
        navLightScene_act2.addNavigationGUI();

        
        //scenes 9-10

 /*
  try {
  sceneManager.goToScene ("riddlscene_act2");
  } catch (Exception e) {
   println("Scene not found");
  }*/
}

void draw()
{
  if(openingMovie.time() < 54  && devmode == false){
        image(openingMovie, 0, 0, wwidth, wheight);
        println(openingMovie.time());
        }
  else{
        sceneManager.getCurrentScene().draw(wwidth, wheight);
        sceneManager.getCurrentScene().updateScene();
        inventoryManager.clearMarkedForDeathCollectables();
        }
}

void movieEvent(Movie m){
  m.read();
}


void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  if(!skippedMovie) { skippedMovie = true; openingMovie.jump(54);}
  sceneManager.getCurrentScene().mouseClicked();
}
