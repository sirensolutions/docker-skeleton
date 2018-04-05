# docker-skeleton

This is a generic docker configuration that can be used to build a basic docker
image using a downloaded zipfile from the support portal.

## Usage

Download the required siren-investigate zipfile into the base of this repo and
invoke docker-build with the name of the file passed as a build argument, e.g.:

```
docker build --file=Dockerfile --build-arg="SIREN_ZIPFILE=siren-investigate-10.0.0-beta-3-linux-x86_64.zip"
```
