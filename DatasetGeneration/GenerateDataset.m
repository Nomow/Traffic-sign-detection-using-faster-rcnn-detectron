directory = '/home/vtpc/Documents/Alvils/traffic-sign-detection/data/signs';
video = VideoReader('/home/vtpc/Documents/Alvils/traffic-sign-detection/data/videos/vid1.mp4');
path_to_data = "/home/vtpc/Documents/Alvils/traffic-sign-detection/data/datasets/";
path_to_annotations = path_to_data + "annotations/train.json";

annotations = LoadAnnotations(path_to_annotations);

video.CurrentTime = 0;
nb_of_frames = video.Duration * video.FrameRate;
frame_from = round(video.FrameRate * 10);
frame_to = round(nb_of_frames - video.FrameRate * 10);

%% binarizes imgs
object_imgs = LoadImgs(directory, 'jpg')
nb_of_classes = length(object_imgs)
nb_of_imgs_per_class = 10000;
for i = 1:nb_of_classes
    binarized__object_imgs{i} = GetBinarizedImg(object_imgs{1}, 0.9);
end

%% adds categories
for i = 1:nb_of_classes
    categories = struct;
    categories.supercategory = string(i);
    categories.id = i;
    categories.keypoints = {};
    categories.name = string(i);
    categories.skeleton =  {};
    annotations.categories{end + 1} = categories;
end





%% generates dataset
black_rgb = [0 0 0]';
for i = 1:nb_of_classes
    object_img = object_imgs{i};
    object_binary_img = binarized__object_imgs{i};
    i
    for j = 1:nb_of_imgs_per_class
        % rotation
        rotation_angle = randi([-35, 35]);
        rotated_img = RotateImg(object_img, rotation_angle);
        rotated_object_binary_img = RotateImg(object_binary_img, rotation_angle);
        % shears image
        shear_angle_x = randi([-15, 15]);
        shear_angle_y = randi([-75, 75]);
        sheared_img = ShearImg(rotated_img, shear_angle_x, shear_angle_y);
        sheared_object_binary_img = ShearImg(rotated_object_binary_img, shear_angle_x, shear_angle_y);

        %flips horizontal
        flip_img = 0;
        flipped_img = sheared_img;
        flipped_object_binary_img = sheared_object_binary_img;
        if(flip_img)
            flipped_img = flipdim(sheared_img, 2);
            flipped_object_binary_img = flipdim(sheared_object_binary_img, 2);
        end
        
 
        %%
        brightness_from = 0.5;
        brightness_to = 1.5;
        brightness_coeff = (brightness_to - brightness_from)* rand() + brightness_from;
        contrasted_img = brightness_coeff * flipped_img;
        contrasted_img(contrasted_img > 255) = 255;
        
        % gets random frame of video
        random_frame_index = randi([frame_from frame_to]);
        frame = ReadVideoFrame(video, random_frame_index);
        
        %crop
        cropped_frame = RndCrop(frame);
        
        %flips horizontal        
        flip_frame = randi([0 1]);
        flipped_frame = cropped_frame;
        if(flip_frame)
            flipped_frame = flipdim(cropped_frame, 2);
        end
        
        %% adds object to img
        [frame_height, frame_width, frame_dim] = size(cropped_frame);   
        
        %gets image pixels without background
        img_data_index = find(flipped_object_binary_img > 0);
        [row, col] = ind2sub(size(flipped_object_binary_img), img_data_index);
       
        obj_height = max(row) - min(row);
        obj_width = max(col) - min(col);
        
        resize_coeff_from = 0.05;
        resize_coeff_to = 0.15;
        resize_coeff = (resize_coeff_to - resize_coeff_from)* rand() + resize_coeff_from;
        new_coeff = 0;
        % scale coeff of obj depending on img size
        if(frame_width > frame_height)
            new_coeff =  (frame_width * resize_coeff) / obj_width; 
        else
            new_coeff =  (frame_height * resize_coeff) / obj_height; 
        end
        scaled_obj_img = imresize(contrasted_img, new_coeff);
        
        
        blur_from = 0;
        blue_to = 1;
        blur_coeff = (blue_to - blur_from)* rand() + blur_from;
        blurred_obj_img = scaled_obj_img;
        if (blur_coeff ~= 0)
            blurred_obj_img = imgaussfilt(scaled_obj_img, blur_coeff);
        end
        
        scaled_binary_obj_img = imresize(flipped_object_binary_img, new_coeff);
        scaled_binary_obj_img(scaled_binary_obj_img > 0.99) = 1;
        scaled_binary_obj_img(scaled_binary_obj_img < 0.99) = 0;

        %gets image pixels without background
        img_data_index = find(scaled_binary_obj_img > 0);

        [row, col] = ind2sub(size(scaled_binary_obj_img), img_data_index);
        obj_height = max(row) - min(row);
        obj_width = max(col) - min(col);
        
        %%
        treshold_height_min = 1;
        treshold_height_max = frame_height - obj_height;
        top_left_y = randi([treshold_height_min treshold_height_max]);
        
        treshold_width_min = 1;
        treshold_width_max = frame_width - obj_width;
        top_left_x = randi([treshold_width_min treshold_width_max]);
        
        augmented_frame = cropped_frame;
        for k = 1:size(row, 1)
            augmented_frame(top_left_y + row(k), top_left_x + col(k), :) = blurred_obj_img(row(k), col(k), :);
        end
        
        blur_from = 0;
        blue_to = 3;
        blur_coeff = (blue_to - blur_from)* rand() + blur_from;
        blurred_augmented_img = augmented_frame;
        if (blur_coeff ~= 0)
        	blurred_augmented_img = imgaussfilt(augmented_frame, blur_coeff);
        end
        
       
        brightness_from = 0.5;
        brightness_to = 1.5;
        brightness_coeff = (brightness_to - brightness_from)* rand() + brightness_from;
        contrasted_augmented_img = brightness_coeff * blurred_augmented_img;
        contrasted_augmented_img(contrasted_augmented_img > 255) = 255;

 
        bbox = [top_left_x - 1, top_left_y - 1, obj_width, obj_height];
        annotations = AddAnnotations(annotations, contrasted_augmented_img, bbox, (i));   
        img_path = path_to_data + "train/" + annotations.images{end}.file_name;
        imwrite(contrasted_augmented_img, img_path);
        if(mod(j, 10000) == 0)
            j
        end
    end
end


fid = fopen(path_to_annotations,'w');
fprintf(fid, '%s', jsonencode(annotations));

fclose(fid);



