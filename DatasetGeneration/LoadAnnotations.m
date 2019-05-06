% loads or creates json dataset
function [data] = LoadAnnotations(file_path)
    data = struct;
    if (exist(file_path, 'file'))
        data = loadjson(file_path);
    else
        data = struct;
        data.images = {};
        data.annotations = {};
        data.categories = {};
    end
    
end