#!/bin/bash
set -e

source /opt/ros/melodic/setup.bash
source /opt/ros/crystal/setup.bash
#bash
ros2 run ros1_bridge dynamic_bridge --bridge-all-topics
