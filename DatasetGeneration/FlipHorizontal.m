function [flipped_img] = FlipHorizontal(img, to_flip)
    flipped_img = img;
    if(to_flip)
        flipped_img = flipdim(img, 2);
    end
end

