FROM ros:melodic-ros-base-bionic

RUN apt-get update && apt-get install -q -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        ros-melodic-tf* \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# ROS setting
RUN /bin/bash -c "mkdir -p catkin_ws/src"

RUN cd catkin_ws/src && /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_init_workspace"

RUN cd catkin_ws && /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make"

ENV ROS_PACKAGE_PATH=/root/catkin_ws:$ROS_PACKAGE_PATH

ENV ROS_WORKSPACE=/root/catkin_ws

# setup ros2 keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros2-latest.list

RUN apt-get update && apt-get install --no-install-recommends -y \
        git \
        python3-rospkg \
        python3-catkin-pkg \
        python3-colcon-common-extensions \
        python3-rosdep \
        python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN pip3 install -U \
    argcomplete

RUN apt-get update && apt-get install -y \
        ros-crystal-ros-core=0.6.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        ros-crystal-ros1-bridge \
        ros-crystal-example-interfaces \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ros2_ws/src

WORKDIR /root

COPY ./ros_entrypoint.sh /
CMD ["/ros_entrypoint.sh"]
