function [cropped_img] = RndCrop(img)
    [height, width, dim] = size(img);
    
    % calculates cropping size
    max_crop = 0.2;
    cropped_width = randi([1 round(width * max_crop)]) - 1;
    cropped_height = randi([1 round(height * max_crop)]) - 1;
    crop_x = 0;
    crop_y = 0;
    
    % calculates x min and y min for start of crop
    if(cropped_width ~= 0)
        crop_x = randi([0 (cropped_width -1)]) + 1;
    end

    if(cropped_height ~= 0)
        crop_y = randi([0 (cropped_height - 1)]) + 1;
    end
    
    % new img size 
    new_width = width - cropped_width;
    new_height = height - cropped_height;
    % crops img
    cropped_img = img;
    if(cropped_width ~= 0 | cropped_height ~= 0)
        cropped_img = imcrop(img,[crop_x crop_y new_width new_height]);
    end

end

