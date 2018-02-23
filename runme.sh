#!/bin/sh
mkdir -p /build/tensorflow_pkg 2>> /dev/null
cd /build/tensorflow-1.0.1 && \
./configure < /tmp/tf-c7.ans && \
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package && \
bazel-bin/tensorflow/tools/pip_package/build_pip_package /build/tensorflow_pkg
yum -y remove numpy 
pip install -U numpy
pip install tensorflow
cd / && pip install --user /build/tensorflow_pkg/tensorflow-1.0.1-cp27-none-linux_x86_64.whl
pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp35-cp35m-linux_x86_64.whl
python /tmp/testTensor.py
#while :; do
#sleep 300
#done


