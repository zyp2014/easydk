#! /bin/bash
CURRENT_DIR=$(dirname $(readlink -f $0) )

pushd $CURRENT_DIR

mkdir -p cache

# download 270 model and labels
if [ ! -f "cache/resnet50_offline.cambricon" ]; then
  wget -O cache/resnet50_offline.cambricon http://video.cambricon.com/models/MLU270/Classification/resnet50/resnet50_offline.cambricon
fi
if [ ! -f "cache/synset_words.txt" ]; then
  wget -O cache/synset_words.txt http://video.cambricon.com/models/MLU270/Classification/resnet50/synset_words.txt
fi
model_file="${CURRENT_DIR}/cache/resnet50_offline.cambricon"
label_path="${CURRENT_DIR}/cache/synset_words.txt"
data_path="${CURRENT_DIR}/../data/videos/cars.mp4"

GLOG_v=3 ../bin/classification  \
     --model_path $model_file \
     --label_path $label_path \
     --data_path $data_path \
     --show=false \
     --save_video=true \
     --wait_time 0 \
     --repeat_time 0
popd
