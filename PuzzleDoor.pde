class PuzzleDoor extends GameObject {
    
  int tileSize;
  boolean tileOne= false;
  boolean tileTwo= false;
  boolean tileThree= false;

  //boolean[][] pressed = new boolean [4][4];
  
  public PuzzleDoor(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    super (identifier, x,y, owidth, oheight, gameObjectImageFile);
    tileSize = owidth/4;    
  }
  
  public void mouseClicked() { 
    if (mouseX < x || mouseX > x+owidth || mouseY < y || mouseY > y+oheight) return;
    println("image clicked");
    
    int tileX = (mouseX - x)/tileSize;
    int tileY = (mouseY - y)/tileSize;
    
    println(tileX, tileY);
    
    //pressed[tileX][tileY] = true;
    
    if (tileX == 3 && tileY == 3) tileOne = true;
    else if (tileX == 0 && tileY == 2) tileTwo = true;
    else if (tileX == 3 && tileY == 0) tileThree = true;
    else {
      tileOne= tileTwo =tileThree = false;
    }
    
    
    if (tileOne && tileTwo && tileThree) sceneManager.goToScene("scene10");
  }
  
  public void draw() {
    super.draw();
    //rect (x,y,tileSize, tileSize); 
  }
  
}
