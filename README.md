# Docker Image for ÁNYK/ABEVJAVA Fuckery

This is a convenience Docker image for running the abomination called ÁNYK
without having to pollute your own computer with ancient security nightmares
(also called Java by some).

Comes with the IGAZOL (by NAV) template. 

1. On macOS, follow [this guide](https://gist.github.com/H2CO3/736967dbdaa7dfc91f87304673eac642) to correctly set up XQuartz.
2. Install Docker.
3. Build the image using the provided convenience script: `./build-image.sh .`
4. Run the image using the provided convenience script: `./run-abevjava-docker.sh /path/to/userdata` - this will mount the `/path/to/userdata` directory under `/root/abevjava` in the running container.
5. The installers will run automatically. You need to re-install the program every time you launch the container, because the install directory is not mounted as a volume. **Do NOT change the default locations** offered by the installer.
6. Once the software is installed, use the `./abevjava.sh` script to launch it.

## Support for Multiple Templates

This repository comes with the `IGAZOL` template.
If you want to open other templates (`NAV_24T101` or such), download the necessary `.jar` file and put it in the `jars` directory. All the templates in the folder will be installed upon running `./run-abevjava-docker.sh`.
