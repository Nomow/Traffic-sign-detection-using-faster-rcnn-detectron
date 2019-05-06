function [augmented_img] = AugmentFrame(bg_img, img, top_left_x, top_left_y, pixel_x, pixel_y)
        augmented_img = bg_img;
        for k = 1:size(pixel_y, 1)
            augmented_img(top_left_y + pixel_y(k), top_left_x + pixel_x(k), :) = img(pixel_y(k), pixel_x(k), :);
        end
        

end

