
//making new class "player"
class Player{
  
  //class variables
  int playerX; //x position of player
  int playerY; //y position of player
  int playerW; //width of player
  int playerSpeed; //player speed
  color playerC; //player color
  
  int playerRunSpeed=10; //speed when moving left or right
  int playerJumpSpeed=15;
  int playerFallSpeed=30;
  
  int playerTopBound;
  int playerBottomBound;
  int playerLeftBound;
  int playerRightBound;
  
  boolean playerIsMovingLeft;
  boolean playerIsMovingRight;
  boolean playerIsJumping;
  boolean playerIsFalling;
  boolean onPlatform=false;
  
  int playerJumpHeight= 150;
  int playerPeakY = 560; 
  
  
  //constructor function
  Player (){
    playerW = 85;
    playerX = width/4;
    playerY = height- playerW;
    playerSpeed = 10;
    playerC = color (255, 0, 0);      
  }
    
  /////functions\\\\\\
  //draw player
  void render(){
   fill(playerC);
   square (playerX, playerY, playerW);
  }
  
  //jump functions
  //player is able to jump
    //boundaries function
  void bounds(){
   playerTopBound= playerY;
   playerBottomBound= playerY+playerW;
   playerLeftBound= playerX;
   playerRightBound= playerX+playerW;
  }
  void jump(){
  if ((playerIsJumping == true)&&
  (playerIsFalling == false)){
    playerY = playerY -playerJumpSpeed;
  }
  }
  //when does the player start falling?
  void reachedTopOfJump(){
    if ((playerIsJumping == true)&&
    (playerY <= playerPeakY)){
    playerIsJumping = false;
    playerIsFalling = true;
  }
  }
  //falling down
  void fall(){
    if ((playerIsFalling == true)&&
    (playerIsJumping == false)){
    playerY = playerY +playerFallSpeed;
  }
  }
  //landing on ground
  void land(){
   if (playerY>=height-playerW){
     playerIsFalling= false;
   }
  }
   
   
   //fall off platform
  void fallOffPlatform(ArrayList<Platform>platformList){
   if ((playerIsJumping==false)&&
   (playerBottomBound!=height)
   &&(playerY < height-playerW)){
    onPlatform= false;    
   for (Platform aPlatform : platformList){ 
    if ((bike.playerIsFalling == false)
   &&(bike.playerBottomBound > aPlatform.platformTopBound)
   &&(bike.playerTopBound < aPlatform.platformBottomBound)
   &&(bike.playerLeftBound < aPlatform.platformRightBound)
   &&(bike.playerRightBound > aPlatform.platformLeftBound)){
      onPlatform=true;       
    }
   }    
     if (onPlatform==false){
      playerIsFalling=true; 
     }
   }
  }
 
 
 
 
 //function
 void coinCount(){
     for (Coin aCoin : coinList){ 
     if ((playerBottomBound > aCoin.coinTopBound)
   &&(playerTopBound < aCoin.coinBottomBound)
   &&(playerLeftBound < aCoin.coinRightBound)
   &&(playerRightBound > aCoin.coinLeftBound)
   &&(aCoin.shouldBeRendered==true)){ 
        aCoin.shouldBeRendered=false;
        coinScore=coinScore+1;
        fill(coinCountC);
        text(coinScore, 100, 150);      
    }
   }
  }
    
//end\\  
}
