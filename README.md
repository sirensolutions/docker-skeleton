# docker-skeleton

This is a generic docker configuration that can be used to build a basic docker image using a downloaded zipfile from the Siren support portal.

## Usage

Download the required siren-investigate zipfile from https://support.siren.io into the base of this repo and invoke docker-build with the name of the file passed as a build argument, e.g.:

```
docker build --build-arg="SIREN_ZIPFILE=siren-investigate-10.0.0-beta-3-linux-x86_64.zip" -t siren-investigate-local .
```

To test locally, run:

```
docker run -d -p 5606:5606 siren-investigate-local
```
