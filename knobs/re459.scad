// Based on https://ehcknobs.com/re459.html

module torus(major_r, minor_r, theta=360){
    // Edge rounding using a torus
    rotate_extrude(angle=theta, convexity=10, $fn=60)
    translate([major_r+0.01, 0, 0])
    circle(r=minor_r, $fn=40);
}

function to_mm(x) = x * 25.4;

module re459(){

  // Body slopes up from 5/8" at the base to 19/32"
  // at the top, 0.56", with an r1/32" round on
  // the top edge and 8 flutes.
  
  difference(){
  // Body
  hull(){
  cylinder(d=to_mm(5/8),h=0.1,$fn=60);
  translate([0,0,to_mm((0.56)-(1/32))])  
  intersection(){
    torus(to_mm((19/32)-(1/32)-(1/32))/2,to_mm(1/32));
  }
}

    // Remove 8 indents around the perimeter
    for(i=[0:7]){
      rotate([0,0,(i*45)+22.5])
      translate([to_mm(5/8)/2,0,to_mm((1/16))])
      cylinder(d=to_mm(5/64),h=20,$fn=60); 
    }

  // Inset for label
  // Front slope
  translate([-to_mm(1/16),(-to_mm(5/8)/2)-0.5,0])
  rotate([-1.6,0,0])
  cube([to_mm(1/8),0.5+0.4,20]);
  // Top (goes 0.04" past centre)
  translate([-to_mm(1/16),(-to_mm(7/8)/2),to_mm(0.56)-0.4])
  cube([to_mm(1/8),to_mm((7/16)+0.04),5]);
  // Top edge
  translate([-to_mm(1/16),(-to_mm(19/32)/2)+to_mm(1/32),to_mm((0.56)-(1/32))])
  rotate([0,90,0])
  difference(){
    cylinder(r=to_mm(1/32)+0.5,h=to_mm(1/8),$fn=20);
    cylinder(r=to_mm(1/32)-0.4,h=to_mm(1/8),$fn=40);
    translate([-5,0,0])
    cube([10,10,10]);
    translate([0,-5,0])
    cube([10,10,10]);
  }
}

} // module()

difference(){
  re459();
  // Remove 6mm hole for switch
  //translate([0,0,-0.1])
  //cylinder(r=3,h=7+0.1,$fn=72);
  // 18-spline shaft
  translate([0,0,-0.1])
  cylinder(r=2.83,h=7+0.1,$fn=72);
  for(i=[0:17]){
      rotate([0,0,(i*20)])
      translate([2.8,0,-0.1])
      rotate([0,0,45])
      translate([-0.3,-0.3,0])
      #cube([0.6,0.6,7+0.1]); 
    }

}