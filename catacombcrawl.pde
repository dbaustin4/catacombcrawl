int wwidth = 1280;
int wheight = 720;
boolean skippedMovie = false;
boolean devmode = false;
boolean devnav = false;

import processing.sound.*;
SoundFile file;
import processing.video.*;
Movie openingMovie;
Sound sound = new Sound(this);

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  sound.volume(0);
  openingMovie = new Movie(this, "openingMovie.mov");
  openingMovie.play();
  //init for audiofiles
        SoundFile soundTrack = new SoundFile(this, "soundtrack.wav");
        soundTrack.loop();
        SoundFile scythePickUp = new SoundFile(this, "scythe_pickup.wav");
        SoundFile scythePlace = new SoundFile(this, "scythe_place.wav");
        SoundFile chestOpen = new SoundFile(this, "chest_open.wav");
        SoundFile chestLocked = new SoundFile(this, "chest_locked.wav");
        SoundFile mirrorPickUp = new SoundFile(this, "mirror_pickup.wav");
        SoundFile doorOpen = new SoundFile(this, "sliding_stone_door.wav");
        SoundFile gemPickup = new SoundFile(this, "gem_Pickup.wav");
        SoundFile paperRumble  = new SoundFile(this, "paper_rumbling.wav");



  //PFont egypt;
  //egypt = createFont("gyp");
  Collectable scythe = new Collectable("scythe", "scythe_Cutoff.png");
  Collectable ruby = new Collectable("ruby", "GemEye_Item.png");
  Collectable cross = new Collectable ("cross", "cross.png");
  Collectable mirror = new Collectable ("mirror", "Mirror_Cutoff.png");

  CollectableObject mirrorObject = new CollectableObject("mirror_riddleScene", 1047, 550, 113, 131, mirror);
  mirrorObject.addSoundFile(mirrorPickUp);
  CollectableObject crossObject = new CollectableObject("cross_lightScene", 300, 382, 52, 95, cross);
  crossObject.addSoundFile(scythePickUp);

  TextObject loupe06 = new TextObject("smallText_riddleScene", 930, 467, 286, 253, "chestOpen.png", "Of course it is empty.");
  //scene 1 to 4 is the first room
  // riddle Scene
  Scene riddleScene = new Scene("riddleScene", "riddleSceneBG.png");
  RequireObject loupe01 = new RequireObject("requiresCross_riddleScene", 929, 496, 288, 224, "chestClosed.png", "The chest appears to be locked.", cross , loupe06 ,mirrorObject);
  loupe01.addSoundFile(chestLocked);
  loupe01.setHoverImage("chestClosed.png");
  riddleScene.addGameObject(loupe01);
  MoveToSceneObject loupe02 = new MoveToSceneObject("goToriddleBookScene", 533, 395, 218, 120, "book.png", "riddleBookScene");
  loupe02.addSoundFile(paperRumble);
  loupe02.setHoverImage("book.png");
  riddleScene.addGameObject(loupe02);
  
  //riddle book scene
  Scene riddleBookScene = new Scene("riddleBookScene", "riddleBook.png");
  MoveToSceneObject loupe09 = new MoveToSceneObject("goBackRiddleScene", 0, 0, 1280, 720, "riddleBook.png", "riddleScene");
  loupe09.addSoundFile(paperRumble);
  riddleBookScene.addGameObject(loupe09);
  

  // puzzle Scene
  Scene puzzleScene = new Scene("puzzleScene", "puzzleSceneBG.png");
  RequireObject loupe03 = new RequireObject("requiresScythe_puzzleScene", 300, 383, 48, 93, "Scythe_Mold.png", "Looks like a scythe fits in here", scythe, crossObject, "puzzleSceneBG2.png");
  loupe03.addSoundFile(scythePlace);
  puzzleScene.addGameObject(loupe03);
  fill(0);
  textSize(40);
  text("EYE NEEDED", 640, 400);

  //light Scene
  Scene lightScene = new Scene("lightScene", "lightSceneBG.png");
  //MoveToSceneObject goToAct2MirrorObject = new MoveToSceneObject("goTolightScene_act2_lightScene", 1040, 496, 20, 20, "mirror.png", "lightScene_act2");
  //lightScene.addGameObject(goToAct2MirrorObject);
  RequireObject loupe04 = new RequireObject("requiresMirror_lightScene", 1179, 645, 62, 75, "Rock.png", "The light could be reflected somehow...", mirror, "lightScene_act2"); //instead of placing a mirror it changes the scene background
  loupe04.addSoundFile(mirrorPickUp);
  lightScene.addGameObject(loupe04);

  //statue Scene
  Scene statueScene = new Scene("statueScene", "statueSceneBG.png");
  CollectableObject scytheObject = new CollectableObject("scythe_lightScene", 616, 280, 86, 55, scythe);
  scytheObject.addSoundFile(scythePickUp);
  statueScene.addGameObject(scytheObject);



  //scenes 5 - 10 are the same room but after some changes have taken effect
  //riddle Scene act2
  Scene riddleScene_act2 = new Scene("riddleScene_act2", "riddleSceneBG.png");
  MoveToSceneObject loupe05 = new MoveToSceneObject("goToriddleBookScene_act2", 533, 395, 218, 120, "book.png", "riddleBookScene_act2");
  loupe05.addSoundFile(paperRumble);
  loupe05.setHoverImage("book.png");
  riddleScene_act2.addGameObject(loupe05);
  loupe06.setHoverImage("chestOpen.png");
  riddleScene_act2.addGameObject(loupe06);

  //riddle book act2 scene
  Scene riddleBookScene_act2 = new Scene("riddleBookScene_act2", "riddleBook.png");
  MoveToSceneObject loupe10 = new MoveToSceneObject("goBackRiddleScene_act2", 0, 0, 1280, 720, "riddleBook.png", "riddleScene_act2");
  loupe10.addSoundFile(paperRumble);
  riddleBookScene_act2.addGameObject(loupe10);
  
  //puzzle Scene act2
  Scene puzzleScene_act2 = new Scene("puzzleScene_act2", "puzzleSceneBG2.png");
  fill(0);
  textSize(40);
  text("EYE NEEDED", 640, 400);

  
  //statue Scene act2
  Scene statueScene_act2 = new Scene("statueScene_act2", "statueSceneBG2.png");
  MoveToSceneObject goToAct3RubyObject = new MoveToSceneObject("ruby_statueScene_act2", 600, 304, 31, 20, "GemEye_InBowl.png", "puzzleScene_act3"); //anubis eye for the door
  goToAct3RubyObject.addSoundFile(gemPickup);
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
  MoveToSceneObject loupe07 = new MoveToSceneObject("goToriddleBookScene_act3", 533, 395, 218, 120, "book.png", "riddleBookScene_act3");
  loupe07.addSoundFile(paperRumble);
  loupe07.setHoverImage("book.png");
  riddleScene_act3.addGameObject(loupe07);
  TextObject loupe08 = new TextObject("smallText_riddleScene", 929, 570, 255, 150, "chestOpen.png", "Of course it is empty.");
  loupe08.setHoverImage("chestOpen.png");
  riddleScene_act3.addGameObject(loupe06);
  MoveToSceneObject navRiddleScene_act3 = new MoveToSceneObject("goTopuzzleScene_act3_riddleScene_act3", 1231, 358, 50, 50, "arrowRight.png", "puzzleScene_act3");
  riddleScene_act3.addGameObject(navRiddleScene_act3);
  
  //riddle book act3 scene
  Scene riddleBookScene_act3 = new Scene("riddleBookScene_act3", "riddleBook.png");
  MoveToSceneObject loupe11 = new MoveToSceneObject("goBackRiddleScene_act3", 0, 0, 1280, 720, "riddleBook.png", "riddleScene_act3");
  loupe11.addSoundFile(paperRumble);
  riddleBookScene_act3.addGameObject(loupe11);

  //end scene
  Scene ending = new Scene("endScene", "Endscreee.png");

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

 
}

void draw()
{
  if(openingMovie.time() < 54  && devmode == false){
        image(openingMovie, 0, 0, wwidth, wheight);
        }
  else{
        openingMovie.pause();
        sound.volume(1);
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
