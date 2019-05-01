function [closed_img] = GetBinarizedImg(img, teshold_level)
    temp_img = im2bw(img, teshold_level);
    binarized_img = zeros(size(temp_img));
    binarized_img(temp_img == 0) = 1;
    radius = floor(size(binarized_img, 2) / 4);
    structuring_elem = strel('disk', radius);
    closed_img = imclose(binarized_img, structuring_elem);
end

