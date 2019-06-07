# Traffic sign detection using faster-rcnn
Based on [Detectron](https://github.com/facebookresearch/Detectron.git) - by FacebookResearch.

## Information
Uses Faster-rcnn algorithm for street sign detection

## Installation
```
git clone https://github.com/Nomow/traffic-sign-detection.git && \
cd traffic-sign-detection && \
git clone https://github.com/facebookresearch/Detectron.git && \
mv inference/vis.py Detectron/detectron/utils/vis.py && \
mv inference/inference.py Detectron/tools/inference.py &&\
mv inference/dummy_datasets.py Detectron/detectron/datasets/dummy_datasets.py && \
cd weights && wget https://doc-0o-4c-docs.googleusercontent.com/docs/securesc/dgmrninebju0vne86gncqks29hid3p3p/f2kjlv6ubunup18djbe27sik54f2g4ne/1557302400000/12969208813296147128/12969208813296147128/1V4gwYBE6hYeGvFPUirog56ZBHyBc8FOK?e=download&nonce=ost3fjpd3btb0&user=12969208813296147128&hash=0omlrhsu2te8qfr413oue14938c1ljcn
```
## Training example
```
python2 Detectron/tools/train_net.py \
    --cfg config/12_2017_baselines/newcfg.yaml \
    OUTPUT_DIR detectron-output
```

## Inference example
```
python2 Detectron/tools/inference.py \
    --cfg config/newcfg.yaml \
    --output-dir /tmp/detectron-visualizations \
    --image-ext jpg \
    --wts weights/model_final.pkl \
    --video_full_path vids/video2.mp4 \
    demo
```

## Dataset generation
Run datasetGeneration.m file and add street signs and video to specific folders



