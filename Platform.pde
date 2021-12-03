//making new class "platform"
class Platform{
  
  //class variables
  int platX; //x position of platform
  int platY; //y position of platform
  int platW; //width of platform
  int platH; //height of playform
  color platC; //platform color
  
  int platformTopBound;
  int platformBottomBound;
  int platformLeftBound;
  int platformRightBound;
  
  int platformXSpeed = 5;
  
  boolean platformIsMovingLeft;
  boolean platformIsMovingRight;
  
   //constructor function
  Platform (int tempX, int tempY){
    platX = tempX;
    platW = 215;    
    platY = tempY;
    platH = height-platY;
    platC = color (230,245,25);
  }
  
   /////functions\\\\\\
  //draw platform
  void render(){
   fill(platC);
  rect (platX, platY, platW, platH);
  }
   //boundaries function
  void bounds(){
   platformTopBound= platY-3;
   platformBottomBound= platY+1;
   platformLeftBound= platX;
   platformRightBound= platX+platW;
  }
  
    ////platform movement
  //moves platform right to left
  void move(){
     //platform movement
  if ((platformIsMovingLeft == true)&&(platY>=0)){
    platX = platX -platformXSpeed;
  }
  }
 
  void landedOn(){    
   if ((bike.playerIsFalling == true)
   &&(bike.playerBottomBound > platformTopBound)
   &&(bike.playerTopBound < platformBottomBound)
   &&(bike.playerLeftBound < platformRightBound)
   &&(bike.playerRightBound > platformLeftBound)){
     bike.playerIsFalling=false; 
     bike.playerBottomBound= rowY;
    }
  }
  
  
  //end\\
  }
      
