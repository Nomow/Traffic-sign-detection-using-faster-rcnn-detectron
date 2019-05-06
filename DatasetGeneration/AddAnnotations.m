function [annotations] = AddAnnotations(annotations, img, bbox, category_id)
    [annotations] = AddImgToDataset(annotations, img);
    [annotations] = AddAnnotationToDatataset(annotations, bbox, category_id);
end


function [annotations] = AddAnnotationToDatataset(annotations, bbox, category_id)

    annotation_id = 0;
    if(~isempty(annotations.annotations))
        annotation_id = annotations.annotations{end}.id + 1;
    end

    img_annotations = struct;
    img_annotations.id = annotation_id;
    img_annotations.image_id = annotations.images{end}.id;
    img_annotations.category_id = category_id;
    img_annotations.segmentation = [];
    img_annotations.area = bbox(3) * bbox(4);
    img_annotations.bbox = bbox;
    img_annotations.iscrowd = 0;
    annotations.annotations{end + 1} = img_annotations;

end


function [data] = AddImgToDataset(data, img)
    id = 0;
    filename = string(id) + '.jpg';
    if(~isempty(data.images))
        id = data.images{end}.id + 1;
        filename = string(id) + '.jpg';
    end
    img_data = struct;
    img_data.license = 1;
    img_data.file_name = string(filename);
    img_data.coco_url = '';
    img_data.coco_url = '';
    img_data.height = size(img, 1);
    img_data.width = size(img, 2);
    img_data.flickr_url = '';
    img_data.id = id;
    data.images{end + 1} = img_data;
end
