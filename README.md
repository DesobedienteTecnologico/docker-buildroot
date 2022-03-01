# Docker-Buildroot

With this docker image you don't need to install Buildroot and other packages in your main machine. Everthing is ready to use.


## Build image from Dockerfile

```
docker build . -t buildroot:v1
```

## Run from image
##### You will get a Terminator window from where you can start working.
I created a "shared" directory in **$HOME/Developing/ws** from where I get the final image and get access to all the buildroot files. You should make the same directory or delete that line, in case you don't want to use that function.
```
docker run -it --privileged --net=host --ipc=host \
--device=/dev/dri:/dev/dri \
-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
-v $HOME/Developing/ws/:/home/user/output \
buildroot:v1
```
