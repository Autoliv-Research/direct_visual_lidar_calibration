FROM koide3/gtsam_docker:humble

ARG USERNAME=username
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \

  && apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt-fast update \
  && apt-fast install -y --no-install-recommends \
  libomp-dev libgoogle-glog-dev libgflags-dev libatlas-base-dev libsuitesparse-dev \
  && apt-fast clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN git clone https://github.com/ceres-solver/ceres-solver \
  && mkdir ceres-solver/build \
  && cd ceres-solver/build \
  && cmake .. -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DUSE_CUDA=OFF \
  && make -j$(nproc) \
  && make install \
  && rm -rf /root/ceres-solver

# COPY . /root/ros2_ws/src/direct_visual_lidar_calibration

# WORKDIR /workspace

# RUN apt-fast update && \
#   rosdep install -i --from-paths src --simulate | \
#   sed '1d' | sed 's/apt-get install//' | sed 's/ //g' > /tmp/depends && \
#   xargs apt-fast install --no-install-recommends -y < /tmp/depends && \
#   apt-fast clean && \
#   rm -rf /var/lib/apt/lists/*

# RUN /bin/bash -c ". /opt/ros/humble/setup.bash; colcon build"

RUN echo "#!/bin/bash" >> /ros_entrypoint.sh \
  && echo "set -e" >> /ros_entrypoint.sh \
  && echo "source /opt/ros/humble/setup.bash" >> /ros_entrypoint.sh \
  # && echo "source /root/ros2_ws/install/setup.bash" >> /ros_entrypoint.sh \
  && echo 'exec "$@"' >> /ros_entrypoint.sh \
  && chmod a+x /ros_entrypoint.sh

# WORKDIR /root/ros2_ws/src/direct_visual_lidar_calibration

# ENTRYPOINT ["/ros_entrypoint.sh"]
# CMD ["bash"]

RUN echo 'source "/opt/ros/$ROS_DISTRO/setup.bash"' >> /home/$USERNAME/.bashrc
RUN mkdir /workspace && chown $USERNAME /workspace
USER $USERNAME