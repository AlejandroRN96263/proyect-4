/*Proyecto 4 --> Alex Yuyez* °°°openCV°°° */

//import libraries 
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import processing.sound.*;

//variables
OpenCV cv;
Capture v;
SoundFile inicial;
SoundFile prev;
SoundFile next;
Rectangle[] faces;

boolean primera, segunda, tercera;

//void setup
void setup()
{
  size(640, 480);
  println(Capture.list());
  v = new Capture(this, 640, 480);
  cv = new OpenCV(this, v);
  inicial = new SoundFile(this, "1.mp3");
  prev = new SoundFile(this, "3.mp3");
  next = new SoundFile(this, "2.mp3");
  v.start();
}
//void draw
void draw()
{
  cv.loadImage(v);
  image(v, 0, 0);
  cv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = cv.detect();
  noFill();
  //noStroke();
  strokeWeight(3);
  if (faces.length >= 1) {
    //rectMode(CENTER);
    rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);

    if (faces[0].x<=100)
    {
      if (primera==true) {
        inicial.stop();
        next.stop();
        segunda = false;
        tercera = false;
      } else
      {
        prev.play();
        primera=true;
      }
    }

    if (faces[0].x>=250 && faces[0].x<=350)
    {
      if (segunda==true)
      {
        prev.stop();
        next.stop();
        primera=false;
        tercera=false;
      } else
      {
        inicial.play();
        segunda=true;
      }
    }

    if (faces[0].x >= 400)
    {
      if (tercera==true)
      {
        inicial.stop();
        prev.stop();
        primera=false;
        segunda=false;
      } else
      {
        next.play();
        tercera=true;
      }
    }
  
  }
  texto();
  textAlign(RIGHT);
  drawType(width * 0.25);
  textAlign(CENTER);
  drawType(width * 0.5);
  textAlign(LEFT);
  drawType(width * 0.75);
}



//void capture event
void captureEvent(Capture c) {
  c.read();
}

void texto()
{
  textAlign(CENTER);
  textSize(20);
  fill(random(255));
  text("Alejate un poco para interactuar", width/2, 95);
  text("Muevete hacia la izquierda o a la derecha", width/2, 115);
}

void drawType(float x) {
  line(x, 0, x, 65);
  line(x, 220, x, height);
  fill(0);
  text("pon tu", x, 95);
  fill(51);
  text("rostro", x, 130);
  fill(204);
  text("por", x, 165);
  fill(255);
  text("aquí", x, 210);
}
