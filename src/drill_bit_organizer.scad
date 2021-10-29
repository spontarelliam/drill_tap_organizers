//---------------------
//   Drill bit organizer
//   Adam Spontarelli
//   11/2018
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 14;                // end bin number
units = "imperial";  // "imperial" or "metric"
invert = false;           // true flips the labels

bin_width = 18;
shortest_bin = 65;
growth_rate = 0.027;

l = 2;
w = shortest_bin;
h = 30;
l2 = l-1;
w2 = w-2;
h2 = h-2;

echo("last bin height = ", w+((ending_bin)*w*2*growth_rate));
echo("organizer width =", (ending_bin-starting_bin)*bin_width);

for (i=[starting_bin:ending_bin-1])
{
    difference()
    {
        difference()
        {
            hull()
            {
                translate([i*bin_width, i*w*growth_rate, 0])
                cube ([l, w+(i*w*2*growth_rate), h], center=true);
                translate([(i+1)*bin_width, (i+1)*w*growth_rate, 0])
                cube ([l, w+((i+1)*w*2*growth_rate), h], center=true);
            }
            hull()
            {
                translate([1+i*bin_width, i*w2*growth_rate, 2])
                cube ([l2, w2+(i*w2*2*growth_rate), h2], center=true);
                translate([(i+1)*bin_width-1, (i+1)*w2*growth_rate, 2])
                cube ([l2, w2+((i+1)*w2*2*growth_rate), h2], center=true);
            }
        }

        translate([250,15,h/3-2])
        rotate([-4, 90, 0])
        cylinder (h = 600, r=20, center = true, $fn=10);
        translate([250,15,h/3])
        rotate([-4, 90, 0])
        cube([16,38,600], center=true);
    }


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
        labels=["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"];
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

// Thinking about adding gauge holes to front, but doesn't seem practical
rotate([90,0,0])
translate([bin_width/2,0,40])
cylinder(h=20, r=1/16, center=true, $fn=100);
