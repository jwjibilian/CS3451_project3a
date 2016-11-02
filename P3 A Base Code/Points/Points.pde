// Template for 2D projects
// Author: Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!




//**************************** global variables ****************************
Animations anim = new Animations();
pts P = new pts(); // class containing array of points, used to standardize GUI
pts G = new pts();
int frame = 0;
float t=0, f=0;
boolean animate=false, fill=false, timing=false;
boolean showLetters=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
float _hipAngle=-PI/6;
float _hipAngle2=-PI/6;
pt _H=P(), _K=P(), _A=P(), _E=P(), _B=P(), _T=P(); // centers of Hip, Knee, Ankle, hEel, Ball, Toe 
float _rH=100, _rK=50, _rA=20, _rE=25, _rB=15, _rT=5; // radii of Hip, Knee, Ankle, hEel, Ball, Toe
//float _rH=200, _rK=20, _rA=20, _rE=25, _rB=15, _rT=5; // radii of Hip, Knee, Ankle, hEel, Ball, Toe
// leg measures (to update press '/' and copy print here):
float _hk=319.979, _ka=266.46463, _ae=28.718777, _eb=117.23831, _ab=113.9619, _bt=44.75581;
float _h=150; // height of _H
pt K2, A2, E2, B2, T2;
//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  //P.resetOnCircle(6); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  G.declare();
  G.addPt(P.G[0]);
  G.G[0] = P.G[0];
  G.addPt(P(P.G[1]));
  G.addPt(P(P.G[2]));
  G.addPt(P(P.G[3]));
  G.addPt(P(P.G[4].x + 100,P.G[4].y));
  G.addPt(P(P.G[5]));

  
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pen(grey,3); line(0,height-50,width,height-50);  // show ground lin
    
    K2 = G.G[1];
    A2 = G.G[2];
    E2 = G.G[3];
    B2 = G.G[4];
    T2 = G.G[5];
    
    pt H=P.G[0], K=P.G[1], A=P.G[2], E=P.G[3], B=P.G[4], T=P.G[5]; // local copy of dancer points from points of Polyloop P
    // Hip       Knee      Ankle    hEel       Ball      Toe
    noFill(); pen(black,4); 
    P.drawCurve();
    G.drawCurve();
       edge(_A,_B);  // add (foot top) edge from Ankle to Ball
    if(showLetters) 
      { 
      pen(black,2); 
      showId(_H,"H"); showId(_K,"K"); showId(_A,"A"); showId(_E,"E"); showId(_B,"B");showId(_T,"T");
      }
    noStroke(); fill(green);  student_displayDancer(H,K,A,E,B,T);
    noStroke(); fill(red); student_displayDancer(H, K2, A2, E2, B2, T2);
    //noStroke(); fill(green);  student_displayDancer(H,K2,A2,E2,B2,T2);
    student_computeDancerPoints(P,H,B,_hipAngle); // computes _H,_K,_A,_E,_B,_T  from measures and _hipAngle
    student_computeDancerPoints(G, H,B2,_hipAngle2);
    //noFill(); pen(red,2); student_displayDancer(_H,_K,_A,_E,_B,_T);
    
    noFill(); pen(red,4); 
    P.drawCurve(); 
    edge(_A,_B);   
    if(showLetters) 
      { 
      pen(red,2); 
      showId(_H,"H"); showId(_K,"K"); showId(_A,"A"); showId(_E,"E"); showId(_B,"B");showId(_T,"T");
      } 
   if (animate){
      pt c = P(B2);
      print(1/3);
      c = P(c, 1.0/3.0, V(B2,B));
      noFill(); pen(red,4);
      show(c);
      if (frame==0){
        B2.setTo( P(100,B2.y));
        _hipAngle2 = 0;
        
        B.setTo(P(400,B.y));
        
        
        
      }
      
      if(frame>=0 && frame<=40){
        
      }
      
      H.setTo(P(c.x,H.y));
     print("Animateing\n");
     
     frame++;
   }
    

  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  