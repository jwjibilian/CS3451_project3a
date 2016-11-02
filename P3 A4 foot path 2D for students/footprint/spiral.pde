//************************************************************************
//**** SPIRAL
//************************************************************************

// POINT ON SPIRAL FROM A WITH FIXED POINT G

// COMPUTE PARAMETERS OF SPIRAL MOTION THAT MORPHS EDGE(A,B) TO EDGE(C,D)
float spiralAngle(pt A, pt B, pt C, pt D) {return angle(V(A,B),V(C,D));}

float spiralScale(pt A, pt B, pt C, pt D) {return d(C,D)/d(A,B);}

pt SpiralCenter1(pt A, pt B, pt C, pt D)  // computes center of spiral that takes A to C and B to D
  {
  float m = d(C,D)/d(A,B);
  float a = angle(V(A,B),V(C,D));  
  float c = cos(a), s = sin(a);
  vec AC = V(A,C);
  vec ACo = R(AC);
  vec U = W(m*c-1,AC,m*s,ACo);
  float u2 = dot(U,U);
  float x = - dot(AC,U)/u2;
  float y = det(AC,U)/u2;
  return P(A,x,AC,y,ACo);
  }   

pt SpiralCenter2(pt A, pt B, pt C, pt D)  // computes center of spiral that takes A to C and B to D
  {
  float m = d(C,D)/d(A,B);
  float a = angle(V(A,B),V(C,D));  
  float c=cos(a), s=sin(a);
  vec U = V(m*c-1,m*s);
  float u2 = dot(U,U);
  vec CA = V(C,A);
  vec V = V(dot(U,CA)/u2,det(U,CA)/u2);
  return P(A,V);
  }
  
pt SpiralCenter3(pt A, pt B, pt C, pt D)  // computes center of spiral that takes A to C and B to D
  {
  float m = d(C,D)/d(A,B);
  float a = spiralAngle(A,B,C,D); 
  float c=cos(a), s=sin(a);
  float d = sq(c*m-1)+sq(s*m);
  float ex = c*m*A.x - C.x - s*m*A.y;
  float ey = c*m*A.y - C.y + s*m*A.x;
  float x=(ex*(c*m-1) + ey*s*m) / d;
  float y=(ey*(c*m-1) - ex*s*m) / d;
  return P(x,y);
  }  
 


// IMAGE OF POINT Q BY SPIRAL MOTION THAT MORPHS EDGE(A,B) AND EDGE(C,D)
pt SpiralCenter(float a, float m, pt A, pt C)  // computes center of spiral that takes A to C and B to D
  {
  float c=cos(a), s=sin(a);
  vec U = V(m*c-1,m*s);
  float u2 = dot(U,U);
  vec CA = V(C,A);
  vec V = V(dot(U,CA)/u2,det(U,CA)/u2);
  return P(A,V);
  }


pt spiral(pt A, pt B, pt C, pt D, float t, pt Q) 
  {
  float a =spiralAngle(A,B,C,D); 
  float s =spiralScale(A,B,C,D);
  pt G = SpiralCenter(a, s, A, C); 
  return L(G,R(Q,t*a,G),pow(s,t));
  }
  
// IMAGE OF POINT A BY SPIRAL MOTION THAT MORPHS EDGE(A,B) AND EDGE(C,D)
pt spiralA(pt A, pt B, pt C, pt D, float t) 
  {
  float a =spiralAngle(A,B,C,D); 
  float s =spiralScale(A,B,C,D);
  pt G = SpiralCenter(a, s, A, C); 
  return L(G,R(A,t*a,G),pow(s,t));
  }
    
  
// IMAGE OF POINT B BY SPIRAL MOTION THAT MORPHS EDGE(A,B) AND EDGE(C,D)
pt spiralB(pt A, pt B, pt C, pt D, float t) 
  {
  float a =spiralAngle(A,B,C,D); 
  float s =spiralScale(A,B,C,D);
  pt G = SpiralCenter(a, s, A, C); 
  return L(G,R(B,t*a,G),pow(s,t));
  }
 
 
// IMAGE OF POINT B BY SPIRAL MOTION THAT MORPHS EDGE(A,B) AND EDGE(B,C): USED FOR SPIRALINE SUBDIVISION
pt spiral(pt A, pt B, pt C, float t) 
  {
  float a =spiralAngle(A,B,B,C); 
  float s =spiralScale(A,B,B,C);
  pt G = SpiralCenter(a, s, A, B); 
  return L(G,R(B,t*a,G),pow(s,t));
  }

// DRAWS SPIRAL SEGMENT THROUGH 3 POINTS
void showSpiralThrough3Points(pt A, pt B, pt C) 
  {
  float a =spiralAngle(A,B,B,C); 
  float m =spiralScale(A,B,B,C);
  pt F = SpiralCenter(a, m, A, B); 
  beginShape();
    for(float t=-1.0; t<=1.05; t+=0.05) 
      v(spiralPt(B,F,m,a,t));
  endShape();
  }
 
pt spiralPt(pt A, pt F, float m, float a, float t)     //  A rotated by at and scaled by s^t wrt G
  {return L(F,R(A,t*a,F),pow(m,t));}  

void showSpiralPattern(pt A, pt B, pt C, pt D) 
  {
  float a =spiralAngle(A,B,C,D); 
  float m =spiralScale(A,B,C,D);
  pt F = SpiralCenter(a, m, A, C); 
  for(float t=0.05; t<.99; t+=0.05)
    edge(spiralPt(A,F,m,a,t),spiralPt(B,F,m,a,t));
  }
 
void showFrameOfSpiralPattern(pt A, pt B, pt C, pt D, float t) 
  {
  float a =spiralAngle(A,B,C,D); 
  float m =spiralScale(A,B,C,D);
  pt F = SpiralCenter(a, m, A, C); 
  edge(spiralPt(A,F,m,a,t),spiralPt(B,F,m,a,t));
  }
 

// SPHERICAL INTERPOLATION USED (WRONGLY) FOR VECTORS U AND V THAT MAUY NOT HAVE SAME MAGNITUDE
vec slerp(vec U, float t, vec V) 
  {
  float a = angle(U,V);
  float b=sin((1.-t)*a),c=sin(t*a),d=sin(a);
  return W(b/d,U,c/d,V); 
  }
  