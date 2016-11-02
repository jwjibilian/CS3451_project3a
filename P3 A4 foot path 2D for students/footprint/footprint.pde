// Template for 2D projects
// Author: Jarek ROSSIGNAC
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0, maxf=2*30;
boolean animate=true, fill=false, timing=false;
boolean showControl=true, showIDs=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
WIPER Wtl=W(120), Wtr=W(133), Wbl=W(97), Wbr=W(111);
int ne=10;
EDGE [][] E = new EDGE[ne][ne];
float a=0; // pattern increment angle
//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(800, 800);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  //P.resetOnCircle(4); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  P.resetLabels(); 
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  background(white); // clear screen and paints white background
  //if(animating) {f++; if (f>maxf) {animating=false;}}
  if(animating) {f++; if (f>maxf) {P.next(); animating=true; f=0;}}
  t=(1.-cos(PI*f/maxf))/2; 

  if(showControl) {pen(grey,2); P.drawCurve();}
  P.colorSteps();
  if(showIDs) {pen(grey,2); P.IDs();}
  
  P.showDancer(t);
  

  
  
  
  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  //if(filming) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  