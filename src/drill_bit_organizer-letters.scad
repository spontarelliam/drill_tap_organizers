//---------------------
//   Drill bit organizer
//   Adam Spontarelli
//   11/2023
//
// Writing this has taught me to never use OpenSCAD again. No variables?!?
// Why am I trying to do all this in one file if there aren't functions or
// variables? Repeat code is unavoidable.
//---------------------

shortest_bin = 100;
printer_width = 175;
drawer_width = 558;
drawer_height= 40;

min_height = 20;
max_height = drawer_height - 1;
wall_thickness = 2;
bottom_thickness = 4;
xGR = 0.37; // x growth rate
yGR = 0.01; // y growth rate

alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
        labels=[ for (i = [0:1:26]) str(alphabet[i]) ];

starting_bin = 0;    // start bin number
ending_bin = 26;     // end bin number
        
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
        
        // Thinking about adding gauge holes to front, but doesn't seem practical
        // you could fill them with supports then drill them out with the 
        // corresponding drill.
        // polynomial approximation close enough for my taste
        drill_radius = 25.4 / 2 * (0.000149 * pow(i,2) + 0.00363*i + .2335);
        bin_length = shortest_bin+(i*shortest_bin*2*yGR);
        translate([bin_width/2 + xpos, bin_length + 5 + drill_radius,30])
        cylinder(h=20, r= drill_radius, center=true, $fn=100);
    }

    //--------- lower ribs to help with pickup ---------
    rotate([-5, 90, 0])
    //translate([organizer_width/2, 30,-h/2+5])
    translate([-5, 70, organizer_width/cos(7)/2 +6])
    cylinder (h = organizer_width / cos(7)-2, r=5, center = true, $fn=10);
    //translate([organizer_width/2, -20, -h/2+5])
    rotate([-1, 90, 0])
    translate([-5, 15, organizer_width/2+1])
    cylinder (h = organizer_width, r=5, center = true, $fn=10);
    //----------------------------------------
           
}


translate([90,150, 40 - 4])
color("red")
linear_extrude(height = 5) {
    text("Letter Drills", size = 16, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
}
