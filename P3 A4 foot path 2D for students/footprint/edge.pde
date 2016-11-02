class EDGE 
  {
  pt A=P();
  pt B=P();

  EDGE() {};
  EDGE(pt Ap, pt Bp) {A=P(Ap); B=P(Bp);}

  void setTo(EDGE E) {A.setTo(E.A); B.setTo(E.B);}

  void show() {edge(A,B);}
  void showArrow() {arrow(A,B);}

  } // EDGE
 
EDGE E() {return new EDGE();}  
EDGE E(pt A, pt B) {return new EDGE(A,B);} 
EDGE E(EDGE E) {return E(E.A,E.B);} 

EDGE SERP(EDGE E0, float t, EDGE E1) 
  {
  pt A = E0.A; pt B=E0.B; pt C=E1.A; pt D=E1.B;  
  float a =spiralAngle(A,B,C,D); 
  float m =spiralScale(A,B,C,D);
  pt F = SpiralCenter(a, m, A, C); 
  return E(spiralPt(A,F,m,a,t),spiralPt(B,F,m,a,t));
  }
 
  
class WIPER 
  {
  int  f=0;
  EDGE E0=E(), E1=E();
  int maxf;
  
  WIPER() {}
  WIPER(EDGE E0p, EDGE E1p, int maxfp) {E0=E(E0p); E1=E(E1p); maxf=maxfp;}
  
  void setTo(EDGE E0p, EDGE E1p, int maxfp) {E0.setTo(E0p); E1.setTo(E1p); maxf=maxfp;}
  void snapTo(EDGE E0p, EDGE E1p) {E0.setTo(E0p); E1.setTo(E1p);}
  
  void showControl() {pen(dgreen,2); fill(dgreen); E0.showArrow(); pen(red,2); fill(red); E1.showArrow(); noFill();}
  
  EDGE Edge() 
    {
    f++; if 
    (f>maxf) f=0;
    t=(1.-cos(PI*2*f/maxf))/2; 
    return SERP(E0, t, E1);
    } 
    
  } // WIPER
  
WIPER W(EDGE E0, EDGE E1, int maxf) {return new WIPER(E0,E1,maxf);}
WIPER W(int maxf) {return new WIPER(E(),E(),maxf);}


void showPattern(EDGE E){
  pushMatrix();
  translate(E.A.x,E.A.y);
  for(int i=0; i<30; i++) {
     ellipse(0,0,d(E.A,E.B),d(E.A,E.B)/3);
     translate(E.B.x-E.A.x,E.B.y-E.A.y); rotate(a/10); scale(0.95,0.85); translate(-E.B.x+E.A.x,-E.B.y+E.A.y);
     }
  popMatrix();
  

  }