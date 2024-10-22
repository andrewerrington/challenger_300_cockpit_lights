// Based on https://ehcknobs.com/rc4480.html

module torus(major_r, minor_r, theta=360){
    // Edge rounding using a torus
    rotate_extrude(angle=theta, convexity=10, $fn=60)
    translate([major_r+0.01, 0, 0])
    circle(r=minor_r, $fn=40);
}

function to_mm(x) = x * 25.4;

module rc4480(){

  // Body slopes up from 7/8" at the base to 27/32"
  // at the top, 0.5", with an r1/32" round on
  // the top edge and 12 flutes.
  
  difference(){
  // Body
  hull(){
  cylinder(d=to_mm(7/8),h=0.1,$fn=60);
  translate([0,0,to_mm((0.50)-(1/32))])  
  intersection(){
    torus(to_mm((27/32)-(1/32)-(1/32))/2,to_mm(1/32));
  }
}

    // Remove 12 indents around the perimeter
    for(i=[0:11]){
      rotate([0,0,(i*30)+15])
      translate([to_mm(7/8)/2,0,to_mm((1/8))])
      cylinder(d=to_mm(5/64),h=20,$fn=60); 
    }

  // Inset for label
  // Front slope
  translate([-to_mm(1/16),(-to_mm(7/8)/2)-0.5,0])
  rotate([-1.8,0,0])
  cube([to_mm(1/8),0.5+0.4,20]);
  // Top
  translate([-to_mm(1/16),(-to_mm(7/8)/2),to_mm(0.5)-0.4])
  cube([to_mm(1/8),to_mm((7/8)-0.53)/2,5]);
  // Top edge
  translate([-to_mm(1/16),(-to_mm(27/32)/2)+to_mm(1/32),to_mm((0.5)-(1/32))])
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
  rc4480();
  // Remove 6mm hole for switch
  // This example is for a dual-gang pot
  cylinder(d=9.5,h=3,$fn=20);
  difference(){
    cylinder(d=8.2,h=20,$fn=30);
    translate([-4.1,-1.2,5.5])
    cube([0.8+0.1,2.4,10]);
    translate([3.2,-1.2,5.5])
    cube([0.8+0.1,2.4,10]);
  }

}