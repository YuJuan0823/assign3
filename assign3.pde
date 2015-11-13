float treasureX,treasureY;
float fighterX,fighterY;
float enemyX=0;
float enemyY=random(0,419);
float speed=1;
int bgx1, bgx2;
int gameState;
float blood=38.8;
final int GAME_START=1, GAME_RUN=2,GAME_OVER=3;

PImage bg1,bg2;
PImage img1,img2,img3,img4;
PImage start1,start2,end1,end2;

boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

int count=1;
int enemyMode;
final int line=1, slash=2, diamond=3; 
void setup () {
  size(640,480);
  //image loading
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  bg1=loadImage("img/bg1.png");
  bg1.resize(640,480);
  bg2=loadImage("img/bg2.png");
  bg2.resize(640,480);
  img3=loadImage("img/fighter.png");
  img4=loadImage("img/treasure.png");
  img1=loadImage("img/hp.png");
  img2=loadImage("img/enemy.png");
  //treasure locate
  treasureX=floor(random(0,599));
  treasureY=floor(random(0,439));
  image(img4,treasureX,treasureY);
  fighterX=589;
  fighterY=235;
  gameState=GAME_START;
  enemyMode=line;
}

void draw() {
  switch(gameState){
    
   case GAME_START:
    image(start2,0,0);
    if (mouseX<441 && mouseX>208 && mouseY>379 && mouseY<411){
     image(start1,0,0);
     if (mousePressed){
      switch(gameState){
      case GAME_START:
      gameState=GAME_RUN;
      break;
      }
     }
    }
    break;
    
   case GAME_RUN: 
    //scrolling background
    bgx1=bgx1%1280;
    bgx1++;
    image(bg1,bgx1,0);
    image(bg2,bgx1-640,0);
    image(bg1,bgx1-1280,0);
    //fighter 
    if(fighterX<0){
    fighterX=0;
    }
    if(fighterX>589){
    fighterX=589;
    }
    if(fighterY<0){
    fighterY=0;
    }
    if(fighterY>429){
    fighterY=429;
    }
    image(img3,fighterX,fighterY);
    
    //treasure
    image(img4,treasureX,treasureY);
    //hp bar
    fill(255,0,0);
    rect(13,3,blood,20);
    //hp
    image(img1,0,0);
   
    //fighter get treasure
    if (sq(treasureX+20.5-fighterX-25.5)+sq(treasureY+20.5-fighterY-25.5)<sq(20.5+25.5)){
    treasureX=floor(random(0,599));
    treasureY=floor(random(0,439));
    blood+=19.4;
    }
    
    //blood upper bound 
    if (blood>=194.0){
    blood=194.0;
    }
    

    switch(enemyMode){
      
    case line:

    for(int i=0;i<5;i++){
    enemyX+=speed;
    image(img2,enemyX-i*80,enemyY);
    
    }
    break;
    
    case slash:
    for(int i=0;i<5;i++){
    enemyX+=speed;
    image(img2,enemyX-80*i,enemyY+60*i);
    
    }
    break;
    
    case diamond:

    for(int i=0;i<5;i++){
    enemyX+=speed;
    if(i==0||i==4){
    image(img2,enemyX-80*i,enemyY);
    }else if(i==1||i==3){
    image(img2,enemyX-80*i,enemyY-60);
    image(img2,enemyX-80*i,enemyY-60+121);
    }else if(i==2){
    image(img2,enemyX-80*i,enemyY-120);
    image(img2,enemyX-80*i,enemyY-120+241);
    }
   
   
    }
    break;
    }// switch enemyMode end
    
    if(enemyX-80*4==width){
    count++;
    if(count%3==2){ 
    enemyX=-80;
    enemyY=random(0,175);
    switch(enemyMode){
    case line:
    enemyMode=slash;
    break;
    }
    }else if(count%3==0){
    enemyX=-80;
    enemyY=random(121,298);
    switch(enemyMode){
    case slash:
    enemyMode=diamond;
    break;
    }
    }else if(count%3==1){
    enemyX=-80;
    enemyY=random(0,419);
    switch(enemyMode){
    case diamond:
    enemyMode=line;
    break;
    }
    }
    
    
    }
    
    break;  
  }//switch gameState end

   

   //fighter control
   if(upPressed){
   fighterY-=speed;
   }
   if(downPressed){
   fighterY+=speed;
   }
   if(leftPressed){
   fighterX-=speed;
   }
   if(rightPressed){
   fighterX+=speed;
   }
   
   
   
   
   
  }//draw end
 
    

 

void keyPressed(){
  if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=true;
    break;
  case DOWN:
    downPressed=true;
    break;
  case LEFT:
    leftPressed=true;
    break;
  case RIGHT:
    rightPressed=true;
    break;
  }
  }

}
void keyReleased(){
if(key==CODED){
  switch(keyCode){
  case UP:
    upPressed=false;
    break;
  case DOWN:
    downPressed=false;
    break;
  case LEFT:
    leftPressed=false;
    break;
  case RIGHT:
    rightPressed=false;
    break;
  }
  }
}
