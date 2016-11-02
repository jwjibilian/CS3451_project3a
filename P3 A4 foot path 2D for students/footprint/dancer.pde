int support=0; // ID of vertex where support foot is located
boolean WeightOnRight = true;
float time = 0;
float r=100;

void showDancerOnRight(pt A, char b, pt B, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on RIGHT",3);
  pt R=B; 
  pt L = N(0,A,.5,B,1,C,t);
  pt X = L(L,R,2./3);

  noStroke();
  fill(lime); cone(X,16,L,8); show(L,8); 
  fill(pink); cone(X,16,R,8); show(R,8); 
  fill(blue); show(X,16); 
  pen(blue,2); // arrow(X,40,W);
  }

void showDancerOnLeft(pt A, char b, pt B, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on Left",3);
  pt L=B; 
  pt R = N(0,A,.5,B,1,C,t);
  pt X = L(R,L,2./3);

  noStroke();
  fill(lime); cone(X,16,L,8); show(L,8); 
  fill(pink); cone(X,16,R,8); show(R,8); 
  fill(blue); show(X,16); 
  pen(blue,2); // arrow(X,40,W);
  }

void cone(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  vec T = U(A,B);
  vec N = R(T);
  pt LA = P(A,-rA,N);
  pt LB = P(B,-rB,N);
  pt RA = P(A,rA,N);
  pt RB = P(B,rB,N);
  beginShape(); v(LB); v(RB); v(RA); v(LA); endShape(CLOSE);
  }