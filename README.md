# docker-cloud9
A container image that is ready to have Cloud9 install via SSH

This is useful if you want to deploy Cloud9 to a container, rather than EC2 or other VM.

This is based on https://docs.aws.amazon.com/cloud9/latest/user-guide/sample-docker.html
with minor fixes dealing with dependency drift, etc...

## USAGE
Place an "authorized_keys" file in the current directory before building the container image; these keys will be authorized to ssh in as ubuntu

To test
```sudo docker run -d -it --expose 9090 -p 0.0.0.0:9090:22 --name cloud9 cloud9-image:latest```
