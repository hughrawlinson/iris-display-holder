irisDepth = 15.25;
forwardAngle = 50;
baseHeight = 100;
strutThickness = 7;
strutAngle = 40;
strutLength = baseHeight / cos(strutAngle) + 5;
saddlePerimeter = 5;
attachmentOffset = 14;
irisPush = 3;

module irisModel(o=0) {
  linear_extrude(15.25+o, center=true, convexity=100) {
    offset(o) {
      import(file="./iris-bottom-plate.svg", center = true);
    }
  }
}

module baseStrut() {
  translate([-tan(strutAngle) * baseHeight / 2,0,baseHeight / 2]) {
    rotate([0,strutAngle,0]) {
      cube([strutThickness, strutThickness, strutLength], center=true);
    }
  }
}

module baseStrutSegments() {
  difference() {
    for (i = [0,1,2]) {
      rotate([0,0,i * 360 / 3]) {
        baseStrut();
      }
    }
    translate([0,0,-100]) {
      cube(200, center=true);
    }
  }
}

module saddle() {
  difference() {
    irisModel(saddlePerimeter);
    translate([0,0,irisDepth*.5]){
      scale([1.01,1.01,1.5]) {
        irisModel();
      }
      translate([0,35,0]) {
        union() {
          //cube([200, 120, irisDepth*1.5], center=true);
          translate([0,0,10]) {
            rotate([-forwardAngle,0,0]) {
              cube([200,100,100], center=true);
            }
          }
        }
      }
    }
  }
}

module stand() {
  rotate([0,0,30]) {
    baseStrutSegments();
  }
  translate([0,irisPush,baseHeight + attachmentOffset + irisPush + 1]) {
    rotate([forwardAngle,0,0]) {
      saddle();
    }
  }
}

stand();
//saddle();

module baseHeightPlane() {
  translate([0,0,baseHeight]){
    color("red",0.2) {
      square(100, center=true);
    }
  }
}

//baseHeightPlane();

module dummyIris() {
  color("green", 0.5) {
    translate([0,0, baseHeight + attachmentOffset]) {
      rotate([forwardAngle,0,0]) {
        irisModel();
      }
    }
  }
}