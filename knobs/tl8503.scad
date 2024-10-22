// Based on https://ehcknobs.com/tl8503.html

module torus(major_r, minor_r, theta=360){
    // Edge rounding using a torus
    rotate_extrude(angle=theta, convexity=10, $fn=60)
    translate([major_r+0.01, 0, 0])
    circle(r=minor_r, $fn=40);
}

function to_mm(x) = x * 25.4;

module tl8503(){
  difference(){
    union(){
  hull() {
  // Base
  cylinder(d=to_mm(7/8),h=to_mm(1/8),$fn=60);


  translate([0,0,to_mm((1/2)-(1/8))])  
  intersection(){
    torus(to_mm((3/4)-(1/8)-(1/16))/2,to_mm(1/8));
    translate([to_mm(-4/32),-to_mm(7/8)/2,-to_mm(1/8)])
    cube([to_mm(4/16),to_mm(7/8),to_mm(1/8)*2]);
  }
  
     // Lower finger grip left 
   translate([-to_mm(4/32),-to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([-to_mm(4/32),to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
   // Lower finger grip right 
   translate([to_mm(4/32),-to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([to_mm(4/32),to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);

  }
  
  // Rounded top
  hull(){
  translate([0,0,to_mm((3/4)-(1/8))])  
  intersection(){
    torus(to_mm((3/4)-(1/8)-(1/8))/2,to_mm(1/8));
    translate([to_mm(-3/32),-to_mm(7/8)/2,-to_mm(1/8)])
    cube([to_mm(3/16),to_mm(7/8),to_mm(1/8)*2]);
  }

  // Top edge right
    hull(){
  translate([to_mm(3/32),-to_mm((1/2)-(1/32))/2,to_mm((3/4)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([to_mm(3/32),to_mm((1/2)-(1/32))/2,to_mm((3/4)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
    }
  // Top edge left
    hull(){
  translate([-to_mm(3/32),-to_mm((1/2)-(1/32))/2,to_mm((3/4)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([-to_mm(3/32),to_mm((1/2)-(1/32))/2,to_mm((3/4)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
    }
    hull(){
        translate([0,0,to_mm((1/2)-(1/8))])  
  intersection(){
    torus(to_mm((3/4)-(1/8)-(1/16))/2,to_mm(1/8));
    translate([to_mm(-4/32),-to_mm(7/8)/2,-to_mm(1/8)])
    cube([to_mm(4/16),to_mm(7/8),to_mm(1/8)*2]);
  }

   // Lower finger grip left 
   translate([-to_mm(4/32),-to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([-to_mm(4/32),to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
   // Lower finger grip right 
   translate([to_mm(4/32),-to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
  translate([to_mm(4/32),to_mm((1/2))/2,to_mm((1/2)-(1/8))])
  sphere(r=to_mm(1/8),$fn=40);
}  
 }  // hull() 
 } // union()

  // Inset for label
  // Base
  translate([-to_mm(1/16),(-to_mm(7/8)/2)-0.5,0])
  cube([to_mm(1/8),0.5+0.4,5]);
  // Front slope
  translate([-to_mm(1/16),(-to_mm(7/8)/2)-0.5,to_mm(1/8)])
  rotate([-7.2,0,0])
  cube([to_mm(1/8),0.5+0.4,20]);
  // Top. Starts ~1/16" away from centre.
  translate([-to_mm(1/16),(-to_mm(7/8)/2),to_mm(3/4)-0.4])
  cube([to_mm(1/8),to_mm((7/16)-(1/16)),5]);
  // Top edge
  translate([-to_mm(1/16),(-to_mm(3/4)/2)+to_mm(1/8),to_mm((3/4)-(1/8))])
  rotate([0,90,0])
  difference(){
    cylinder(r=to_mm(1/8)+0.5,h=to_mm(1/8),$fn=20);
    cylinder(r=to_mm(1/8)-0.4,h=to_mm(1/8),$fn=40);
    translate([-5,0,0])
    cube([10,10,10]);
    translate([0,-5,0])
    cube([10,10,10]);
  }
  difference(){
    translate([to_mm(66/64),-20,to_mm(46/64)])
  rotate([-90,0,0])
  cylinder(r=to_mm(27/32),h=40,$fn=90);
  translate([0,-40,10.6])
   cube([80,80,80]);
  }
  difference(){
    translate([-to_mm(66/64),-20,to_mm(46/64)])
  rotate([-90,0,0])
  cylinder(r=to_mm(27/32),h=40,$fn=90);
  translate([-80,-40,10.6])
   cube([80,80,80]);
  }

  /*
  difference(){
  translate([to_mm(30/32),0,to_mm(24/32)])
  sphere(r=to_mm(26/32),$fn=60);
  translate([0,-40,10.6])
   cube([80,80,80]);
  }
  */
  } // difference()
} // module()

difference(){
  tl8503();
  // Remove 6mm hole for switch
  translate([0,0,0])
  cylinder(d=6,h=7.5,$fn=20);
}