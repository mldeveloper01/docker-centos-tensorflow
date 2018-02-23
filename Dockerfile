FROM centos:centos7

RUN yum -y update
RUN yum -y install wget tar gzip \
                   perl \
                   which findutils zip unzip zlib-devel \
                   java-1.8.0-openjdk-devel \
                   git \
                   numpy python-devel
RUN yum -y install centos-release-scl-rh 
RUN yum -y install devtoolset-3-gcc devtoolset-3-gcc-c++ devtoolset-3-binutils
RUN yum -y install epel-release
RUN yum -y install python-wheel python-pip
RUN yum -y install https://people.centos.org/tru/bazel-centos7/bazel-0.4.5-1.el7.centos.x86_64.rpm

#RUN chown $USER:$USER $HOME

ADD https://github.com/tensorflow/tensorflow/archive/v1.0.1.tar.gz /tmp/tensorflow-1.0.1.tar.gz
RUN mkdir /build && tar -C build -xzf tmp/tensorflow-1.0.1.tar.gz && /bin/rm /tmp/tensorflow-1.0.1.tar.gz
COPY ./runme.sh /tmp/runme.sh
COPY ./tf-c7.ans /tmp/tf-c7.ans
COPY ./testTensor.py /tmp/testTensor.py
ADD run.sh /run.sh
RUN chmod +x /*.sh
RUN chmod +x /tmp/runme.sh
RUN cat /tmp/runme.sh | scl enable devtoolset-3 bash 
CMD ["/run.sh"]


