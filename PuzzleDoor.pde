class PuzzleDoor extends GameObject {
    
  int tileSize;
  boolean tileOne= false;
  boolean tileTwo= false;
  boolean tileThree= false;
  
  
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
    
    if (tileOne && tileTwo && tileThree) sceneManager.goToScene("scene10");
  }
  
  public void draw() {
    super.draw();
    rect (x,y,tileSize, tileSize); 
  }
  
}
