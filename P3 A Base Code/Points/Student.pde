// Joshua Jibilian
// PLEASE PLACE YOUR CODE IN THIS TAB

void student_displayDancer(pt H, pt K, pt A, pt E, pt B, pt T) // displays dancer using dimensions
  {
  caplet(H,_rH,K,_rK);
  caplet(K,_rK,A,_rA);
  caplet(A,_rA,E,_rE);
  caplet(E,_rE,B,_rB);
  caplet(B,_rB,T,_rT);
  caplet(A,_rA,B,_rB);
  noFill(); pen(magenta,2); edge(H,P(H,R(V(0,100),_hipAngle)));
  }

// Recompute global dancer points (_H,..._T) from Hip center, Ball center, leg dimensions, and angle a btweeen HB and HK
void student_computeDancerPoints
    (
    pt H,     // hip center
    pt B,     // ball center 
    float a   // angle between HB and HK
    )
  {
   _H.setTo(H);

   _B.setTo(B); 
   
    _H.y = height-50-600;
   
   _B = P(B.x,(height-50)-_rB);
   
   _T = P(B.x + _bt, height-50);
   
   
   _K = P(_H);
   _K = P(_K, _hk/d(H,B), R(V(H,B),_hipAngle));
   
   _A = P(_B);
   float BK = d(B,_K);
   
   _A = P(_A, _ab/d(B,_K), R(V(B,_K),(float)-Math.acos(((_ab*_ab)+(BK*BK)-(_ka*_ka))/(2*_ab*BK))));

   
   _E = P(_B);
   _E = P(_E, _eb/d(_A,B), R(V(_B,_A),(float)-Math.acos(((_eb*_eb)+(_ab*_ab)-(_ae*_ae))/(2*_ab*_eb)))); 
   
   
  
   
   H.setTo(_H);
   B.setTo(_B);
   P.G[1] = _K;
   P.G[2] = _A;
   P.G[3] = _E;
   P.G[5] = _T;
   }
   
void caplet(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  show(A,rA);
  show(B,rB);
  // replace the line blow by your code to draw the proper caplet (cone) that the function displays th ecnvex hull of the two disks
  float distance = d(A,B);
  float x = (rA*(rA-rB))/distance;
  float y = (float)Math.sqrt((rA*rA)-(x*x));
  pt C = P(A);
  C = P(C, (x/distance), V(A,B));
  pt Cprime = P(C);
  C = P(C, (y/distance), R(V(A,B)));
  Cprime = P(Cprime, -(y/distance), R(V(A,B)));
  //show(Cprime, 10);
  //show(C,10);
  
  pt D = P(B);
  pt Dprime = P(B);
  D = P(D, -(rB/d(C,A)), V(C,A));
  
  Dprime = P(Dprime, rB/d(C,A), R(V(A,C), -2 * angle(B,A,C)));
  //show(Dprime,10);
  //show(D,10);
  
  
  
  
  
  cone(P(C,Cprime),d(C,Cprime)/2,P(D,Dprime),d(D,Dprime)/2);
  
  
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

    //(
    //pt H,     // hip center
    //float hk, // distance from to 
    //pt K,     // knee center 
    //float ka, // distance from to 
    //pt A,     // ankle center 
    //float ae, // distance from to 
    //pt E,     // heel center
    //float eb, // distance from to 
    //float ab, // distance from to 
    //pt B,     // ball center 
    //float bt, // distance from to 
    //pt T,     // toe center
    //float a   // angle between HB and HK
    //)