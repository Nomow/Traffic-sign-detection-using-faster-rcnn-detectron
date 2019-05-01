function [sheared_img] = ShearImg(img, shear_angle_x, shear_angle_y)
    shear_angle_x = shear_angle_x / 100;
    shear_angle_y = shear_angle_y / 100;
	transform_matrix = maketform('affine', [1 shear_angle_x 0; shear_angle_y 1 0; 0 0 1] );
    sheared_img = imtransform(img, transform_matrix); 
end

