function [scaled_img] = ResizeBasedOnBackgroundSize(img, coeff, bg_width, bg_height)
    obj_height = size(img, 1);
    obj_width = size(img, 2);
    new_coeff = 0;
    % scale coeff of obj depending on img size
    if(bg_width > bg_height)
        new_coeff =  (bg_width * coeff) / obj_width; 
    else
        new_coeff =  (bg_height * coeff) / obj_height; 
    end
    scaled_img = imresize(img, new_coeff);     
end

