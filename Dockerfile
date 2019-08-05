FROM ros:melodic-ros-base-bionic

RUN apt-get update && apt-get install -q -y \
        dirmngr \
        gnupg2 \
        lsb-release \
        python3-pip \
        curl \
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
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# setup sources.list
RUN echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list

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
        ros-dashing-ros-core \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        ros-dashing-ros1-bridge \
        ros-dashing-example-interfaces \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ros2_ws/src

WORKDIR /root

COPY ./ros_entrypoint.sh /
CMD ["/ros_entrypoint.sh"]
