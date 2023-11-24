starting_bin = 0;     // changes the starting size label, 0 is smallest
ending_bin = 3;                // end bin number


shortest_bin = 54;
drawer_width = 558;
drawer_height= 40;

min_height = 20;
max_height = drawer_height - 2;
wall_thickness = 2;
bottom_thickness = 4;
xGR = 0.5; // x growth rate
yGR = 0.08; // y growth rate

bin_width = 20;

labels=[".05","1/16", "5/64", "3/32", "7/64", "1/8", "9/64", "5/32", "3/16",  "7/32", "1/4", "5/16", "3/8"];
nbins = len(labels);
organizer_width = drawer_width - 2; // margin
starting_bin_width = (organizer_width - nbins/2 * ((nbins-1)*xGR) + nbins*wall_thickness) / nbins ;

for (i=[0:nbins-1])
{
    
    bin_height = max_height;
    bin_width = starting_bin_width + i*xGR;
    xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
    
    translate([bin_width/2 + xpos, 4, bin_height])
    color("red")
    linear_extrude(height = 1) {
        text(labels[i], size = 4, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
    }
    
        difference(){
            max_length = shortest_bin + ((nbins-1) * shortest_bin * 2 * yGR);
            bin_height = max_height;
            bin_width = starting_bin_width + i*xGR;
            xpos = i*starting_bin_width + (i/2 * (i-1) * xGR) - wall_thickness*i;
            bin_length = shortest_bin+(i*shortest_bin*2*yGR);
            //L_width = bin_width - 2*wall_thickness;
            L_width = bin_length / 2;

            translate([xpos, 0, 0])
            cube ([bin_width, max_length, bin_height]);
            
            // negative space
            translate([xpos+wall_thickness, wall_thickness, bottom_thickness])
            cube([5+i*xGR, bin_length - 2*wall_thickness,50]);
            translate([xpos+wall_thickness, bin_length - 5 - wall_thickness, bottom_thickness])
            cube([L_width,5+i*xGR,40]);
            
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
    translate([-5, 40, organizer_width/cos(7)/2 +3])
    cylinder (h = organizer_width / cos(7)-2, r=5, center = true, $fn=10);
    //translate([organizer_width/2, -20, -h/2+5])
    rotate([-1, 90, 0])
    translate([-5, 10, organizer_width/2+1])
    cylinder (h = organizer_width, r=5, center = true, $fn=10);
    //----------------------------------------  
    
}
translate([80,95, max_height])
color("red")
linear_extrude(height = 1) {
    text("SAE Allen Keys", size = 16, font = "Cantarell Extra Bold", halign = "center", valign = "center", $fn = 16);
}