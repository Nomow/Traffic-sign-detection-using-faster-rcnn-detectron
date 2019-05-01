function [rotated_img] = RotateImg(img, angle)
    rotated_img = imrotate(img, angle, 'bilinear', 'crop');
end

