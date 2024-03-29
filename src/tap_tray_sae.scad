//---------------------
//   Tap organizer
//   Adam Spontarelli
//   10/2021
//---------------------
starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 17;                // end bin number


shortest_bin = 54;
drawer_width = 558;
drawer_height= 40;

min_height = 20;
max_height = drawer_height - 2;
wall_thickness = 2;
bottom_thickness = 4;
xGR = 0.1; // x growth rate
yGR = 0.02; // y growth rate

bin_width = 20;

labels=["4-40", "6-32", "6-40", "8-32", "10-24", "10-32", "12-24", "1/4-20", "1/4-28", "5/16-18", "5/16-24", "3/8-16", "3/8-24", "7/16-14", "7/16-20", "1/2-13", "1/2-20"];
nbins = len(labels);
organizer_width = drawer_width - 2; // margin
starting_bin_width = (organizer_width - nbins/2 * ((nbins-1)*xGR) + nbins*wall_thickness) / nbins ;

echo("last bin height = ", w+((ending_bin)*w*2*growth_rate));
echo("organizer width =", (ending_bin-starting_bin)*bin_width);


for (i=[starting_bin:ending_bin-1])
{
    //bin_height = i*yGR + min_height;
    bin_height = max_height;
    bin_width = starting_bin_width + i*xGR;
    xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
    
    translate([xpos, -8, 0])
    cube([bin_width, 8,bin_height]);
    translate([bin_width/2 + xpos, -4, bin_height])
    color("red")
    linear_extrude(height = 1) {
        text(labels[i], size = 4, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
    }
    
    difference()
    {
        difference()
        {  
            bin_length = shortest_bin+(i*shortest_bin*2*yGR);
            max_length = shortest_bin + ((nbins-1) * shortest_bin * 2 * yGR);
            //bin_height = i*yGR + min_height; // alternative approach
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            
            //xpos = i==0 ? 0 : starting_bin_width * i + i^2 -i;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;

            translate([xpos, 0, 0])
            cube ([bin_width, max_length + 20, bin_height]);
            
            // negative space
            
            pocket_length = bin_length - 2*wall_thickness;
            translate([wall_thickness+xpos, 
                            wall_thickness, 
                            bottom_thickness])
            cube ([bin_width - 2*wall_thickness, pocket_length, 100]);
        }

        // thumb slot
        translate([250,2/3 * shortest_bin, bottom_thickness + 12])
        rotate([-3, 90, 0])
        cylinder (h = 800, r=11, center = true, $fn=10);
        translate([250,2/3 * shortest_bin, bottom_thickness + 12+50])
        rotate([-3, 90, 0])
        cube([100,22,800], center=true);

    }

    //--------- lower ribs to help with pickup ---------
    rotate([-5, 90, 0])
    //translate([organizer_width/2, 30,-h/2+5])
    translate([-5, 30, organizer_width/cos(7)/2 +6])
    cylinder (h = organizer_width / cos(7)-2, r=5, center = true, $fn=10);
    //translate([organizer_width/2, -20, -h/2+5])
    rotate([-1, 90, 0])
    translate([-5, 15, organizer_width/2+1])
    cylinder (h = organizer_width, r=5, center = true, $fn=10);
    //----------------------------------------     
}

translate([80,85, max_height])
color("red")
linear_extrude(height = 1) {
    text("Imperial Taps", size = 16, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
}
