class PuzzleDoor extends GameObject {
  SoundFile buttonPress = new SoundFile(catacombcrawl.this, "scythe.wav");
  SoundFile doorOpen = new SoundFile(catacombcrawl.this, "scythe_place.wav");
  SoundFile buttonReset = new SoundFile(catacombcrawl.this, "gem_Pickup.wav");

  public int tileSizeWidth;
  public int tileSizeHeight;
  boolean tileOne= false;
  boolean tileTwo= false;
  boolean tileThree= false;
  private int activeTiles = 1;
  private int tileX;
  private int tileY;

  private int tileXOld;
  private int tileYOld;
  private int targetTileX;
  private int targetTileY;

  //boolean[][] pressed = new boolean [4][4];
  
  public PuzzleDoor(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    super (identifier, x,y, owidth, oheight, gameObjectImageFile);
    tileSizeWidth = owidth/4;
    tileSizeHeight = oheight/4;
  }

  public void addPressedTile(){
    targetTileX =  (tileX * 124) +  (int) (tileX * 6.8) + x;
    targetTileY =  (tileY * 119) +  (int) (tileY * 8) + y;
    if(activeTiles == 1){
      catacombcrawl.tile1.setXY(targetTileX,targetTileY);
    }
    else if(activeTiles == 2){
      catacombcrawl.tile2.setXY(targetTileX,targetTileY);
    }
    else if(activeTiles == 3){
      catacombcrawl.tile3.setXY(targetTileX,targetTileY);
    }

  }
  public void resetPressedTiles(){
    catacombcrawl.tile1.setXY(-300,-300);
    catacombcrawl.tile2.setXY(-300,-300);
    catacombcrawl.tile3.setXY(-300,-300);
  }
  
  public void mouseClicked() {//
    tileX = (mouseX - x) / tileSizeWidth;
    tileY = (mouseY - y) / tileSizeHeight;
      if (mouseX < x || mouseX > x+owidth || mouseY < y || mouseY > y+oheight) return;
      println("image clicked");
      //println("mouse x: " +  mouseX +", x:  " + x + ", tilesize" + tileSize);
      println(tileX, tileY);
      activeTiles++;
      addPressedTile();
      //pressed[tileX][tileY] = true;
      checkAnswer();
  }
  public void checkAnswer(){
    if (tileX == 2 && tileY == 3) tileOne = true;
    else if (tileX == 0 && tileY == 2) tileTwo = true;
    else if (tileX == 3 && tileY == 0) tileThree = true;

    if (tileOne && tileTwo && tileThree && activeTiles == 4 ){
      doorOpen.play();
      sceneManager.goToScene("endScene");
    }
    else if(activeTiles > 3){
      tileOne = tileTwo = tileThree = false;
      resetPressedTiles();
      activeTiles = 1;
      buttonReset.play();
      //sceneManager.goToScene("puzzleScene_act3");
    }
    else{
      buttonPress.play();
    }

  }
  
  public void draw() {
    super.draw();
    //rect (x,y,tileSize, tileSize); 
  }
  
}
