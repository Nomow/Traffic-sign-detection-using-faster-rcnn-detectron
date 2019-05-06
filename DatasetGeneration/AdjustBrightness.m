function [adj_img] = AdjustBrightness(img, coeff)
    adj_img = coeff * img;
    adj_img(adj_img > 255) = 255;
end

