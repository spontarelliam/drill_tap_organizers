//---------------------
//   Tap organizer
//   Adam Spontarelli
//   10/2021
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 13;                // end bin number
units = "imperial";  // "imperial" or "metric"


bin_width = 20;
shortest_bin = 54;
growth_rate = 0.02;

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
        rotate([-5, 90, 0])
        cylinder (h = 600, r=20, center = true, $fn=10);
        translate([250,15,h/3])
        rotate([-5, 90, 0])
        cube([16,38,600], center=true);
    }


    if (units == "imperial")
    {
        labels=["4-40", "6-32", "6-40", "8-32", "10-24", "10-32", "12-24", "1/4-20", "1/4-28", "5/16-18", "5/16-24", "3/8-16", "3/8-24", "7/16-14", "7/16-20", "1/2-13", "1/2-20"];

        translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);

        translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, h/2 - 4])
        color("red")
        linear_extrude(height = 5) {
            text(labels[i], size = 3.5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
        }
    }
}
