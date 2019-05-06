function [blurred_img] = BlurImg(img, coeff)
    blurred_img = img;
    if (coeff ~= 0)
        blurred_img = imgaussfilt(img, coeff);
    end  
end

