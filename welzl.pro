;     input: Finite sets P and R of points in the plane
;     output: Minimal disk enclosing P with R on the boundary, or undefined if no such disk exists
;     if P is empty or |R| ≥ 3:
;         if |R| = 1:
;             (we do this to support multisets with duplicate points)
;             (we assume that a circle with a radius of zero can exist)
;             p := R[0]
;             return circle(p, 0)
;         else if |R| = 2:
;             (we do this to support multisets with duplicate points)
;             (we use that the smallest circle between two points has a center at their midpoint)
;             (and the segment that passes through them is a diameter of the circle)
;             p0 := R[0]
;             p1 := R[1]
;             center := midpoint(p0, p1)
;             diameter := distance(p0, p1)
;             return circle(center, diameter / 2)
;         else if the points of R are cocircular:
;             return the ball they determine
;         else:
;             return undefined
; 
;     choose p in P (randomly and uniformly)
;     D := welzl(P - { p }, R)
;     if p is in D:
;         return D
;     return welzl(P - { p }, R ∪ { p })

FUNCTION welzl, p=p, r=r
   np=n_elements(p)
   nr=n_elements(r)
   IF (np eq 0) or (nr ge 3) THEN BEGIN
      IF nr eq 1 THEN BEGIN
         p=r[0]
         return, define_circle(p[0].x, p[0].y)
      ENDIF
      IF nr ge 2 THEN return, define_circle(r.x, r.y)
   ENDIF

   ip=0 ;not random yet
   IF np eq 1 THEN newp=[] ELSE newp=p[1:*]
   stop
   d=welzl(p=newp, r=p[0])  ;Assuming ip=0 here
   dist2=(P[ip].x-d.xcenter)^2 + (P[ip].y-d.ycenter)^2
   IF dist2 < d.r2 THEN return,d
   IF nr eq 0 THEN unionr=p[ip] ELSE unionr=[r,p[ip]]
   return, welzl(p=newp, r=unionr)
END
   
   
 