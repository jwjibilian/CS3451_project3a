int support=0; // ID of vertex where support foot is located
boolean WeightOnRight = true;
float time = 0;
float r=100;

static vec right = null;

void showDancerOnRight(pt A, char b, pt B, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on RIGHT",3);
  
  pt R=B; 
  vec cross = W(V(B,A),V(B,C));
  pt crossPt = P(B, -25 * 1/n(cross), cross);
  pt L = N(0,A,.5,crossPt,1,C,t);
  pt X = L(L,R,2./3);
  
  if (right == null){
    right = R(V(P(X, 1/n(V(B,A)), V(B,A)),X));
  } else {
    right = R(right,angle(V(B,A),V(C,B))*1/maxf);
  }
  pt hipC = P(X,(1.0/2.0)*50,right);
  pt hipR = P(X,1*50,right);
  
  
 

  noStroke();
  fill(lime); cone(X,16,L,8); show(L,8); 
  fill(pink); cone(hipR,16,R,8); show(R,8); 
  fill(blue); show(hipC,16); 
  pen(blue,2); arrow(hipC,40,right);
  }

void showDancerOnLeft(pt A, char b, pt B, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on Left",3);
  
  pt L=B; 
   vec cross = W(V(B,A),V(B,C));
  pt crossPt = P(B, 25 * 1/n(cross), cross);
  pt R = N(0,A,.5,crossPt,1,C,t);
  pt X = L(R,L,2./3);
  
  if (right == null){
    right = R(V(P(X, -1/n(V(B,A)), V(B,A)),X));
  } else {
    right = R(right,angle(V(B,A),V(C,B))*1/maxf);
  }
  pt hipC = P(X); 
  hipC = P(hipC, (1.0/2.0)*50,right);
  pt hipR = P(X, 1*50,right);
  //hipR=P(X,(1.0/2.0)*50,right);


  noStroke();
  fill(lime); cone(X,16,L,8); show(L,8); 
  fill(pink); cone(hipR,16,R,8); show(R,8); 
  fill(blue); show(hipC,16); 
  pen(blue,2);  arrow(hipC,40,right);

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