# training example
python tools/train_net.py \
    --cfg /home/vtpc/Documents/Alvils/traffic-sign-detection/Detectron/configs/12_2017_baselines/newcfg.yaml \
    OUTPUT_DIR /home/vtpc/Documents/Alvils/traffic-sign-detection/detectron-output


# inference example
python2 tools/inference.py \
    --cfg /home/vtpc/Documents/Alvils/traffic-sign-detection/Detectron/configs/12_2017_baselines/newcfg.yaml \
    --output-dir /tmp/detectron-visualizations \
    --image-ext jpg \
    --wts /home/vtpc/Documents/Alvils/traffic-sign-detection/detectron-output/train/street_sign_train:street_sign_val/generalized_rcnn/model_final.pkl \
    --video_full_path /home/vtpc/Documents/Alvils/traffic-sign-detection/video2.mp4 \
    demo

