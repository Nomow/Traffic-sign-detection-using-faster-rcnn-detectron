function [imgs] = LoadImgs(directory, file_extension)
    directory = directory;
    file_name = dir(fullfile(directory, strcat('*.', file_extension))); % pattern to match filenames.
    imgs = {};
    for i = 1:numel(file_name)
        full_path = fullfile(directory,file_name(i).name);
        img = imread(full_path);
        imgs{end + 1} = img; % optional, save data.
    end

end

