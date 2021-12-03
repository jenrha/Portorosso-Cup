///Jennifer Hernandez-Argueta\\\
//CSC 103
//Chris Whitmire
//Final game project

////The Portorosso Cup\\\\



////////////////////////////global\\\\\\\\\\\\\\\
import processing.sound.*;
//declaring sound var
SoundFile pedalSound;
SoundFile yellSound;
//declaring song var
SoundFile backgroundMusic;
//SoundFile introMusic;

//timer vars
//platform
int platStartTime;
int platEndTime;
int platInterval= 1000;
//coin
int coinStartTime;
int coinEndTime;
int coinInterval= 1000;

//top bar info vars
  int coinScore;
  color coinCountC= color(200,30,255);
  color coinCountStroke= color(65,165,160);



/////////////////////////////////////////PLAYER
//declaring moveable character
Player bike;
//make character animation
Animation lucaAnimation;
//array of images Luca and Alberto on bike
//9 slots
PImage[] lucaImages= new PImage [9];
//background pixelated Portorosso
PImage backgroundImg;
//platform animation
Animation buildingAnimation;
//array of images buildings
//1 slot
PImage[] buildingImages= new PImage [1];
//intro image
PImage introImage;
//win image
PImage winImage;
//lose image
PImage loseImage;

  
////////////////////////////////////////PLATFORMS    
//arraylist
ArrayList<Platform> platformList;   
////var representing total plats in array
int numPlats= 1;
//////make array of platforms
Platform[] platArray= new Platform [numPlats];
int rowX;
int rowY;
int choose;
boolean isMiddle;
////////////////////////////////////////COINS   
//arraylist
ArrayList<Coin> coinList;   
////var representing total plats in array
int numCoins= 1;
//////make array of platforms
Coin[] coinArray= new Coin [numCoins];
int coinY;
/////////////STATE INT
int state;




////////////////////////////////////////////SETUP
void setup(){
//window size 
 size(1200, 800);
 
 introImage= loadImage("introscreen.jpg");
 winImage= loadImage("win.jpg");
 loseImage= loadImage("lose.jpg");
 
 //initialize state var
 state= 0; 
 
 //making timestamp that makes start of timer
  platStartTime= millis();
  coinStartTime= millis();
  
///SOUND
//initialize sound var
//pedal folley
pedalSound = new SoundFile (this, "pedal.wav");
//yell folley
yellSound = new SoundFile (this, "yell.wav");
//change volume and speed
pedalSound.amp (0.8);
pedalSound.rate (2.0);
yellSound.amp (0.9);
yellSound.rate (1.0);

//initialize song
backgroundMusic= new SoundFile  (this, "racemusic.wav");
//change volume
backgroundMusic.amp (0.4);
////initialize song
//introMusic= new SoundFile  (this, "intromusic.wav");
////change volume
//introMusic.amp (0.6);


///VISUALS
//background photo
backgroundImg= loadImage("background.png");
//resize
backgroundImg.resize(1200,800);

///animation images
//fill array with images from data folder
//player
  for (int i=0; i<lucaImages.length; i=i+1){
   lucaImages[i] = loadImage("luca"+i+".png");
  }
  lucaAnimation= new Animation( lucaImages, 0.3, 4.0);
//buildings
  for (int i=0; i<buildingImages.length; i=i+1){
   buildingImages[i] = loadImage("building"+i+".png");
  }
  buildingAnimation= new Animation( buildingImages, 1.0, 3.5);
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
////player
  //initializing player
  bike= new Player ();    
  //boolean movement for player
  bike.playerIsJumping= false;
  bike.playerIsFalling= false;
  bike.playerIsMovingLeft= false;
  bike.playerIsMovingRight= false;
  
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//platform extras and boolean for spawns
platformList= new ArrayList <Platform>();
  rowY = 750;
  isMiddle = false;
  
/////////////////////////////
//coin extras and boolean for unrendering 
coinList= new ArrayList <Coin>();
coinY = 750;

//end\\
}






////////////////////////////////////////////DRAW
void draw(){
  //finite state machine
  switch (state){
    
  //intro screen\\
    case 0:
    image(introImage, 0, 0);
    //music
 //if (introMusic.isPlaying()==false){
 //  introMusic.play();
 //}
  break;    
  
  
//////\\\\\\\  
//game case\\ 
  case 1:
//\\\\\\\\\\\\\\\\\\\\\\\\\\\ 
//background
  background(backgroundImg);

//music

 if (backgroundMusic.isPlaying()==false){
   backgroundMusic.play();
 }
 //if (introMusic.isPlaying()==true){
 //   introMusic.stop();
 //   }
    
//scores
   textSize(100);
   fill(coinCountC);
   text("$", 50, 150);
   text(coinScore, 150, 150);
     
////\\\\\\\\\\\\\\\\\\\\\\\\\\\  
//PLATFORM MAKER
////\\\\\\\\\\\\\\\\\\\\\\\\\\\
   rowX = 1000; 
   for (int i=0; i<platArray.length; i = i+1){  
///////////////////////BRAINS OF THE PLATFORM OPERATION
  platEndTime= millis();
  //timer if statement
  if (platEndTime- platStartTime >= platInterval){
      platformList.add(new Platform(rowX, rowY));      
      if (rowY <= height/2){
        isMiddle = true;
      }
      if(isMiddle == false){
        rowY = rowY - 100;
      }      
      else if(isMiddle == true){    
      if(rowY <= 700 && rowY >= 200){
      choose = int(random(0,2));
      if(choose == 0){
        rowY = rowY - 50;
      }
      else if(choose == 1){
        rowY = rowY + 50;
      }
      if (rowY==750 || rowY==800){
        rowY = rowY - 100;
      }
     if (rowY==130||rowY==150||rowY==170){
        rowY = rowY + 100;
      }
      if (rowY==180||rowY==190){
        rowY = rowY + 100;
      }
      } 
     }        
   platStartTime= millis();
  }
  }
  println(rowY);
  
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  
//fill array with platforms
  for (Platform aPlatform : platformList){
    //imageMode(CORNER);  
   //buildingAnimation.buildingDisplay(aPlatform.platX, aPlatform.platY);
 aPlatform.render(); 
   aPlatform.platformIsMovingLeft=true;
   aPlatform.move();
   aPlatform.bounds();
   aPlatform.landedOn();
  }
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  
//PLAYER
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//draw player on screen
 lucaAnimation.display(bike.playerX, bike.playerY);
 bike.bounds();
 bike.jump();
 bike.reachedTopOfJump();
 bike.fall();
 bike.land();
 bike.fallOffPlatform(platformList);
 bike.coinCount();
  
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//COIN MAKER
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
rowX = 1000;
   for (int i=0; i<coinArray.length; i = i+1){   
///////////////////////BRAINS OF THE COIN OPERATION
  coinEndTime= millis();
  //once platforms spawn in middle,
  if (coinEndTime- coinStartTime >= coinInterval){     
      coinList.add(new Coin(rowX, rowY));

      
      if(isMiddle == true){    
      if(rowY <= 700 && rowY >= 200){
      choose = int(random(0,2));
      if(choose == 0){
        coinList.add(new Coin(rowX+100, rowY-50));
        coinY = coinY - 50;
      }
      else if(choose == 1){
        coinY = coinY - 100;
      }
        if (rowY==750 || rowY==800){
        coinY = coinY - 50;
      }
     if (rowY==100 || rowY==150){
        coinY = coinY - 100;
      } 
      } 
     }        
   coinStartTime= millis();
  }
  }
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  
   //fill array with platforms
  for (Coin aCoin : coinList){
   aCoin.render(); 
   aCoin.bounds();
   aCoin.follow();
  }
 

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\    
//when to lose  
  if ((platformList.size()>=6)&&(bike.playerY>=700)){
   yellSound.play();
   state=2;
 }
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//when to win 
  if (coinScore>=5){
   state=3;
 }
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  break;

/////////////////////////////

  //TRY AGAIN SCREEN\\
  case 2:
  if ((platformList.size()>=6)&&(bike.playerY>=700)){ 
    imageMode(CORNER);
    image(loseImage, 0, 0);
   //music
   if (backgroundMusic.isPlaying()==true){
    backgroundMusic.stop();
    }
    //if (introMusic.isPlaying()==true){
    //introMusic.stop();
    //}
           delay(500);
   //score reset 
    coinScore=0;
   }
  break;
  
/////////////////////////////

  //WIN SCREEN\\
  case 3:
  if (coinScore>=5){ 
    imageMode(CORNER);
    image(winImage, 0, 0);
    
    //music
   if (backgroundMusic.isPlaying()==true){
    backgroundMusic.stop();
    }    
//if (introMusic.isPlaying()==true){
//    introMusic.stop();
//    }
        delay(500);
    coinScore=0;
  }
  break;

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\
}
}


////////////////////////////////////////////////KEYPRESSED
void keyPressed(){
   //jump
  if (key== CODED){
     if (keyCode== UP){
       if (bike.playerIsFalling == false){
         if (bike.playerIsJumping ==false){
       bike.playerIsJumping = true;
       bike.playerPeakY= bike.playerY - bike.playerJumpHeight; 
        lucaAnimation.isAnimating= true;
         pedalSound.play();
        }
       }
      }
     }
  
    if (key =='r'){
    setup();
    state= 1;    
    //if (introMusic.isPlaying()==true){
    //introMusic.stop();
    //}
   }
}
   
   
   
////////////////////////////////////////////////KEYRELEASED   
   void keyReleased(){
     //jump
  if (key== CODED){
     if (keyCode== UP){
       println("IT WORKS");
    }
   }
}
