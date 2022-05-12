clear;
close all;

points = load("-ascii", "points.dat")

numberOfPoints = 9;

X     = points(1:numberOfPoints);
Y     = points(numberOfPoints+1:numberOfPoints*2);
CODES = points(numberOfPoints*2+1:numberOfPoints*3);

home         = find(CODES == 0)
intermediate = find(CODES == 1)
grasp        = find(CODES == 2)
release      = find(CODES == 3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inc = min(abs(diff(X)))/10;

section1 = home(1):grasp(1);
section2 = grasp(1):release(1);
section3 = release(1):home(2);

X1 = X(section1);
Y1 = Y(section1);

X2 = X(section2);
Y2 = Y(section2);

X3 = X(section3);
Y3 = Y(section3);

x1 = X1(1):inc*sign(X1(end)-X1(1)):X1(end)
spline1 = spline(X1,Y1, x1);


x2 = X2(1):inc*sign(X2(end)-X2(1)):X2(end)
spline2 = spline(X2,Y2, x2);

x3 = X3(1):inc*sign(X3(end)-X3(1)):X3(end)
spline3 = spline(X3,Y3, x3);


plot (
  x1, spline1, "g", X1, Y1,"b+",
  x2, spline2, "r", X2, Y2,"b+", 
  x3, spline3, "b", X3, Y3,"b+"
);
 
 
 