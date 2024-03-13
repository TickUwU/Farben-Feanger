import processing.sound.*; //Libraries für musik - Lade von Tools herunter ^^^
String version="1.7 (LAST Final!)";
String build="22-23,11,2023";
SoundFile bgMusic;
SoundFile bgGameOver;
SoundFile soundM;
SoundFile soundC; //Sound variabeln
PImage titel1;
PImage eimer;
PImage blauElement;
PImage gelbElement;
PImage rotElement;
PImage hertz;
boolean musiik=true;
PImage neuerVersuch;
int hertzFrames=0;
float eimerX=0;
float eimerY=0;
int eimerGröße=140;
int eimerHöhe=50;
int gameMode=1;
float eimerSpeed=7;
boolean gameOver=false;
boolean debugMode=false; //Debug mode, weil Processing's debug mode nicht funktioniert
boolean unbesigbar=false;
int hp=4;
int background=255;
int eimerR=255;
int eimerG=5;
int eimerB=75;
int eimerTranz=255;
int cooldown=0;
int eimerMode=1; //1=Rot, 2=Gelb, 3=Grün, 4=Blau, 5=Lila, 6=Schwartz, 7=Weiß
int ballMode=1;
int txtFade=0;
int ballX=500;
float ballY=-25;
int ballR;
int ballG;
int ballB;
int ballTranz=255;
int ballCooldown;
int ballSize=50;
float ballSpeed=2;
int punkte=0;
int letztePunkte=0;
int record=0;
Table recordT; //Tabelle für recorde
int randR;
int randL;
int randTranz=100;
int textTranz=100;
boolean gameStart=false;


void setup() {
size(1000,800);
frameRate(60);
rectMode(CENTER);
textAlign(CENTER);
randR=9;
randL=width-9;
noStroke();
eimerX=width/2;
eimerY=height-100;
soundC = new SoundFile(this, "soundC.wav");
soundM = new SoundFile(this, "soundM.wav");
bgGameOver = new SoundFile(this, "gameOver.wav");
ballX=int(random(5,896));
eimer=loadImage("eimerRot.png"); //Eimer Laden
neuerVersuch=loadImage("GameOver.png");
titel1 = loadImage("wt1.png");
//recordT = new Table(); //tabelle erstellen
//recordT.addColumn("neuerRecord"); //Tabellen Hauptgruppe(?) in der ersten Periode(?) erstellen
recordT = loadTable("data/recorde.csv", "header"); //Tabelle lade
record = recordT.getInt(recordT.getRowCount()-1,"neuerRecord"); //Record laden
}

void draw() { 
  background(background); //Jenach modus anderes Hintergrund
  //Titel Bild
  if(!gameStart){
    if(gameMode==1) { //Tietel Bild für Bunten modus
      noStroke();
  if(frameCount%20<=10){titel1=loadImage("wt1.png");}
  else if(frameCount%20<=20){titel1=loadImage("wt2.png");}
    }
    
    if(gameMode==2) { //Tietel Bild für Schwartz und Weiß modus
  if(frameCount%20<=10){titel1=loadImage("bt1.png");}
  else if(frameCount%20<=20){titel1=loadImage("bt2.png");}
  }
  
  image(titel1,0,0); //Tietel Bild einfügen
  
  if (keyCode==10||key==' '){ //Starten mit Lehrtste oder Eingabetaste
  gameStart=true; //Mit dieser Variable Schalte ich den title aus und Starte das spiel
if (gameMode==1){ //Schauen ob Bunt modus
bgMusic = new SoundFile(this, "musikW.wav");
bgMusic.loop();
ballMode=int(random(1,6));
eimerMode=1;
}
else{ // Wenn nicht dann Schwartz und weiß modus
ballMode=7;
eimerMode=7;
bgMusic = new SoundFile(this, "musikB.wav");
bgMusic.loop();
}
}
}

  if (gameStart==true) { // Schauen ob das spiel beginnt
    imageMode(CENTER);
    
    // Punkte, Rekord und punkte der letzten runde
  textSize(500); fill(eimerR,eimerG,eimerB,textTranz); text(punkte,width/2,height/2); textSize(30); text("Rekord: "+record+"\nPunkte letzte runde: "+letztePunkte,width/2,height/2+50);//Punke show
  
  //Version
  fill(eimerR,eimerG,eimerB,100);
  textSize(16); textAlign(RIGHT); text("Ver.: "+version+"\nBuild: "+build, width-11, height-33); textAlign(CENTER);

noStroke();
  fill(eimerR,eimerG,eimerB,randTranz); //Rand
  rectMode(CORNERS);
  rect(0,0,randR,height-9); rect(width,0,randL,height-9); rect(0,height-9,width,height);
  rectMode(CENTER);
  

  image(eimer,eimerX,eimerY);
  
  //DebugMode
  if (debugMode) {
  println("KeyCode: "+keyCode+"   Key: "+key+"   eimerMode: "+eimerMode+"   ballMode: "+ballMode+"   ballSpeed: "+ballSpeed+"\n   eimerSpeed: "+eimerSpeed+"   gameMode: "+gameMode);
  textSize(30); text("-=DebugMode=-\n1=ballSpeed+1\n2=ballSpeed-1\nQ=eimerSpeed+1\nE=eimerSpeed-1\ni=Unendlich HP="+unbesigbar+"\nX=EimerLila",120,height/2);
  if (key=='1' && keyPressed) {ballSpeed=ballSpeed+1;}
  else if (key=='2' && keyPressed) {ballSpeed=ballSpeed-1;}
  else if (key=='q' && keyPressed) {eimerSpeed=eimerSpeed+1;}
  else if (key=='e' && keyPressed) {eimerSpeed=eimerSpeed-1;}
  else if (key=='i' && keyPressed) {unbesigbar=!unbesigbar;}
  else if (key=='x' && keyPressed) {eimerMode=5;}
}
  

  //Game over
if (hp<=0 && unbesigbar==false) {
  if (musiik==true) {
    bgMusic.stop();
    bgGameOver.loop();
    musiik=false;
  }
  if (gameMode==1){
  eimerMode=6;}
  gameOver=true;
  image(neuerVersuch,width/2,500);
  if (keyPressed && keyCode==10) {
  letztePunkte=punkte;
  ballSpeed=2;
  punkte=0;
  gameOver=false;
  if (gameMode==1){ //Game mode bunt "laden"
    bgGameOver.stop();
    bgMusic.loop();
  eimerMode=1;
  musiik=true;
  } else{ // Game mode b n' w "Landen"
    eimerMode=7;
    bgGameOver.stop();
    bgMusic.loop();
    musiik=true;
  }
  hp=4;
  }
}

  //Ball
  if (gameMode==2) {
    if (ballMode==7)
    stroke(100);
    strokeWeight(3);
    }
  
if (ballY <= height-30 && !gameOver) {
  fill(ballR,ballG,ballB,ballTranz);
  circle(ballX,ballY,ballSize);
  ballY=ballY+ballSpeed;
} else {
  ballY = -50;
  ballX=int(random(5,896));
  if (gameMode==1){
  ballMode=(int(random(1,6)));

  } else {
    ballMode=7;

  }
  if (!gameOver) {soundM.play();}
  hp=hp-1;
}

  if(keyPressed && !gameOver){ //Eimer movement
    if(keyCode==39) {
      eimerX=eimerX+eimerSpeed;}
    else if(keyCode==37){
      eimerX=eimerX-eimerSpeed;}}

  if (eimerX>=width+41) { //Bildschierm loop
  eimerX=-40;}
  else if (eimerX<=-41) {
  eimerX=width+40;}
  
  // Bälle Collecten
  if (ballX+18>=eimerX-70 && ballX-18<=eimerX+70 && ballY-23<=eimerY+20 && ballY+23>=eimerY-25 && (ballMode==eimerMode || ballMode==5 || eimerMode==5)) {
      punkte++;
      ballY=-50;
      ballX=int(random(5,896));
      soundC.play();
      if (gameMode==1) {
      ballMode=(int(random(1,6)));
      } else {
        ballMode=7;
      }
      randR=randR+30; randL=randL-30; randTranz=randTranz+30; // Rand Flash 1
      ballSpeed=ballSpeed+0.2;
}

//Rand flash 2
if (randR!=9) {
  randR--; randL++; randTranz--;
}

  if (punkte>record) { //Recorde setzen
  record=punkte;
  TableRow newRow = recordT.addRow(); //Neue rihe auf der tabelle erstellen
  newRow.setInt("neuerRecord", record);
  saveTable(recordT, "data/recorde.csv");
}
  
  //Cooldown für den farben wechsel
  if (cooldown>=1) {fill(100,40); stroke(eimerR,eimerG,eimerB,170); strokeWeight(10); rect(900,140,100,cooldown*5); cooldown--; noStroke();}
  
  // Eimer Farben Ändern
  if (eimerMode==1) { //Rot=1
    eimer=loadImage("eimerRot.png");
    eimerR=255;
    eimerG=5;
    eimerB=80;
  }
  else if (eimerMode==2) { //Gelb=2
    eimer=loadImage("eimerGelb.png");
    eimerR=255;
    eimerG=215;
    eimerB=5;
}
  else if (eimerMode==3) { //Grün=3
    eimer=loadImage("eimerGrün.png");
    eimerR=5;
    eimerG=255;
    eimerB=100;
    }
  else if (eimerMode==4) { //Blau=4
    eimer=loadImage("eimerBlau.png");
    eimerR=5;
    eimerG=135;
    eimerB=255;
    }
  else if (eimerMode==5) { //Lila=5
    eimer=loadImage("eimerLila.png");
    eimerR=185;
    eimerG=0;
    eimerB=255;
    }
  else if (eimerMode==6) { //Schwartz=6
    eimer=loadImage("eimerSchwartz.png");
    eimerR=25;
    eimerG=25;
    eimerB=25;
  }
  else if (eimerMode==7) { //Weiß=7
    eimer=loadImage("eimerWeiß.png");
    eimerR=210;
    eimerG=210;
    eimerB=210;
  }
    // Ball Farben Ändern
    if (ballMode==1) { //Rot=1
    ballR=255;
    ballG=5;
    ballB=80;
  }
  else if (ballMode==2) { //Gelb=2
    ballR=255;
    ballG=215;
    ballB=5;
  }
  else if (ballMode==3) { //Grün=3
    ballR=5;
    ballG=255;
    ballB=100;
  }
  else if (ballMode==4) { //Blau=4
    ballR=5;
    ballG=135;
    ballB=255;
  }
    else if (ballMode==5) { //Lila=5
    ballR=185;
    ballG=0;
    ballB=255;
  }
    else if (ballMode==6) { //Schwartz=6
    ballR=25;
    ballG=25;
    ballB=25;
  }
    else if (ballMode==7) { //Weiß=7
    ballR=210;
    ballG=210;
    ballB=210;
  }
  
  if (gameMode==1) { // Game mode 1 Animationen
  //Hertzen Animation
    if (hp>=4 && frameCount%60<=30) {hertz=loadImage("4hf1.png");}
    else if (hp>=4 && frameCount%60<=60) {hertz=loadImage("4hf2.png");}
    if (hp==3 && frameCount%60<=30) {hertz=loadImage("3hf1.png");}
    else if (hp==3 && frameCount%60<=60) {hertz=loadImage("3hf2.png");}
    if (hp==2 && frameCount%60<=30) {hertz=loadImage("2hf1.png");}
    else if (hp==2 && frameCount%60<=60) {hertz=loadImage("2hf2.png");}
    if (hp==1 && frameCount%60<=30) {hertz=loadImage("1hf1.png");}
    else if (hp==1 && frameCount%60<=60) {hertz=loadImage("1hf2.png");}
    if (hp<=0 && frameCount%60<=30) {hertz=loadImage("0hf1.png");}
    else if (hp<=0 && frameCount%60<=60) {hertz=loadImage("0hf2.png");}
    image(hertz,120,120);
  
  
  
  
  //Deko elemente Animation
    if (hp>=4 && frameCount%60<=30){
    blauElement=loadImage("4bf1.png");
  }
    else if (hp>=4 && frameCount%60<=60){
    blauElement=loadImage("4bf2.png");
  }
    if (hp==3 && frameCount%60<=30){
    blauElement=loadImage("3bf1.png");
  }
    else if (hp==3 && frameCount%60<=60){
    blauElement=loadImage("3bf2.png");
  }
    if (hp==2 && frameCount%60<=30){
    blauElement=loadImage("2bf1.png");
  }
    else if (hp==2 && frameCount%60<=60){
    blauElement=loadImage("2bf2.png");
  }
    if (hp==1 && frameCount%60<=30){
    blauElement=loadImage("1bf1.png");
  }
    else if (hp==1 && frameCount%60<=60){
    blauElement=loadImage("1bf2.png");
  }
    if (hp<=0 && frameCount%60<=30) {
    blauElement=loadImage("0bf1.png");
    gelbElement=loadImage("0gf1.png");
    rotElement=loadImage("0rf1.png");
  }
    else if (hp<=0 && frameCount%60<=60){
    blauElement=loadImage("0bf2.png");
    gelbElement=loadImage("0gf2.png");
    rotElement=loadImage("0rf2.png");
  }
  if (frameCount%60<=30 && hp>=1){
    gelbElement=loadImage("gf1.png");
    rotElement=loadImage("rf1.png");
  } else if (frameCount%60<=60 && hp>=1){
   gelbElement=loadImage("gf2.png");
   rotElement=loadImage("rf2.png");
  }
    image(blauElement,715,460);
    image(gelbElement,770,160);
    image(rotElement,270,560);
  }
  
    if (gameMode==2) { // Gamemode 2 Animationen
  //Hertzen
    if (hp>=4 && frameCount%60<=30) {hertz=loadImage("4bw1.png");}
    else if (hp>=4 && frameCount%60<=60) {hertz=loadImage("4bw2.png");}
    if (hp==3 && frameCount%60<=30) {hertz=loadImage("3bw1.png");}
    else if (hp==3 && frameCount%60<=60) {hertz=loadImage("3bw2.png");}
    if (hp==2 && frameCount%60<=30) {hertz=loadImage("2bw1.png");}
    else if (hp==2 && frameCount%60<=60) {hertz=loadImage("2bw2.png");}
    if (hp==1 && frameCount%60<=30) {hertz=loadImage("1bw1.png");}
    else if (hp==1 && frameCount%60<=60) {hertz=loadImage("1bw2.png");}
    if (hp<=0 && frameCount%60<=30) {hertz=loadImage("0bw1.png");}
    else if (hp<=0 && frameCount%60<=60) {hertz=loadImage("0bw2.png");}
    image(hertz,120,120);
  
  
  
  
  //Deko elemente
    if (hp>=4 && frameCount%60<=30){
    blauElement=loadImage("4ff1.png");
  }
    else if (hp>=4 && frameCount%60<=60){
    blauElement=loadImage("4ff2.png");
  }
    if (hp==3 && frameCount%60<=30){
    blauElement=loadImage("3ff1.png");
  }
    else if (hp==3 && frameCount%60<=60){
    blauElement=loadImage("3ff2.png");
  }
    if (hp==2 && frameCount%60<=30){
    blauElement=loadImage("2ff1.png");
  }
    else if (hp==2 && frameCount%60<=60){
    blauElement=loadImage("2ff2.png");
  }
    if (hp==1 && frameCount%60<=30){
    blauElement=loadImage("1ff1.png");
  }
    else if (hp==1 && frameCount%60<=60){
    blauElement=loadImage("1ff2.png");
  }
    if (hp<=0 && frameCount%60<=30) {
    blauElement=loadImage("0ff1.png");
    gelbElement=loadImage("0sf1.png");
    rotElement=loadImage("0qf1.png");
  }
    else if (hp<=0 && frameCount%60<=60){
    blauElement=loadImage("0ff2.png");
    gelbElement=loadImage("0sf2.png");
    rotElement=loadImage("0qf2.png");
  }
  if (frameCount%60<=30 && hp>=1){
    gelbElement=loadImage("sf1.png");
    rotElement=loadImage("qf1.png");
  } else if (frameCount%60<=60 && hp>=1){
   gelbElement=loadImage("sf2.png");
   rotElement=loadImage("qf2.png");
  }
    image(blauElement,715,460);
    image(gelbElement,770,160);
    image(rotElement,270,560);
  }


  
  }
}
 
void keyPressed() {
  if (gameMode==1) {
  if (cooldown==0 && key=='w' || key=='W') { //Rot=1
    eimerMode=1;
    cooldown=30;
  }
  else if (cooldown==0 && key=='a' || key=='A') { //Gelb=2
    eimerMode=2;
    cooldown=30;
  }
  else if (cooldown==0 && key=='s' || key=='S') { //Grün=3
    eimerMode=3;
    cooldown=30;
  }
  else if (cooldown==0 && key=='d' || key=='D') { //Blau=4
    eimerMode=4;
    cooldown=30;
  }
  }
  
  
  if (gameMode==2) {
     if (cooldown==0 && key=='w' || key=='W') { //Weiß=7
    eimerMode=7;
    cooldown=30;
  }
  else if (cooldown==0 && key=='a' || key=='A') { //Weiß=7
    eimerMode=7;
    cooldown=30;
  }
  else if (cooldown==0 && key=='s' || key=='S') { //Weiß=7
    eimerMode=7;
    cooldown=30;
  }
  else if (cooldown==0 && key=='d' || key=='D') { //Weiß=7
    cooldown=30; 
  }
  }
  if (!gameStart && keyCode==39) {
   gameMode=2;
   background=0;
  }
    else if (!gameStart && keyCode==37) {
   gameMode=1;
   background=255;
  }
}
