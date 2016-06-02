///draw_circle_outline(pos_x,pos_y,min_rad,max_thickness,color)
pos_x = argument0; // The X Position for the Circle
pos_y = argument1; // The Y Position for the Circle
min_rad = argument2; // The Radius for the Circle
max_thickness = argument3; // The Thickness for the Circle
circ_color = argument4; // The Color of the Outline

for (var i = 0; i <= max_thickness; i += 0.25) {
    draw_circle_colour(pos_x, pos_y, min_rad+i, circ_color, circ_color, true);
}
