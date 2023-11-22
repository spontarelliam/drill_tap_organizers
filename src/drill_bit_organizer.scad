//---------------------
//   Drill bit organizer
//   Adam Spontarelli
//   11/2023
//
// Writing this has taught me to never use OpenSCAD again. No variables?!?
//---------------------


starting_bin = 0;    // changes the starting size label, 0 is smallest
ending_bin = 29;     // end bin number
//units = "metric";  // "imperial" or "metric"
units = "imperial";  // "imperial", "metric", "gauge", "letter"
invert = false;      // true flips the labels


shortest_bin = 70;
printer_width = 175;
drawer_width = 558;
drawer_height= 40;

w = shortest_bin;
min_height = 20;
max_height = drawer_height - 1;
wall_thickness = 2;
bottom_thickness = 4;
xGR = 0.37; // x growth rate
yGR = 0.027; // y growth rate
        
nbins = ending_bin - starting_bin;
organizer_width = drawer_width - 2; // margin
starting_bin_width = (organizer_width - nbins/2 * ((nbins-1)*xGR) + nbins*wall_thickness) / nbins ;

echo("starting_bin_width width =", starting_bin_width);
echo("last bin length = ", shortest_bin+((ending_bin)*shortest_bin*2*yGR));
echo("organizer width =", organizer_width);
echo( organizer_width > printer_width ? "WARNING: Organizer larger than printer bed" : "" );
echo( organizer_width > drawer_width ? "ERROR: Organizer larger than drawer width" : "" );


for (i=[starting_bin:ending_bin-1])
{
    difference()
    {
        difference()
        {
            
            bin_length = shortest_bin+(i*shortest_bin*2*yGR);
            //bin_height = i*yGR + min_height; // alternative approach
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            
            //xpos = i==0 ? 0 : starting_bin_width * i + i^2 -i;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;

            translate([xpos, 0, 0])
            cube ([bin_width, bin_length, bin_height]);
            
            // negative space
            
            pocket_length = bin_length - 2*wall_thickness;
            translate([wall_thickness+xpos, 
                            wall_thickness, 
                            bottom_thickness])
            cube ([bin_width - 2*wall_thickness, pocket_length, 100]);
            
/*
                //w2+(i*w2*2*growth_rate)
                // w2+((i+1)*w2*2*growth_rate)
                pocket_width = bin_width - wall_thickness;
                bin_length = w;
                pocket_length = w+((i+1)*w*2*growth_rate) - 2*wall_thickness;
                //pocket_length = 67;
                translate([wall_thickness+i*bin_width, 
                            wall_thickness, 
                            bottom_thickness])
                cube ([1, pocket_length-wall_thickness, h]);
                translate([(i+1)*bin_width, 
                                wall_thickness, 
                                bottom_thickness])
                cube ([1, pocket_length, h]);*/
            
        }

        // thumb slot
        translate([250,3/4 * shortest_bin, bottom_thickness + 12])
        rotate([-4, 90, 0])
        cylinder (h = 800, r=11, center = true, $fn=10);
        translate([250,3/4 * shortest_bin, bottom_thickness + 12+50])
        rotate([-4, 90, 0])
        cube([100,22,800], center=true);
    }

    //--------- lower ribs to help with pickup ---------
    rotate([-7, 90, 0])
    //translate([organizer_width/2, 30,-h/2+5])
    translate([-5, 50, organizer_width/cos(7)/2 +6])
    cylinder (h = organizer_width / cos(7)-2, r=5, center = true, $fn=10);
    //translate([organizer_width/2, -20, -h/2+5])
    rotate([-1, 90, 0])
    translate([-5, 15, organizer_width/2+1])
    cylinder (h = organizer_width, r=5, center = true, $fn=10);
    //----------------------------------------

    if (units == "imperial")
    {
        labels=["1/16", "5/64", "3/32", "7/64", "1/8", "9/64", "5/32", "11/64", "3/16", "13/64", "7/32", "15/64", "1/4", "17/64", "9/32", "19/64", "5/16", "21/64", "11/32", "23/64", "3/8", "25/64", "13/32", "27/64", "7/16", "29/64", "15/32", "31/64", "1/2"];
        if (invert==true) {
                translate([-1+i*bin_width,-shortest_bin/2-8,0])
                cube([bin_width+2, 8,h]);

                translate([bin_width/2 + i*bin_width, -shortest_bin/2-4, h/2 - 4])
                rotate([0,0,180])
                color("red")
                linear_extrude(height = 5) {
                    text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
                }
        }
        else {

            //bin_height = i*yGR + min_height;
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
            
            translate([xpos, -8, 0])
            cube([bin_width, 8,bin_height]);
            translate([bin_width/2 + xpos, -4, bin_height - 4])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 4, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
    }
    else if (units == "metric")
    {
        labels=[ for (i = [1:0.5:13]) str(i) ];
        if (invert==true) {

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);
            translate([bin_width/2 + i*bin_width, -36, h/2 - 4])
            rotate([0,0,180])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
        else {

            //bin_height = i*yGR + min_height;
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
            
            translate([xpos, -8, 0])
            cube([bin_width, 8,bin_height]);
            translate([bin_width/2 + xpos, -4, bin_height - 4])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 4, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
    }
    
    else if (units == "gauge")
    {
        labels=[ for (i = [1:1:60]) str(i) ];
        if (invert==true) {

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);
            translate([bin_width/2 + i*bin_width, -36, h/2 - 4])
            rotate([0,0,180])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
        else {

            //bin_height = i*yGR + min_height;
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
            
            translate([xpos, -8, 0])
            cube([bin_width, 8,bin_height]);
            translate([bin_width/2 + xpos, -4, bin_height - 4])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 4, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
    }
    
    else if (units == "letter")
    {
        alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
        labels=[ for (i = [1:1:26]) str(i) ];
        if (invert==true) {

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);
            translate([bin_width/2 + i*bin_width, -36, h/2 - 4])
            rotate([0,0,180])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
        else {

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);

            translate([bin_width/2 + i*bin_width, -shortest_bin/2-4, h/2 - 4])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
    }
}

/*
// Thinking about adding gauge holes to front, but doesn't seem practical
rotate([90,0,0])
translate([bin_width/2,0,40])
cylinder(h=20, r=1/16, center=true, $fn=100);
*/
