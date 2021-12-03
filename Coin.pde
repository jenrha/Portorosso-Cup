
//making new class "coins"
class Coin{
  
  //class variables
  int coinX; //x position of coin
  int coinY; //y position of coin
  int coinW; //width of coin
  color coinC; //coin color
  
  int coinXSpeed = 5;
  
  int coinTopBound;
  int coinBottomBound;
  int coinLeftBound;
  int coinRightBound;
  
   boolean coinIsMovingLeft;   
   
   boolean shouldBeRendered;  
  
  //constructor function
  Coin (int tempX, int tempY){
    coinW = 50;
    coinX = tempX+100;
    coinY = tempY;
    coinC = color (220, 190, 40); 
    shouldBeRendered = true;
  }
  
  /////functions\\\\\\
  //draw platform
  void render(){ 
    if (shouldBeRendered==true){
  //shouldBeRendered=true;
  fill(coinC);
  circle (coinX, coinY, coinW);
  }
  }
   //boundaries function
  void bounds(){
//    if (shouldBeRendered==true){
   //shouldBeRendered=true;
   coinTopBound= coinY;
   coinBottomBound= coinY;
   coinLeftBound= coinX;
   coinRightBound= coinX+coinW;
  }
//  }
  ////coin movement
  //moves coin with platform
  void follow(){
//    if (shouldBeRendered==true){
    //shouldBeRendered=true;
    coinX = coinX-coinXSpeed;
  }
// }


     
      
  
}
