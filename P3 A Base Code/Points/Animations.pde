class Animations{
  vec up = V(0,1);
  vec left = V(1,0);
  
  void Animate(pts legA, pts legB, float angleA, float angleB, int t){
      pt K2 = legA.G[1];
      pt A2 = legA.G[2];
      pt E2 = legA.G[3];
      pt B2 = legA.G[4];
      pt T2 = legA.G[5];
    
      pt H=legB.G[0], K=legB.G[1], A=legB.G[2], E=legB.G[3], B=legB.G[4], T=legB.G[5]; // local copy of dancer points from points of Polyloop P
    
      pt c = P(B2);
      print(1/3);
      c = P(c, 1.0/3.0, V(B2,B));
      noFill(); pen(red,4);
      show(c);
      if (t==0){
        B2.setTo( P(100,B2.y));
        
        
      }
      
      if(t>=0 && t<=40){
        
      }
      
      H.setTo(P(c.x,H.y));
  
  }
  
}