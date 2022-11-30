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
  Collectable scythe = new Collectable("scythe", "scythe_Cutoff.png");
  Collectable ruby = new Collectable("ruby", "GemEye_Item.png");
  Collectable cross = new Collectable ("cross", "cross.png");
  Collectable mirror = new Collectable ("mirror", "Mirror_Cutoff.png");

  CollectableObject mirrorObject = new CollectableObject("mirror_riddleScene", 1047, 550, 113, 131, mirror);
  CollectableObject crossObject = new CollectableObject("cross_lightScene", 300, 382, 52, 95, cross);

  TextObject loupe06 = new TextObject("smallText_riddleScene", 930, 467, 286, 253, "chestOpen.png", "Of course it is empty.");
  //scene 1 to 4 is the first room
  // riddle Scene
  Scene riddleScene = new Scene("riddleScene", "riddleSceneBG.png");
  RequireObject loupe01 = new RequireObject("requiresCross_riddleScene", 929, 496, 288, 224, "chestClosed.png", "The chest appears to be locked.", cross , loupe06 ,mirrorObject);
  loupe01.setHoverImage("chestClosed.png");
  riddleScene.addGameObject(loupe01);
  TextObject loupe02 = new TextObject("largeText_riddleScene", 533, 395, 218, 120, "Book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe02.setHoverImage("Book.png");
  riddleScene.addGameObject(loupe02);

  // puzzle Scene
  Scene puzzleScene = new Scene("puzzleScene", "puzzleSceneBG.png");
  RequireObject loupe03 = new RequireObject("requiresScythe_puzzleScene", 300, 383, 48, 93, "Scythe_Mold.png", "Looks like a scythe fits in here", scythe, crossObject, "puzzleSceneBG2.png");
  puzzleScene.addGameObject(loupe03);

  //light Scene
  Scene lightScene = new Scene("lightScene", "lightSceneBG.png");
  //MoveToSceneObject goToAct2MirrorObject = new MoveToSceneObject("goTolightScene_act2_lightScene", 1040, 496, 20, 20, "mirror.png", "lightScene_act2");
  //lightScene.addGameObject(goToAct2MirrorObject);
  RequireObject loupe04 = new RequireObject("requiresMirror_lightScene", 1179, 645, 62, 75, "Rock.png", "The light could be reflected somehow...", mirror, "lightScene_act2"); //instead of placing a mirror it changes the scene background
  lightScene.addGameObject(loupe04);

  //statue Scene
  Scene statueScene = new Scene("statueScene", "statueSceneBG.png");
  CollectableObject scytheObject = new CollectableObject("scythe_lightScene", 616, 280, 86, 55, scythe);
  statueScene.addGameObject(scytheObject);



  //scenes 5 - 10 are the same room but after some changes have taken effect
  //riddle Scene act2
  Scene riddleScene_act2 = new Scene("riddleScene_act2", "riddleSceneBG.png");
  TextObject loupe05 = new TextObject("largeText_riddleScene", 533, 395, 218, 120, "Book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere.");
  loupe05.setHoverImage("Book.png");
  riddleScene_act2.addGameObject(loupe05);
  loupe06.setHoverImage("chestOpen.png");
  riddleScene_act2.addGameObject(loupe06);

  
  //puzzle Scene act2
  Scene puzzleScene_act2 = new Scene("puzzleScene_act2", "puzzleSceneBG2.png");

  
  //statue Scene act2
  Scene statueScene_act2 = new Scene("statueScene_act2", "statueSceneBG2.png");
  MoveToSceneObject goToAct3RubyObject = new MoveToSceneObject("ruby_statueScene_act2", 620, 295, 30, 30, "GemEye_InBowl.png", "puzzleScene_act3"); //anubis eye for the door
  statueScene_act2.addGameObject(goToAct3RubyObject);
  //CollectableObject goToAct3RubyObject = new CollectableObject("ruby_puzzleScene", 600, 400, 50, 50, ruby); //anubis eye for the door
  //statueScene_act2.addGameObject(goToAct3RubyObject);


  //light Scene act2
  Scene lightScene_act2 = new Scene("lightScene_act2", "lightSceneBG2.png");
  

  //puzzle scene act3
  //scene 9 and 10 you can only read the riddles and solve the puzzle door
  Scene puzzleScene_act3 = new Scene("puzzleScene_act3", "puzzleSceneBG2.png");
  GameObject puzzleWallObject = new PuzzleDoor("puzzleDoor", 382, 222, 518, 498, "Puzzle_Overlay.png");
  puzzleScene_act3.addGameObject(puzzleWallObject);
  MoveToSceneObject navPuzzleScene_act3 = new MoveToSceneObject("goToriddleScene_act3_puzzleScene_act3",  2, 358, 50, 50, "arrowLeft.png", "riddleScene_act3");
  puzzleScene_act3.addGameObject(navPuzzleScene_act3);

  //riddle scene act3
  Scene riddleScene_act3 = new Scene("riddleScene_act3", "riddleSceneBG.png");
  TextObject loupe07 = new TextObject("largeText_riddleScene", 533, 395, 218, 120, "Book.png", "The eye of the death god is needed to read the writing on the wall. I am everywhere but nowhere, present everywhere!");
  loupe07.setHoverImage("Book.png");
  riddleScene_act3.addGameObject(loupe05);
  TextObject loupe08 = new TextObject("smallText_riddleScene", 929, 570, 255, 150, "chestOpen.png", "Of course it is empty.");
  loupe08.setHoverImage("chestOpen.png");
  riddleScene_act3.addGameObject(loupe06);
  MoveToSceneObject navRiddleScene_act3 = new MoveToSceneObject("goTopuzzleScene_act3_riddleScene_act3", 1231, 358, 50, 50, "arrowRight.png", "puzzleScene_act3");
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
