//---------------------
//   Drill bit organizer
//   Adam Spontarelli
//   11/2018
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 4;                // end bin number
//units = "metric";  // "imperial" or "metric"
units = "imperial";  // "imperial" or "metric"
invert = false;           // true flips the labels

bin_width = 18;
shortest_bin = 70;
growth_rate = 0.027;
drawer_width = 558;
drawer_height= 40;
printer_width = 175;
organizer_width = (ending_bin-starting_bin)*bin_width;

l = 2;
w = shortest_bin;
h = 50;
l2 = l-1;
w2 = w-3;
h2 = h-3;
min_height = 20;
max_height = drawer_height;
wall_thickness = 4;

echo("last bin width = ", w+((ending_bin)*w*2*growth_rate));
echo("organizer width =", organizer_width);
echo( organizer_width > printer_width ? "ERROR: Organizer larger than printer bed" : "" );

for (i=[starting_bin:ending_bin-1])
{
    difference()
    {
        difference()
        {
            hull() //full pocket size
            {
                bin_length = w;
                bin_height = i + min_height;
                translate([i*bin_width, i*bin_length*growth_rate, 0])
                cube ([l, bin_length+(i*bin_length*2*growth_rate), h], center=false);
                translate([(i+1)*bin_width, (i+1)*w*growth_rate, 0])
                cube ([l, w+((i+1)*w*2*growth_rate), h], center=false);
            }
            hull() // negative space
            {
                translate([1+i*bin_width, i*w2*growth_rate, 2])
                cube ([l2, w2+(i*w2*2*growth_rate), h2], center=false);
                translate([(i+1)*bin_width-1, (i+1)*w2*growth_rate, 2])
                cube ([l2, w2+((i+1)*w2*2*growth_rate), h2], center=false);
            }
        }

        // thumb slot
        translate([250,15,-h/4+3])
        rotate([-4, 90, 0])
        cylinder (h = 600, r=11, center = true, $fn=10);
        translate([250,15,h/3])
        rotate([-4, 90, 0])
        cube([h-5,22,600], center=true);
    }

    //--------- lower ribs to help with pickup ---------
    rotate([-7, 90, 0])
    //translate([organizer_width/2, 30,-h/2+5])
    translate([h/2 -5, 20, organizer_width/cos(7)/2 +1])
    cylinder (h = organizer_width / cos(7)-2, r=5, center = true, $fn=10);
    //translate([organizer_width/2, -20, -h/2+5])
    rotate([-1, 90, 0])
    translate([h/2 -5, -20, organizer_width/2])
    cylinder (h = organizer_width, r=5, center = true, $fn=10);
    //----------------------------------------

    if (units == "imperial")
    {
        labels=["1/16", "5/64", "3/32", "7/64", "1/8", "9/64", "5/32", "11/64", "3/16", "13/64", "7/32", "15/64", "1/4", "17/64", "9/32", "19/64", "5/16", "21/64", "11/32", "23/64", "3/8", "25/64", "13/32", "27/64", "7/16", "29/64", "15/32", "31/64", "1/2"];
        if (invert==true) {
                translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
                cube([bin_width+2, 8,h]);

                translate([bin_width/2 + i*bin_width, -shortest_bin/2-4, h/2 - 4])
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
    else if (units == "metric")
    {
        labels=[ for (i = [1:0.5:20]) str(i) ];
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
    
    else if (units == "gauge")
    {
        tallest_bin = 50;
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

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);

            translate([bin_width/2 + i*bin_width, -shortest_bin/2-4, h/2 - 4])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
    }
    
    else if (units == "letter")
    {
        alphabet = ["A", "B", "C"];
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
