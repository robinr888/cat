FROM python:3.9-slim
MAINTAINER robin.r888@gmail.com
ARG USERNAME=flask
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY ./ /
## Combining the Run command to create a single layer. 
RUN pip3 install -r /requirements.txt && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID  $USERNAME && chown -R $USERNAME /startup.sh /app && chmod u+x /startup.sh 
WORKDIR /app/
# Run as non root user to meet security guidelines
USER flask
ENTRYPOINT ["/startup.sh"]