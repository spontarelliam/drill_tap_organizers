//---------------------
//   Tap organizer
//   Adam Spontarelli
//   10/2021
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 6;                // end bin number
units = "imperial";  // "imperial" or "metric"
invert = false;           // true flips the labels

bin_width = 28;
shortest_bin = 54;
growth_rate = 0.08;

l = 2;
w = shortest_bin;
h = 30;
l2 = l-1;
w2 = w-2;
h2 = h-2;

echo("last bin height = ", w+((ending_bin)*w*2*growth_rate));
echo("organizer width =", (ending_bin-starting_bin)*bin_width);


difference()
{
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
        rotate([-5, 90, 0])
        cylinder (h = 600, r=20, center = true, $fn=10);
        translate([250,15,h/3])
        rotate([-5, 90, 0])
        cube([16,38,600], center=true);
    }


    if (units == "imperial")
    {
        labels=["1/16", "1/8", "1/4", "3/8", "1/2", "3/4"];
        if (invert==true) {
            difference()
            {
                translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
                cube([bin_width+2, 10,h]);

                translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, h/2 - 4])
                rotate([0,0,180])
                linear_extrude(height = 5) {
                    text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
                }
            }
        }
        else {

                translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
                cube([bin_width+2, 10,h]);

                translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, h/2 - 4])
                color("red")
                linear_extrude(height = 5) {
                    text(labels[i], size = 5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
                }

        }
    }
}

color("red")
translate([0.5*(ending_bin - starting_bin)*bin_width,-shortest_bin/2-9.7,0])
rotate([90, 0, 0])
linear_extrude(height = 1) {
text("NPT Taps", size = 10, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
}
}