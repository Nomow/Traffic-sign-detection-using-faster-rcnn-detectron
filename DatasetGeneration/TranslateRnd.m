function [top_left_x, top_left_y] = TranslateRnd(bg_width, bg_height, obj_width, obj_height)
    treshold_height_min = 1;
    treshold_height_max = bg_height - obj_height;
    top_left_y = randi([treshold_height_min treshold_height_max]);
    treshold_width_min = 1;
    treshold_width_max = bg_width - obj_width;
    top_left_x = randi([treshold_width_min treshold_width_max]);
end

