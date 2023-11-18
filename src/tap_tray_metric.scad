//---------------------
//   Tap organizer
//   Adam Spontarelli
//   10/2021
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 12;                // end bin number
invert = true;

bin_width = 22;
shortest_bin = 55;
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
        cylinder (h = 700, r=20, center = true, $fn=10);
        translate([250,15,h/3])
        rotate([-5, 90, 0])
        cube([16,38,600], center=true);
    }

        labels=["M2x0.4", "M3x0.5", "M4x0.7", "M5x0.8", "M6x1.0", "M6x0.75", "M7x0.75", "M7x1.0", "M8x0.75", "M8x1.0", "M8x1.25", "M9x0.75", "M9x1.0", "M9x1.25", "M10x0.75", "M10x1.0", "M10x1.25", "M10x1.5", "M11x0.75", "M11x1.0", "M11x1.25", "M11x1.5", "M12x0.75", "M12x1.0", "M12x1.25", "M12x1.5", "M14x1.0", "M14x1.25", "M14x1.5", "M14x2.0", "M16x1.0", "M16x1.5", "M16x2.0", "M18x1.5"];
    
    
            if (invert==true) {

            translate([-1+i*bin_width,-shortest_bin/2-8,-h/2])
            cube([bin_width+2, 8,h]);
            translate([bin_width/2 + i*bin_width, -shortest_bin/2-4, h/2 - 4])
            rotate([0,0,180])
            color("red")
            linear_extrude(height = 5) {
                text(labels[i], size = 3.5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
            }

        }
        else {

        translate([-1+i*bin_width,-shortest_bin/2-10,-h/2])
        cube([bin_width+2, 10,h]);

        translate([bin_width/2 + i*bin_width, -shortest_bin/2-5, h/2 - 4])
        color("red")
        linear_extrude(height = 5) {
            text(labels[i], size = 3.5, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
        }
        }
    
}
